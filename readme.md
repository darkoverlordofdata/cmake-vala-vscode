# cmake-vala-vscode

Project made with doran package manager:

$ git clone https://github.com/darkoverlordofdata/cmake-vala-vscode.git
$ cd cmake-vala-vscode
$ bower install
$ cd build

## build
    git clone https://github.com/darkoverlordofdata/zerog-shmupwarz.git
    cd zerog-shmupwarz
    npm install
    doran install
    mkdir build
    cd build

### linux gcc
    cmake .. 
    make

### linux clang
    cmake .. -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++
    make

### windows mingw
    cmake .. -G "MSYS Makefiles" 
    make

### windows clang
    cmake .. -G "MSYS Makefiles" -DCMAKE_C_COMPILER=/c/msys64/mingw64/bin/clang.exe -DCMAKE_CXX_COMPILER=/c/msys64/mingw64/bin/clang++.exe
    make

## emscripten

add to cmakelists.txt:
```
set ( VALAC_OPTIONS "${VALAC_OPTIONS};--define=EMSCRIPTEN" )
set ( CUSTOM_VAPIS  "${CUSTOM_VAPIS};${CMAKE_SOURCE_DIR}/src/vapis/emscripten.vapi" )
```

make

when it fails with
fatal error: 'emscripten.h' file not found

then continue with ./build.bat or ./build.sh

