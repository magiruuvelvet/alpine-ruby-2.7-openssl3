#!/bin/sh

set -e

# update package database
apk update

# install essentials
apk add libarchive-tools patch make musl-dev clang gcc

# install ruby dependencies
apk add openssl-dev readline-dev zlib-dev yaml-dev libffi-dev gmp-dev

# extract ruby
mkdir -p /tmp/ruby
cd /tmp/ruby
bsdtar -xf /tmp/ruby-2.7.8.tgz
bsdtar -xf /tmp/patches/ruby-openssl-v3.0.0.tar.gz
cd ruby-2.7.8

# patch ruby
patch -Np1 -i /tmp/patches/ruby2.7-do-not-depend-on-ext-openssl-deprecation-rb.patch
rm -rf ext/openssl test/openssl
mv ../openssl-3.0.0/ext/openssl ext
mv ../openssl-3.0.0/lib ext/openssl
mv ../openssl-3.0.0/History.md ext/openssl
mv ../openssl-3.0.0/openssl.gemspec ext/openssl
mv ../openssl-3.0.0/test/openssl test

# compile ruby
./configure CC=clang CXX=clang++ --prefix=/usr/local \
    --enable-shared \
    --enable-pthread \
    --disable-rpath \
    --enable-mkmf-verbose \
    --enable-jit \
    --enable-ipv6 \
    --enable-option-checking=no \
    --disable-install-rdoc \
    --with-out-ext="win32,win32ole,gdbm,dbm"
make V=1 -j4

# remove some default gems
rm -rf lib/bundler*
rm -f lib/rdoc/rdoc.gemspec

# install ruby
make install

cd /

# clean up
rm -r /tmp/ruby
rm /tmp/ruby-2.7.8.tgz
rm -r /tmp/patches
rm /tmp/install.sh

# clean up toolchain
apk del patch make musl-dev clang gcc
apk del openssl-dev readline-dev zlib-dev yaml-dev libffi-dev gmp-dev
apk add openssl readline zlib yaml libffi gmp
