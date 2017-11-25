
call C:\Users\darko\sdk\emsdk\emsdk_env.bat
REM -s EXPORTED_FUNCTIONS='[\"_game\"]' 


emcc ^
-s WASM=1 ^
-s USE_SDL=2 ^
-s USE_SDL_IMAGE=2 ^
-s SDL2_IMAGE_FORMATS="[""png""]" ^
-s USE_SDL_TTF=2 ^
--preload-file assets ^
-O3 ^
-I.lib/mt19937/src ^
-I.lib/zerog/src ^
-IC:/Users/darko/sdk/emsdk/emscripten/1.37.21/system/include ^
-o web/alliance.html ^
.lib/mt19937/src/mt19937ar.c ^
build/build/src/alliance.c ^
build/build/src/components.c ^
build/build/src/Config.c ^
build/build/src/entity.c ^
build/build/src/factory.c ^
build/build/src/game.c ^
build/build/src/system.c 

