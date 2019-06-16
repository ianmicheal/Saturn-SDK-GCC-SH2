#!/bin/bash
set -e

[ -d $BUILDDIR/binutils ] && rm -rf $BUILDDIR/binutils

mkdir -p $BUILDDIR/binutils
cd $BUILDDIR/binutils

export CFLAGS=${BINUTILS_CFLAGS}
export CXXFLAGS="-s"

$SRCDIR/binutils-${BINUTILSVER}/configure \
	--disable-werror --host=$HOSTMACH --build=$BUILDMACH --target=$TARGETMACH \
	--prefix=$INSTALLDIR --with-sysroot=$SYSROOTDIR \
	--program-prefix=${PROGRAM_PREFIX} --disable-nls --enable-languages=c --disable-newlib-atexit-dynamic-alloc --without-fp

make -j${NCPU}
make install -j${NCPU}
