SRC="./src"
BUILD="./bin"
ASM="asm"

LINK="$BUILD/link"
ASMBUILD="$BUILD/$ASM"
CBUILD="$BUILD/c"

mkdir "$BUILD"
mkdir "$CBUILD"
mkdir "$ASMBUILD"
mkdir "$LINK"

FINALBUILD="$BUILD"

export PATH=$PATH:$PWD/i386elfgcc/bin

echo "Compiling c..."
echo "--------------------------"

KERNEL="kernel"

echo "$SRC/$KERNEL.c (-ffreestanding -m32 -g -c)"
i386-elf-gcc -ffreestanding -m32 -g -c "$SRC/$KERNEL.c" -o "$CBUILD/$KERNEL.o"

echo "Done"
echo "--------------------------"

ASMSRC="$SRC/$ASM"

BOOT="boot"
NULL="Null"
ENTRY="kernel_entry"

echo "Compiling asm..."
echo "--------------------------"

echo "$ASMSRC/$BOOT.nasm (no flags)"
nasm "$ASMSRC/$BOOT.nasm" -o "$ASMBUILD/$BOOT.o"
echo "$ASMSRC/$NULL.nasm (no flags)"
nasm "$ASMSRC/$NULL.nasm" -o "$ASMBUILD/$NULL.o"
echo "$ASMSRC/$NULL.nasm (-f elf)"
nasm "$ASMSRC/$ENTRY.nasm" -f elf -o "$ASMBUILD/$ENTRY.o"

echo "Done!"
echo "--------------------------"

echo "Linking..."
echo "--------------------------"
FULLLINK=FullLinkKernel

i386-elf-ld -o "$LINK/$KERNEL.bin" -Ttext 0x1000 "$ASMBUILD/$ENTRY.o" "$CBUILD/$KERNEL.o" --oformat binary
echo "Linking $ASMBUILD/$ENTRY.o & $CBUILD/$KERNEL.o to $LINK/$KERNEL.bin"

cat "$ASMBUILD/$BOOT.o" "$LINK/$KERNEL.bin" > "$LINK/$FULLLINK.bin"
echo "Concating $LINK/$KERNEL.bin onto $ASMBUILD/$BOOT.o"

cat "$LINK/$FULLLINK.bin" "$ASMBUILD/$NULL.o" > "$FINALBUILD/kernel.bin"
echo "Concating $ASMBUILD/$NULL.o onto $LINK/$FULLLINK.bin"
echo "--------------------------"