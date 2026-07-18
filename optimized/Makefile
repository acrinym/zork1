PYTHON ?= python3
ZILF ?= zilf
ZAPF ?= zapf
INTERPRETER ?= dfrotz

REPO_ROOT := $(abspath ..)
BUILD_DIR := $(CURDIR)/build
WORK_DIR := $(BUILD_DIR)/src
STORY := $(BUILD_DIR)/zork1-optimized.z3
BASELINE := $(REPO_ROOT)/COMPILED/zork1.z3

.PHONY: all stage audit compile verify smoke clean

all: audit compile verify

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
	cd "$(WORK_DIR)" && "$(ZILF)" zork1.zil
	"$(ZAPF)" "$(WORK_DIR)/zork1.zap" "$(STORY)"

verify: compile
	$(PYTHON) tools/verify_story.py "$(STORY)" \
		--expect-version 3 \
		--baseline "$(BASELINE)"

smoke: verify
	$(PYTHON) tools/run_smoke.py "$(STORY)" \
		--interpreter "$(INTERPRETER)" \
		--commands tests/smoke_commands.txt \
		--expect tests/smoke_expectations.txt

clean:
	$(PYTHON) -c "from pathlib import Path; import shutil; p=Path(r'$(BUILD_DIR)'); shutil.rmtree(p) if p.exists() else None"
