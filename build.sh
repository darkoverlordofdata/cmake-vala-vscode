#!/usr/bin/env bash

#
#   Set up the emscripten environment
#
source /home/bruce/emsdk/emsdk_env.sh
#
#   Isolate sdl from other libraries
#
mkdir -p ./.lib/include
ln -fs /usr/include/SDL2 ./.lib/include
#
#   compile with emscripten
#   
emcc \
-O3 \
-s WASM=1 \
-s USE_SDL=2 \
-s USE_SDL_TTF=2 \
-s USE_SDL_IMAGE=2 \
-s SDL2_IMAGE_FORMATS='["png"]' \
-I.lib/include \
-I.lib/zerog/include \
-I.lib/mt19937/include \
-I/home/bruce/emsdk/emscripten/incoming/system/include \
--shell-file src/template.html \
--preload-file assets \
.lib/mt19937/src/mt19937ar.c \
build/build/src/alliance.c \
build/build/src/components.c \
build/build/src/Config.c \
build/build/src/entity.c \
build/build/src/Factory.c \
build/build/src/Game.c \
build/build/src/system.c \
-o web/index.html 

