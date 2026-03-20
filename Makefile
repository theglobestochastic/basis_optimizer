# Variables
PYTHON = python
TECTONIC = tectonic
REPORT_DIR = reports
SRC_DIR = src

.PHONY: all build run report clean
# 1. Build, Run, and Generate PDF
all: build run report
# 2. INFRASTRUCTURE: Compile Cython into C-Extensions
build:
	@echo "[BUILD] Compiling Cython Analytics..."
	$(PYTHON) setup.py build_ext --inplace
	@echo "[DONE] C-Extensions Ready."

# 3. THE ENGINE: Stochastic simulation :
	@echo "[EXEC] Running GlobeStochastic Node..."
	$(PYTHON) $(SRC_DIR)/main.py
	@echo "[DONE] Analysis Complete."
# 4.  LaTeX PDF
report:
	@echo "[DOCS] Generating Technical Brief via Tectonic..."
	cd $(REPORT_DIR) && $(TECTONIC) technical_brief_01.tex
	@echo "[DONE] PDF Generated in $(REPORT_DIR)/"

# 5.  Clean up temporary build files:
	@echo "[CLEAN] Removing build artifacts..."
	rm -rf build/
	rm -f $(SRC_DIR)/*.so $(SRC_DIR)/*.c
	rm -f $(REPORT_DIR)/*.log $(REPORT_DIR)/*.aux $(REPORT_DIR)/*.pdf
	@echo "[DONE] Workspace Cleaned."
