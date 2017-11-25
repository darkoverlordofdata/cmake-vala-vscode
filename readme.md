# cmake-vala-vscode

Project made with doran package manager:

$ git clone https://github.com/darkoverlordofdata/cmake-vala-vscode.git
$ cd cmake-vala-vscode
$ bower install
$ cd build
$ cmake -D CMAKE_C_COMPILER=/usr/bin/clang.exe -D CMAKE_CXX_COMPILER=/usr/bin/clang++.exe ..
$ vscode ..



set_target_properties(client PROPERTIES LINK_FLAGS "-s DEMANGLE_SUPPORT=1 --preload-file assets --bind")


