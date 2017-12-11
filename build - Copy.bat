call C:\Users\darko\sdk\emsdk\emsdk_env.bat

emcc ^
-O3 ^
-s WASM=1 ^
-s USE_SDL=2 ^
-s USE_SDL_TTF=2 ^
-s USE_SDL_IMAGE=2 ^
-s SDL2_IMAGE_FORMATS="[""png""]" ^
-I.lib/zerog/include ^
-I.lib/mt19937/include ^
-I.ext/SDL2/include ^
-I.ext/SDL2_ttf/include ^
-I.ext/SDL2_image/include ^
-I.ext/emscripten/include ^
-o web/index.html ^
--shell-file src/template.html ^
--preload-file assets ^
.lib/mt19937/src/mt19937ar.c ^
build/build/src/alliance.c ^
build/build/src/components.c ^
build/build/src/Config.c ^
build/build/src/entity.c ^
build/build/src/factory.c ^
build/build/src/game.c ^
build/build/src/system.c 

