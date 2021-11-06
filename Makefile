.PHONY: setup build clean import

setup: 
	@echo "Starting setup..."
	bash ./scripts/Setup.sh
build: 
	@echo "Building files..."
	bash ./scripts/Build.sh
	@echo "Done!"
clean:
	@echo "cleaning trash files..."
	bash ./scripts/clean.sh
	@echo "done cleaning"
import:
	bash ./scripts/path.sh