#!/bin/sh
set -e

[ -d $BUILDDIR/newlib ] && rm -rf $BUILDDIR/newlib

mkdir -p $BUILDDIR/newlib
cd $BUILDDIR/newlib

export PATH=$INSTALLDIR/bin:$PATH
export CROSS=${PROGRAM_PREFIX}elf-
export CC_FOR_TARGET=${CROSS}gcc-${GCCVER}.exe
export LD_FOR_TARGET=${CROSS}ld.exe
export AS_FOR_TARGET=${CROSS}as.exe
export AR_FOR_TARGET=${CROSS}ar.exe
export RANLIB_FOR_TARGET=${CROSS}ranlib.exe

export newlib_cflags="${newlib_cflags} -DPREFER_SIZE_OVER_SPEED -D__OPTIMIZE_SIZE__"

#$SRCDIR/newlib-${NEWLIBVER}/configure --prefix=$INSTALLDIR \
../../source/newlib-${NEWLIBVER}/configure --prefix=$INSTALLDIR \
	--target=$TARGETMACH --build=$BUILDMACH --host=$HOSTMACH \
	--enable-newlib-nano-malloc --enable-target-optspace

make all -j${NCPU}
make install -j${NCPU}
