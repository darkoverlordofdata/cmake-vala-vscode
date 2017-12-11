#!/usr/bin/env sh

cd build
if [ "$(expr substr $(uname -s) 1 7)" == "MSYS_NT" ]; then

    cmake \
        -G "MSYS Makefiles" \
        -DCMAKE_TOOLCHAIN_FILE=/c/Users/darko/sdk/emsdk/emscripten/1.37.21/cmake/Modules/Platform/Emscripten.cmake \
        -DCMAKE_C_COMPILER=/c/Users/darko/sdk/emsdk/emscripten/1.37.21/emcc \
        -DCMAKE_CXX_COMPILER=/c/Users/darko/sdk/emsdk/emscripten/1.37.21/em++ \
        ..
else
    cmake \
        -DCMAKE_TOOLCHAIN_FILE=/home/bruce/Applications/emsdk/emscripten/1.37.21/cmake/Modules/Platform/Emscripten.cmake \
        -DCMAKE_C_COMPILER=/home/bruce/Applications/emsdk/emscripten/1.37.21/emcc \
        -DCMAKE_CXX_COMPILER=/home/bruce/Applications/emsdk/emscripten/1.37.21/em++ \
        ..
fi
