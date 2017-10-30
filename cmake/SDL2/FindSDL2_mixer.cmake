#------------------------------------------------------------------------------
# Usage: find_package(SDL2MIXER [REQUIRED])
#
# Sets variables:
#     SDL2_INCLUDE_DIRS
#     SDL2MIXER_LIBS
#     SDL2_DLLS
#------------------------------------------------------------------------------

include(FindPackageHandleStandardArgs)

if (WIN32)
    # Search for SDL2 Debug CMake build in extern/SDL2_mixer-2.0.2-dev/build
    find_path(SDL2MIXER_ROOT "include/SDL_mixer.h" PATHS "${CMAKE_CURRENT_LIST_DIR}/../../extern/SDL2_mixer-2.0.2-dev" NO_DEFAULT_PATH)
    if (SDL2MIXER_ROOT)
        if (EXISTS "${SDL2MIXER_ROOT}/build/Debug/SDL2_mixer.lib")
            list (APPEND SDL2_INCLUDE_DIRS "${SDL2MIXER_ROOT}/include")
            list (APPEND SDL2_LIBS "${SDL2MIXER_ROOT}/build/Debug/SDL2_mixer.lib")
            list (APPEND SDL2_DLLS "${SDL2MIXER_ROOT}/build/Debug/SDL2_mixer.dll")
        endif ()
    endif ()
    if (NOT SDL2MIXER_FOUND)
        # Search for SDL2 in extern/SDL2_mixer-2.0.2
        find_path(SDL2MIXER_ROOT "include/SDL_mixer.h" PATHS "${CMAKE_CURRENT_LIST_DIR}/../../extern/SDL2_mixer-2.0.2" NO_DEFAULT_PATH)
        if (SDL2MIXER_ROOT)
            list (APPEND SDL2_INCLUDE_DIRS "${SDL2MIXER_ROOT}/include")
            if ("${CMAKE_GENERATOR}" MATCHES "Win64")
                list (APPEND SDL2_LIBS "${SDL2MIXER_ROOT}/lib/x64/SDL2_mixer.lib")
                list (APPEND SDL2_DLLS "${SDL2MIXER_ROOT}/lib/x64/SDL2_mixer.dll")
            else()
                list (APPEND SDL2_LIBS "${SDL2MIXER_ROOT}/lib/x86/SDL2_mixer.lib")
                list (APPEND SDL2_DLLS "${SDL2MIXER_ROOT}/lib/x86/SDL2_mixer.dll")
            endif ()
        endif ()
    endif ()

    mark_as_advanced(SDL2MIXER_ROOT)
    find_package_handle_standard_args(SDL2_MIXER DEFAULT_MSG SDL2_INCLUDE_DIRS SDL2_LIBS SDL2_DLLS)
else()
    # On MacOS, should be installed via Macports
    # On Ubuntu, install with: apt-get install libsdl2_mixer-dev
    find_path(SDL2_INCLUDE_DIRS SDL_mixer.h PATH_SUFFIXES SDL2MIXER)
    find_library(_SDL2MIXER_LIB SDL2MIXER)
    list (APPEND SDL2_LIBS ${SDL2MIXER})

    mark_as_advanced(SDL2_INCLUDE_DIRS _SDL2MIXER_LIB)
    find_package_handle_standard_args(SDL2MIXER DEFAULT_MSG SDL2_INCLUDE_DIRS SDL2_LIBS)
endif ()
