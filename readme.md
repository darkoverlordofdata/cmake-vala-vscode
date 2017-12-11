# cmake-vala-vscode

Project made with doran package manager:

$ git clone https://github.com/darkoverlordofdata/cmake-vala-vscode.git
$ cd cmake-vala-vscode
$ bower install
$ cd build
$ cmake -D CMAKE_C_COMPILER=/usr/bin/clang.exe -D CMAKE_CXX_COMPILER=/usr/bin/clang++.exe ..
$ vscode ..



set_target_properties(client PROPERTIES LINK_FLAGS "-s DEMANGLE_SUPPORT=1 --preload-file assets --bind")

### emscripten

add to cmakelists.txt:
```
set ( VALAC_OPTIONS "${VALAC_OPTIONS};--define=EMSCRIPTEN" )
set ( CUSTOM_VAPIS  "${CUSTOM_VAPIS};${CMAKE_SOURCE_DIR}/src/vapis/emscripten.vapi" )
```
when it fails with
fatal error: 'emscripten.h' file not found

./build.bat