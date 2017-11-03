# cmake-vala-vscode

I love autovala, but it doesn't work on windows. 

Using the CMakeTools plugin for vscode and https://github.com/elementary/cmake-modules


on Windows I want to use Vs2017 templates:

    cd build
    cmake -G "Visual Studio 15 2017 Win64" ..

But NO - it compiles ok, but runtime execution fails. 
Gnome software has depedencies on mingw, so it's not working when compiled with msvc.
We need releases of windows binaries (android, also). But that's not likely to happen until it's a priority for Gnome.

So use this:

    cd build
cmake -G "MSYS Makefiles" -D CMAKE_C_COMPILER=/c/msys64/mingw64/bin/clang.exe -D CMAKE_CXX_COMPILER=/c/msys64/mingw64/bin/clang++.exe ..

    cmake -G "MSYS Makefiles" ..
    restart vscode

    use F5 to debug

On Linuc:

    cd build
    cmake -D CMAKE_C_COMPILER=/usr/bin/clang -D CMAKE_CXX_COMPILER=/usr/bin/clang++ ..

### pros:
* Same build chain in linux and windows
* tooling - works with CMakeTools in VSCode
* fewer steps than autovala
### cons:
* manually update file lists
