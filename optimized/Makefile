PYTHON ?= python3
ZILF ?= zilf
ZAPF ?= zapf
INTERPRETER ?= dfrotz

REPO_ROOT := $(abspath ..)
BUILD_DIR := $(CURDIR)/build
WORK_DIR := $(BUILD_DIR)/src
STORY := $(BUILD_DIR)/zork1-optimized.z3
BASELINE := $(REPO_ROOT)/COMPILED/zork1.z3

.PHONY: all selftest stage audit compile verify smoke clean

all: selftest audit compile verify

selftest:
	$(PYTHON) -m unittest discover -s tests -p 'test_*.py' -v

stage:
	$(PYTHON) tools/stage_source.py \
		--repo-root "$(REPO_ROOT)" \
		--destination "$(WORK_DIR)"

audit: stage
	@mkdir -p "$(BUILD_DIR)"
	$(PYTHON) tools/zil_smell_check.py \
		--source "$(WORK_DIR)" \
		--json "$(BUILD_DIR)/smell-report.json"

compile: audit
	$(PYTHON) tools/build_story.py \
		--source "$(WORK_DIR)" \
		--output "$(STORY)" \
		--zilf "$(ZILF)" \
		--zapf "$(ZAPF)"

verify: compile
	$(PYTHON) tools/verify_story.py "$(STORY)" \
		--expect-version 3 \
		--baseline "$(BASELINE)" \
		--json "$(BUILD_DIR)/story-report.json"

smoke: verify
	$(PYTHON) tools/run_smoke.py "$(STORY)" \
		--interpreter "$(INTERPRETER)" \
		--commands tests/smoke_commands.txt \
		--expect tests/smoke_expectations.txt

clean:
	$(PYTHON) -c "from pathlib import Path; import shutil; p=Path(r'$(BUILD_DIR)'); shutil.rmtree(p) if p.exists() else None"
