.PHONY: setup build clean import

setup: 
	@echo "Starting setup..."
	bash ./build/Setup.sh
build: 
	@echo "Building files..."
	bash ./build/Build.sh
	@echo "Done!"
clean:
	rm -r binutils/src
import:
	bash ./build/path.sh