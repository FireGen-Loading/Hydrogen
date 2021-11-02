.PHONY: setup build

setup: 
	@echo "Starting setup..."
	./build/Setup.sh
build: 
	@echo "Building files..."
	./build/Build.sh
	@echo "Done!"