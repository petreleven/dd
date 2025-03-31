#!/bin/bash

set -e  # Stop on error

# Install dependencies


# Build LuaJIT
git clone https://github.com/LuaJIT/LuaJIT luajit
cd luajit
make amalg
cd ..

# Download Luanti
git clone -b stable-5 --depth 1 https://github.com/luanti-org/luanti.git
cd luanti

# Build Luanti
mkdir -p build
cd build
cmake .. -G Ninja -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DRUN_IN_PLACE=1 \
    -DBUILD_UNITTESTS=0 \
    -DLUA_INCLUDE_DIR=../../luajit/src/ -DLUA_LIBRARY=../../luajit/src/libluajit.a
ninja

# Remove debug symbols
cd ..
objcopy --only-keep-debug bin/luantiserver luantiserver.debug
objcopy --strip-debug --add-gnu-debuglink=luantiserver.debug bin/luantiserver luantiserver

# Verify binary
ls bin
