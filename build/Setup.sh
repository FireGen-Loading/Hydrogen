@echo "Installing deps..."
sudo apt install nasm

sudo apt update
sudo apt install build-essential
sudo apt install bison
sudo apt install flex
sudo apt install libgmp3-dev
sudo apt install libmpc-dev
sudo apt install libmpfr-dev
sudo apt install texinfo
@echo "building deps..."

ORIGIN="$PWD"
utils="$ORIGIN/binutils"
export PREFIX="$ORIGIN/i386elfgcc"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"

@echo "getting binutil sources..."
mkdir "$utils"
mkdir "$utils/src"

cd "$utils/src"
curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.35.1.tar.gz
tar xf binutils-2.35.1.tar.gz
cd "$utils"

@echo "compiling binutils..."

mkdir "$utils/binutils-build"
cd "$utils/binutils-build"
../binutils-2.35.1/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
sudo make all install 2>&1 | tee make.log

@echo "getting gcc source..."
cd "$utils"
curl -O https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz
tar xf gcc-10.2.0.tar.gz

mkdir "$utils/gcc-build"
cd "$utils/gcc-build"

echo Configure
../gcc-10.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-language=c++ --without-headers
@echo "rebuilding gcc"
echo MAKE ALL-GCC:
sudo make all-gcc

echo MAKE ALL-TARGET-LIBGCC:
sudo make all-target-libgcc

echo MAKE INSTALL-GCC:
sudo make install-gcc

echo MAKE INSTALL-TARGET-LIBGCC
sudo make install-target-libgcc

export PATH=$PATH:/usr/local/i386elfgcc/bin