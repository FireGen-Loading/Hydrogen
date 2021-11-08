.PHONY: setup build clean import

asm = nasm
gcc = i386-elf-gcc
gcc_arg = -ffreestanding -m32 -g -c

srcDir = "./src"
asmDir = "${srcDir}/asm"
CDir = "${srcDir}"

binDir = "./bin"
binAsm = "${binDir}/asm"
binC = "${binDir}/c"


setup: 
	@echo "Starting setup..."
	bash ./scripts/Setup.sh

build: 
	@echo "Starting build..."
	bash ./scripts/Build.sh
	@echo "Done!"
clean:
	@echo "cleaning trash files..."
	bash ./scripts/clean.sh
	@echo "done cleaning"
import:
	bash ./scripts/path.sh