
call C:\Users\darko\sdk\emsdk\emsdk_env.bat
set SDK=%HOMEDRIVE%%HOMEPATH%\sdk


emcc ^
-O3 ^
-s WASM=1 ^
-s USE_SDL=2 ^
-s USE_SDL_TTF=2 ^
-s USE_SDL_IMAGE=2 ^
-s SDL2_IMAGE_FORMATS="[""png""]" ^
-I.lib\zerog\include ^
-I.lib\mt19937\include ^
-I%sdk%\SDL2-2.0.5\x86_64-w64-mingw32\include ^
-I%sdk%\SDL2_ttf-2.0.14\x86_64-w64-mingw32\include ^
-I%sdk%\SDL2_image-2.0.2\x86_64-w64-mingw32\include ^
-I%sdk%\emsdk\emscripten\1.37.21\system\include ^
--shell-file src\template.html ^
--preload-file assets ^
.lib\mt19937\src\mt19937ar.c ^
build\build\src\alliance.c ^
build\build\src\components.c ^
build\build\src\Config.c ^
build\build\src\entity.c ^
build\build\src\factory.c ^
build\build\src\game.c ^
build\build\src\system.c ^
-o web\index.html 

