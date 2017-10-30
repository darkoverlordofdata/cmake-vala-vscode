#------------------------------------------------------------------------------
# Usage: find_package(SDL2TTF [REQUIRED])
#
# Sets variables:
#     SDL2_INCLUDE_DIRS
#     SDL2TTF_LIBS
#     SDL2_DLLS
#------------------------------------------------------------------------------

include(FindPackageHandleStandardArgs)

if (WIN32)
    # Search for SDL2 Debug CMake build in extern/SDL2_ttf-2.0.14-dev/build
    find_path(SDL2TTF_ROOT "include/SDL_ttf.h" PATHS "${CMAKE_CURRENT_LIST_DIR}/../../extern/SDL2_ttf-2.0.14-dev" NO_DEFAULT_PATH)
    if (SDL2TTF_ROOT)
        if (EXISTS "${SDL2TTF_ROOT}/build/Debug/SDL2_ttf.lib")
            list (APPEND SDL2_INCLUDE_DIRS "${SDL2TTF_ROOT}/include")
            list (APPEND SDL2_LIBS "${SDL2TTF_ROOT}/build/Debug/SDL2_ttf.lib")
            list (APPEND SDL2_DLLS "${SDL2TTF_ROOT}/build/Debug/SDL2_ttf.dll")
        endif ()
    endif ()
    if (NOT SDL2TTF_FOUND)
        # Search for SDL2 in extern/SDL2_ttf-2.0.14
        find_path(SDL2TTF_ROOT "include/SDL_ttf.h" PATHS "${CMAKE_CURRENT_LIST_DIR}/../../extern/SDL2_ttf-2.0.14" NO_DEFAULT_PATH)
        if (SDL2TTF_ROOT)
            list (APPEND SDL2_INCLUDE_DIRS "${SDL2TTF_ROOT}/include")
            if ("${CMAKE_GENERATOR}" MATCHES "Win64")
                list (APPEND SDL2_LIBS "${SDL2TTF_ROOT}/lib/x64/SDL2_ttf.lib")
                list (APPEND SDL2_DLLS "${SDL2TTF_ROOT}/lib/x64/SDL2_ttf.dll")
            else()
                list (APPEND SDL2_LIBS "${SDL2TTF_ROOT}/lib/x86/SDL2_ttf.lib")
                list (APPEND SDL2_DLLS "${SDL2TTF_ROOT}/lib/x86/SDL2_ttf.dll")
            endif ()
        endif ()
    endif ()

    mark_as_advanced(SDL2TTF_ROOT)
    find_package_handle_standard_args(SDL2_TTF DEFAULT_MSG SDL2_INCLUDE_DIRS SDL2_LIBS SDL2_DLLS)
else()
    # On MacOS, should be installed via Macports
    # On Ubuntu, install with: apt-get install libsdl2_ttf-dev
    find_path(SDL2_INCLUDE_DIRS SDL_ttf.h PATH_SUFFIXES SDL2TTF)
    find_library(_SDL2TTF_LIB SDL2TTF)
    list (APPEND SDL2_LIBS ${SDL2TTF})

    mark_as_advanced(SDL2_INCLUDE_DIRS _SDL2TTF_LIB)
    find_package_handle_standard_args(SDL2TTF DEFAULT_MSG SDL2_INCLUDE_DIRS SDL2_LIBS)
endif ()
