# cmake-vala-vscode

I love autovala, but it doesn't work on windows. 

Using the CMakeTools plugin for vscode and https://github.com/elementary/cmake-modules


on Windows use Vs2017 templates:

    cd build
    cmake -G "Visual Studio 15 2017 Win64" ..



Hello world runs fine.
Shmupwarz compiles, but gets runtime errors, its unable to find the entry points of gnome dll's. Watching in debugger, it unloads the msvc version of the dll, reloads the mingw version, and then fails. Talk about vendor lockin. That's *worse* than Microsoft.

I don't get why Gnome doesn't release binary versions for all platforms, most everyone else can. I'm starting to disbelieve their claims of portability. I'm just not seeing it.

Maybe I'll try building GLib with msvc, but I shudder at the thought. It's a rat's nest. 

