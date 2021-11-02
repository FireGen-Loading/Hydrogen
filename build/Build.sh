export SRC="./src"
ASM="/asm"
export ASMSRC="$SRC/$ASM"
export BUILD="./bin"
export ASMBUILD="$BUILD/$ASM"
export CBUILD="$BUILD/c"
export LINK="$BUILD/link"
export FINALBUILD="$BUILD"

export ENTRY="kernel_entry"
export KERNEL="kernel"
export NULL="Null"
export BOOT="boot"

export PATH=$PATH:/usr/local/i386elfgcc/bin
mkdir "$BUILD"
mkdir "$CBUILD"
mkdir "$ASMBUILD"
mkdir "$LINK"

i386-elf-gcc -ffreestanding -m32 -g -c "$SRC/$KERNEL.c" -o "$CBUILD/$KERNEL.o"

nasm "$ASMSRC/$BOOT.nasm" -o "$ASMBUILD/$BOOT.o"
nasm "$ASMSRC/$NULL.nasm" -o "$ASMBUILD/$NULL.o"
nasm "$ASMSRC/$ENTRY.nasm" -f elf -o "$ASMBUILD/$ENTRY.o"

FULLLINK=FullLinkKernel.bin
i386-elf-ld -o "$LINK/$KERNEL.bin" -Ttext 0x1000 "$ASMBUILD/$ENTRY.o" "$CBUILD/$KERNEL.o" --oformat binary
cat "$ASMBUILD/$BOOT.o" "$LINK/$KERNEL.bin" > "$LINK/$FULLLINK.bin"
cat "$LINK/$FULLLINK.bin" "$ASMBUILD/$NULL.o" > "$FINALBUILD/kernel.bin"
