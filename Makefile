.PHONY: setup build clean

setup: 
	@echo "Starting setup..."
	./build/Setup.sh
build: 
	@echo "Building files..."
	./build/Build.sh
	@echo "Done!"
clean:
	rm -r binutils/src