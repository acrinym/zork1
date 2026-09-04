"""Qualification for the reusable Extended Zork World Truth system."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from tools.world_truth.audit import audit_summary, audit_world
from tools.world_truth.config import ProbeRule, State, TruthConfig, load_config
from tools.world_truth.cli import validate_source_contract
from tools.world_truth.extract import extract_world
from tools.world_truth.report import load_baseline, write_baseline, write_json, write_markdown
from tools.world_truth.runtime import _prompt_segment, build_probes, classify_response, load_probe_plan, save_probe_plan


FIXTURE = '''<VERSION ZIP>
<INSERT-FILE "GRAMMAR" T>
<ROOM LAB
 (IN ROOMS)
 (DESC "Truth Laboratory")
 (LDESC "A brass door and a painted moon occupy the laboratory wall.")
 (NORTH TO HALL)
 (PSEUDO "MOON" MOON-F)
 (GLOBAL LAB-DOOR)>
<ROOM HALL (IN ROOMS) (DESC "Hall") (SOUTH TO LAB)>
<OBJECT LAB-DOOR
 (IN LOCAL-GLOBALS)
 (SYNONYM DOOR)
 (ADJECTIVE BRASS)
 (DESC "brass door")
 (FLAGS DOORBIT OPENBIT)
 (ACTION LAB-DOOR-F)>
<ROUTINE LAB-DOOR-F ()
 <COND (<VERB? EXAMINE OPEN CLOSE>
        <TELL "The door answers specifically." CR>)>>
<ROUTINE MOON-F () <COND (<VERB? EXAMINE> <TELL "Only paint." CR>)>>
'''

GRAMMAR = '''<BUZZ A AN THE>
<SYNTAX EXAMINE OBJECT = V-EXAMINE>
<SYNONYM EXAMINE X INSPECT>
<SYNTAX OPEN OBJECT (FIND OPENBIT) = V-OPEN>
<SYNTAX CLOSE OBJECT (FIND OPENBIT) = V-CLOSE>
<SYNTAX ENTER OBJECT = V-ENTER>
<ROUTINE V-EXAMINE () <TELL "Examined." CR>>
<ROUTINE V-OPEN () <TELL "Opened." CR>>
<ROUTINE V-CLOSE () <TELL "Closed." CR>>
<ROUTINE V-ENTER () <TELL "Entered." CR>>
'''


class WorldTruthFixture(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        (self.root / "zork1.zil").write_text(FIXTURE, encoding="utf-8")
        (self.root / "grammar.zil").write_text(GRAMMAR, encoding="utf-8")

    def tearDown(self) -> None:
        self.temp.cleanup()

    def test_extracts_complete_lineage_graph_grammar_and_parts_of_speech(self) -> None:
        model = extract_world(self.root)
        by_id = {item.id: item for item in model.entities}
        self.assertEqual([item["path"] for item in model.source_files], ["zork1.zil", "grammar.zil"])
        self.assertEqual(by_id["LAB"].exits["NORTH"]["target"], "HALL")
        self.assertEqual(by_id["LAB-DOOR"].container, "LOCAL-GLOBALS")
        self.assertIn("DOOR", model.vocabulary["nouns"])
        self.assertIn("BRASS", model.vocabulary["adjectives"])
        self.assertIn("INSPECT", model.vocabulary["verbs"])
        self.assertIn("THE", model.vocabulary["buzz"])
        examine = next(item for item in model.grammar if item.verb == "EXAMINE")
        self.assertEqual(examine.template, ["examine", "{object}"])

    def test_promotes_pseudo_scenery_and_maps_described_words(self) -> None:
        model = extract_world(self.root)
        pseudo = next(item for item in model.entities if item.kind == "pseudo")
        self.assertEqual(pseudo.container, "LAB")
        self.assertEqual(pseudo.synonyms, ["MOON"])
        refs = {(item.room, item.word): item for item in model.prose_references}
        self.assertEqual(refs[("LAB", "moon")].status, "mapped")
        self.assertEqual(refs[("LAB", "door")].mapped_entities, ["LAB-DOOR"])
        self.assertEqual(refs[("LAB", "wall")].status, "candidate-unmapped")

    def test_interaction_matrix_distinguishes_explicit_and_generic_evidence(self) -> None:
        model = audit_world(extract_world(self.root))
        rows = {(item.subject, item.verb): item.status for item in model.interactions if item.room == "LAB"}
        self.assertEqual(rows[("LAB-DOOR", "EXAMINE")], "explicit")
        self.assertEqual(rows[("LAB-DOOR", "OPEN")], "explicit")
        summary = audit_summary(model)
        self.assertEqual(summary["rooms"], 2)
        self.assertEqual(summary["pseudo_environment"], 1)
        self.assertGreater(summary["prose_references"], 0)

    def test_findings_are_traceable_and_baseline_never_hides_them(self) -> None:
        model = audit_world(extract_world(self.root))
        wall = next(item for item in model.findings if item.evidence.get("word") == "wall")
        self.assertEqual(wall.code, "described-noun-unmapped")
        self.assertEqual(len(wall.fingerprint), 20)
        baseline = self.root / "baseline.json"
        write_baseline(baseline, model)
        rerun = audit_world(extract_world(self.root), baseline=load_baseline(baseline))
        known = next(item for item in rerun.findings if item.fingerprint == wall.fingerprint)
        self.assertTrue(known.baseline)
        self.assertIn(known, rerun.findings)

    def test_fingerprint_ignores_path_and_line_rebasing(self) -> None:
        first = audit_world(extract_world(self.root))
        before = next(item for item in first.findings if item.evidence.get("word") == "wall")
        (self.root / "rebased.zil").write_text('; inserted comment\n\n' + FIXTURE, encoding="utf-8")
        second = audit_world(extract_world(self.root, "rebased.zil"))
        after = next(item for item in second.findings if item.evidence.get("word") == "wall")
        self.assertNotEqual(before.evidence["path"], after.evidence["path"])
        self.assertNotEqual(before.evidence["line"], after.evidence["line"])
        self.assertEqual(before.fingerprint, after.fingerprint)

    def test_raw_prose_token_is_not_replaced_by_stem(self) -> None:
        (self.root / "zork1.zil").write_text(FIXTURE.replace("painted moon", "painted lies"), encoding="utf-8")
        model = extract_world(self.root)
        ref = next(item for item in model.prose_references if item.word == "lies")
        self.assertEqual(ref.phrase, "lies")
        self.assertEqual(ref.match_key, "lie")

    def test_prsa_v_atoms_count_as_explicit_handlers(self) -> None:
        source = FIXTURE.replace(
            '<COND (<VERB? EXAMINE OPEN CLOSE>',
            '<COND (<EQUAL? ,PRSA ,V?EXAMINE ,V?OPEN ,V?CLOSE>',
        )
        (self.root / "zork1.zil").write_text(source, encoding="utf-8")
        model = audit_world(extract_world(self.root))
        rows = {(item.subject, item.verb): item.status for item in model.interactions if item.room == "LAB"}
        self.assertEqual(rows[("LAB-DOOR", "EXAMINE")], "explicit")
        self.assertEqual(rows[("LAB-DOOR", "OPEN")], "explicit")

    def test_reports_are_machine_and_human_readable(self) -> None:
        model = audit_world(extract_world(self.root))
        json_path, markdown_path = self.root / "world.json", self.root / "report.md"
        write_json(json_path, model)
        write_markdown(markdown_path, model)
        self.assertEqual(json.loads(json_path.read_text())["format_version"], "1.0")
        report = markdown_path.read_text()
        self.assertIn("# World Truth Audit", report)
        self.assertIn("described-noun-unmapped", report)


class ContractsAndRuntime(unittest.TestCase):
    def test_config_states_expectations_and_narrow_ignores(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "truth.toml"
            path.write_text('''format_version = 1
[[states]]
id = "open"
room = "lab"
setup = ["north"]
[[expectations]]
room = "lab"
subject = "door"
verbs = ["open"]
rationale = "visible hinge"
[[ignores]]
code = "described-noun-unmapped"
room = "lab"
word = "blue"
rationale = "reviewed adjective"
''', encoding="utf-8")
            config = load_config(path)
            self.assertEqual(config.states[0].room, "LAB")
            self.assertEqual(config.expectations[0].verbs, ["OPEN"])
            self.assertEqual(config.ignores[0].word, "blue")

    def test_response_classifier_separates_parser_lies(self) -> None:
        self.assertEqual(classify_response("You can't see any moon here!", "examine moon"), "not-visible")
        self.assertEqual(classify_response("I don't know the word 'moon'.", "examine moon"), "unknown-word")
        self.assertEqual(classify_response("The moon is flaking paint.", "examine moon"), "recognized-specific")
        self.assertEqual(classify_response("The window is boarded.", "open window", ["window"]), "subject-refusal")
        self.assertEqual(classify_response("You can't do that.", "take wall", ["wall"]), "generic-refusal")
        transcript = "Target Room\n> Target RoomScore: 0Moved.\n> Wrong RoomScore: 0Response.\n>"
        self.assertNotIn("Target Room", _prompt_segment(transcript, 2))

    def test_pseudo_expectation_cannot_borrow_a_different_room_state(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "zork1.zil").write_text(FIXTURE, encoding="utf-8")
            (root / "grammar.zil").write_text(GRAMMAR, encoding="utf-8")
            config_path = root / "truth.toml"
            config_path.write_text('''format_version = 1
[[states]]
id = "wrong"
room = "HALL"
setup = ["north"]
[[expectations]]
room = "LAB"
subject = "LAB::PSEUDO::MOON-F"
state = "wrong"
verbs = ["EXAMINE"]
rationale = "wrong-room guard"
''', encoding="utf-8")
            model = audit_world(extract_world(root), load_config(config_path))
            self.assertIn("pseudo-probe-wrong-room", {item.code for item in model.findings})

    def test_probe_plan_is_deterministic_and_state_anchored(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "zork1.zil").write_text(FIXTURE, encoding="utf-8")
            (root / "grammar.zil").write_text(GRAMMAR, encoding="utf-8")
            config_path = root / "truth.toml"
            config_path.write_text('''format_version = 1
[[states]]
id = "lab-clean"
room = "LAB"
setup = []
expected_title = "Truth Laboratory"
[[expectations]]
room = "LAB"
subject = "LAB-DOOR"
state = "lab-clean"
verbs = ["EXAMINE"]
rationale = "door is described"
''', encoding="utf-8")
            config = load_config(config_path)
            model = audit_world(extract_world(root), config)
            probes = build_probes(model, config)
            authored = next(item for item in probes if item.subject == "LAB-DOOR" and item.verb == "EXAMINE")
            self.assertEqual(authored.command, "examine door")
            plan = root / "plan.json"
            save_probe_plan(plan, probes)
            self.assertEqual(load_probe_plan(plan), probes)

    def test_two_object_and_actor_templates_are_real_probe_kinds(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            source = FIXTURE + '''
<OBJECT ROPE (IN LAB) (SYNONYM ROPE) (DESC "rope")>
<OBJECT MARA (IN LAB) (SYNONYM MARA) (DESC "Mara") (FLAGS ACTORBIT)>
'''
            grammar = GRAMMAR + '''
<SYNTAX TIE UP OBJECT WITH OBJECT = V-TIE>
<SYNTAX TELL OBJECT ABOUT OBJECT = V-TELL>
<SYNTAX TAKE OBJECT = V-TAKE>
<ROUTINE V-TIE () <TELL "Tied." CR>>
<ROUTINE V-TELL () <TELL "Discussed." CR>>
<ROUTINE V-TAKE () <TELL "Taken." CR>>
'''
            (root / "zork1.zil").write_text(source, encoding="utf-8")
            (root / "grammar.zil").write_text(grammar, encoding="utf-8")
            config_path = root / "truth.toml"
            config_path.write_text('''format_version = 1
[[states]]
id = "lab"
room = "LAB"
setup = []
[[expectations]]
room = "LAB"
subject = "LAB-DOOR"
other_subject = "ROPE"
kind = "two-object"
command_template = "tie up {object} with {other}"
state = "lab"
verbs = ["TIE"]
rationale = "two real subjects"
[[expectations]]
room = "LAB"
subject = "MARA"
other_subject = "ROPE"
kind = "conversation"
command_template = "ask {object} about {other}"
state = "lab"
verbs = ["ASK"]
rationale = "conversation is not an object affordance"
[[expectations]]
room = "LAB"
subject = "ROPE"
actor = "MARA"
kind = "actor-command"
command_template = "{actor}, take {object}"
state = "lab"
verbs = ["TAKE"]
rationale = "direct address changes WINNER"
''', encoding="utf-8")
            config = load_config(config_path)
            probes = build_probes(audit_world(extract_world(root), config), config)
            commands = {item.kind: item.command for item in probes if item.basis[0].startswith("authored:")}
            self.assertEqual(commands["two-object"], "tie up door with rope")
            self.assertEqual(commands["conversation"], "ask mara about rope")
            self.assertEqual(commands["actor-command"], "mara, take rope")

    def test_probe_policy_is_flag_and_verb_driven(self) -> None:
        config = TruthConfig(
            probe_rules=[ProbeRule(["OPEN"], ["recognized-specific", "subject-refusal"], ["DOORBIT"])],
            policy={"probe_inferred_interactions": True},
        )
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "zork1.zil").write_text(FIXTURE, encoding="utf-8")
            (root / "grammar.zil").write_text(GRAMMAR, encoding="utf-8")
            config.states.append(State("lab", "LAB", []))
            model = audit_world(extract_world(root), config)
            probe = next(item for item in build_probes(model, config, {"explicit"}) if item.subject == "LAB-DOOR" and item.verb == "OPEN")
            self.assertIn("subject-refusal", probe.allowed)

    def test_full_map_auto_reach_probes_inferred_nouns_without_authored_states(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            source = FIXTURE.replace(
                '(NORTH TO HALL)',
                '(NORTH TO HALL)\n (EAST TO VAULT IF SECRET-OPEN)',
            ).replace(
                '<ROOM HALL (IN ROOMS) (DESC "Hall") (SOUTH TO LAB)>',
                '<ROOM HALL (IN ROOMS) (DESC "Hall") (SOUTH TO LAB) (LDESC "A hanging tapestry.")>\n'
                '<OBJECT TAPESTRY (IN HALL) (SYNONYM TAPESTRY) (DESC "tapestry")>\n'
                '<ROOM VAULT (IN ROOMS) (DESC "Vault")>',
            )
            (root / "zork1.zil").write_text(source, encoding="utf-8")
            (root / "grammar.zil").write_text(GRAMMAR, encoding="utf-8")
            config = TruthConfig()
            model = audit_world(extract_world(root), config)
            self.assertIn("room-no-unconditional-route", {item.code for item in model.findings})
            self.assertTrue(any(item.room == "VAULT" and item.code == "room-no-unconditional-route" for item in model.findings))
            self.assertTrue(any(item.status == "described-unmapped" and item.word == "wall" for item in model.interactions))
            probes = build_probes(model, config)
            rooms = {item.room for item in probes}
            self.assertIn("LAB", rooms)
            self.assertIn("HALL", rooms)
            self.assertNotIn("VAULT", rooms)
            self.assertTrue(any(item.command == "examine door" and item.state == "reach-lab" for item in probes))
            self.assertTrue(any(item.command == "examine tapestry" and item.setup == ["north"] for item in probes))
            self.assertTrue(any(item.command == "examine wall" and "not-visible" in item.allowed for item in probes))

    def test_inferred_probes_run_in_every_non_dark_state_for_a_room(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "zork1.zil").write_text(FIXTURE, encoding="utf-8")
            (root / "grammar.zil").write_text(GRAMMAR, encoding="utf-8")
            config = TruthConfig(states=[
                State("lab-a", "LAB", []),
                State("lab-b", "LAB", ["look"]),
                State("lab-dark", "LAB", ["look"], light="dark"),
            ])
            probes = build_probes(audit_world(extract_world(root), config), config)
            states = {item.state for item in probes if item.subject == "LAB-DOOR" and item.verb == "EXAMINE"}
            self.assertEqual(states, {"lab-a", "lab-b"})


class RepositoryQualification(unittest.TestCase):
    def test_repository_source_has_no_structural_truth_errors(self) -> None:
        root = Path(__file__).resolve().parents[1]
        model = audit_world(extract_world(root), TruthConfig())
        errors = [item for item in model.findings if item.severity == "error"]
        self.assertEqual(errors, [], [item.message for item in errors])

    def test_product_policy_rejects_unstaged_historical_root(self) -> None:
        root = Path(__file__).resolve().parents[1]
        config = load_config(root / "world-truth.toml")
        with self.assertRaisesRegex(ValueError, "staging receipt"):
            validate_source_contract(root, extract_world(root), config)

    def test_product_policy_accepts_receipted_required_lineage(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "zork1.zil").write_text('<INSERT-FILE "empire_nouns" T>\n', encoding="utf-8")
            (root / "empire_nouns.zil").write_text('<ROOM TEST (IN ROOMS)>\n', encoding="utf-8")
            (root / "STAGING-RECEIPT.json").write_text(json.dumps({"edition": "test", "release": 1}), encoding="utf-8")
            config = TruthConfig(policy={"required_staging_receipt": True, "required_includes": ["empire_nouns"]})
            validate_source_contract(root, extract_world(root), config)

    def test_contradiction_codes_cover_duplicates_ambiguity_adjacent_and_invisible(self) -> None:
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "zork1.zil").write_text('''<ROOM A (IN ROOMS) (LDESC "A ghost, a bell, and a key wait.") (EAST TO B) (GLOBAL GHOST KEY-1 KEY-2)>
<ROOM B (IN ROOMS) (WEST TO A)>
<OBJECT GHOST (IN LOCAL-GLOBALS) (SYNONYM GHOST) (DESC "ghost") (FLAGS INVISIBLE)>
<OBJECT KEY-1 (IN LOCAL-GLOBALS) (SYNONYM KEY) (DESC "first key")>
<OBJECT KEY-2 (IN LOCAL-GLOBALS) (SYNONYM KEY) (DESC "second key")>
<OBJECT BELL (IN B) (SYNONYM BELL) (DESC "bell")>
<OBJECT BELL (IN B) (SYNONYM BELL) (DESC "replacement bell")>
''', encoding="utf-8")
            codes = {item.code for item in audit_world(extract_world(root)).findings}
            self.assertIn("duplicate-entity-id", codes)
            self.assertIn("ambiguous-synonym-in-scope", codes)
            self.assertIn("described-noun-adjacent-only", codes)
            self.assertIn("described-noun-only-invisible", codes)

    def test_schemas_are_versioned_and_require_evidence(self) -> None:
        root = Path(__file__).resolve().parents[1] / "reference/world-truth"
        world = json.loads((root / "world-model.schema.json").read_text())
        probes = json.loads((root / "probe-plan.schema.json").read_text())
        self.assertEqual(world["properties"]["format_version"]["const"], "1.0")
        self.assertIn("findings", world["required"])
        self.assertEqual(probes["properties"]["format_version"]["const"], "1.0")


if __name__ == "__main__":
    unittest.main()
