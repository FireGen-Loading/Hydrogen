echo "-------------------------------------"
echo "Installing deps..."
sudo apt install nasm

sudo apt update
sudo apt install build-essential
sudo apt install bison
sudo apt install flex
sudo apt install libgmp3-dev
sudo apt install libmpc-dev
sudo apt install libmpfr-dev
sudo apt install texinfo
echo "-------------------------------------"
echo "building deps..."

export TARGET=i386-elf
START="$PWD"
BINUTILS="$START/binutils"
BINSRC="$BINUTILS/src"
export GCC="$START/i386elfgcc"
export PATH="$PATH:$GCC/bin"
export PATH
echo "-------------------------------------"
echo $PATH
echo "-------------------------------------"
echo "getting binutil sources..."
mkdir "$BINUTILS"
mkdir "$BINSRC"

cd "$SRCc"
curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.35.1.tar.gz
echo "decompressing binutils source..."
tar xf binutils-2.35.1.tar.gz

echo "-------------------------------------"
echo "compiling binutils..."

mkdir "$BINUTILS/binutils-build"
cd "$BINUTILS/binutils-build"

$BINSRC/binutils-2.35.1/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$GCC 2>&1 | tee configure.log
sudo make all install 2>&1 | tee make.log

echo "-------------------------------------"
echo "getting gcc source..."
cd "$BINSRC"

curl -O https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
echo "decompressing gcc source..."
tar xf gcc-10.2.0.tar.gz

mkdir "$BINUTILS/gcc-build"
cd "$BINUTILS/gcc-build"
echo "-------------------------------------"
echo "Configure"
$BINSRC/gcc-10.2.0/configure --target=$TARGET --prefix="$GCC" --disable-nls --disable-libssp --enable-language=c++ --without-headers
echo "-------------------------------------"
echo "rebuilding gcc"
echo "-------------------------------------"
echo "MAKE ALL-GCC:"
sudo make all-gcc
echo "-------------------------------------"
echo "MAKE ALL-TARGET-LIBGCC:"
sudo make all-target-libgcc
echo "-------------------------------------"
echo "MAKE INSTALL-GCC:"
sudo make install-gcc
echo "-------------------------------------"
echo "MAKE INSTALL-TARGET-LIBGCC"
sudo make install-target-libgcc
echo "-------------------------------------"
echo "Exporting path $GCC"
echo "you might have to use the following command"
echo "export PATH=\$PATH:$GCC/bin"
export PATH="$PATH:$GCC/bin"