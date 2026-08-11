#!/usr/bin/env bash
set -euo pipefail
ROOT="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
BUILD="$ROOT/glulx/build/creative-natural-play-1245"
STORY="$BUILD/zork1-glulx-creative-natural-play.ulx"
GLULXE_BIN="$(realpath .tooling/glulxe/glulxe)"
[[ -x "$GLULXE_BIN" && -f "$STORY" ]]

cat > "$BUILD/realtime-west-house.txt" <<'EOF'
yell at mailbox
shout at mailbox
kill mailbox
self
put self into mailbox
speak xyzzy
say xyzzy
say haha
say hello
speak blorp flargle
what is the ground beneath made of?
scream at self
yell at you
yell at zork
help
command
command mailbox
moo
bark
talk
talk to self
drink mailbox
open mailbox, take leaflet
throw leaflet at mailbox
get leaflet
yell at leaflet
take leaflet out of mailbox after opening mailbox
quit
yes
EOF

timeout 30s "$GLULXE_BIN" --rngseed 260811 "$STORY" \
  < "$BUILD/realtime-west-house.txt" > "$BUILD/realtime-west-house-transcript.txt" 2>&1 || true

T="$BUILD/realtime-west-house-transcript.txt"
cat "$T"
test "$(grep -F -c 'You yell at the small mailbox. It does not respond.' "$T")" -ge 2
grep -F 'fighting a small mailbox?' "$T"
! grep -F 'Suicide is not the answer.' "$T"
grep -F 'You cannot put yourself into the small mailbox.' "$T"
test "$(grep -F -c 'You say "xyzzy."' "$T")" -ge 2
grep -F 'You say "haha."' "$T"
grep -F 'You say "hello."' "$T"
grep -F 'You say "blorp flargle."' "$T"
! grep -F 'I don'"'"'t know the word "speak"' "$T"
! grep -F 'I don'"'"'t know the word "made"' "$T"
! grep -F 'I don'"'"'t know the word "of?"' "$T"
grep -F 'There is nothing but dust there.' "$T"
grep -F 'You yell at yourself. You hear yourself perfectly well.' "$T"
grep -F 'You yell at Zork. At your service!' "$T"
grep -F 'Try direct commands such as LOOK, INVENTORY, TAKE, OPEN, TALK TO, SAY, or YELL AT.' "$T"
grep -F 'You are already in command of yourself.' "$T"
grep -F "You can't command the small mailbox." "$T"
grep -F 'Moooo.' "$T"
grep -F 'Woof!' "$T"
grep -F 'Whom do you want to talk to?' "$T"
grep -F 'Talking to yourself is said to be a sign of impending mental collapse.' "$T"
grep -F 'The small mailbox is not something you can drink.' "$T"
grep -F 'You yell at the leaflet. It does not respond.' "$T"
grep -F 'Split sequential actions with a comma or THEN.' "$T"
! grep -Fi 'the you' "$T"
! grep -Fi 'the yourself' "$T"
! grep -F "you don't even have the you" "$T"
