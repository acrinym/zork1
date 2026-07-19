PYTHON ?= python3
ZILF ?= zilf
ZAPF ?= zapf
INTERPRETER ?= dfrotz
RELEASE ?= 121
SERIAL ?= 260719

REPO_ROOT := $(abspath ..)
TOOLS_DIR := $(REPO_ROOT)/optimized/tools
BUILD_DIR := $(CURDIR)/build
WORK_DIR := $(BUILD_DIR)/src
STORY := $(BUILD_DIR)/zork1-expanded.z3
BASELINE := $(REPO_ROOT)/COMPILED/zork1.z3

.PHONY: all stage audit compile verify smoke clean

all: audit compile verify

stage:
	$(PYTHON) $(TOOLS_DIR)/stage_source.py \
		--repo-root "$(REPO_ROOT)" \
		--destination "$(WORK_DIR)" \
		--allowed-root "$(BUILD_DIR)" \
		--overrides "$(CURDIR)/overrides" \
		--patches "$(CURDIR)/patches"

audit: stage
	@mkdir -p "$(BUILD_DIR)"
	$(PYTHON) $(TOOLS_DIR)/zil_smell_check.py \
		--source "$(WORK_DIR)" \
		--json "$(BUILD_DIR)/smell-report.json"

compile: audit
	$(PYTHON) $(TOOLS_DIR)/build_story.py \
		--source "$(WORK_DIR)" \
		--output "$(STORY)" \
		--zilf "$(ZILF)" \
		--zapf "$(ZAPF)" \
		--release "$(RELEASE)" \
		--serial "$(SERIAL)"

verify: compile
	$(PYTHON) $(TOOLS_DIR)/verify_story.py "$(STORY)" \
		--expect-version 3 \
		--expect-release "$(RELEASE)" \
		--expect-serial "$(SERIAL)" \
		--baseline "$(BASELINE)" \
		--json "$(BUILD_DIR)/story-report.json"

smoke: verify
	$(PYTHON) $(TOOLS_DIR)/run_smoke.py "$(STORY)" \
		--interpreter "$(INTERPRETER)" \
		--commands tests/smoke_commands.txt \
		--expect tests/smoke_expectations.txt

clean:
	$(PYTHON) -c "from pathlib import Path; import shutil; p=Path(r'$(BUILD_DIR)'); shutil.rmtree(p) if p.exists() else None"
