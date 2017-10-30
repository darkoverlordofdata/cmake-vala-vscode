#------------------------------------------------------------------------------
# Usage: find_package (SDL2IMAGE [REQUIRED])
#
# Sets variables:
#     SDL2_INCLUDE_DIRS
#     SDL2_LIBS
#     SDL2_DLLS
#------------------------------------------------------------------------------

include (FindPackageHandleStandardArgs)

if (WIN32)
    # Search for SDL2 Debug CMake build in extern/SDL2_image-2.0.2-dev/build
    find_path (SDL2IMAGE_ROOT "include/SDL_image.h" PATHS "${CMAKE_CURRENT_LIST_DIR}/../../extern/SDL2_image-2.0.2-dev" NO_DEFAULT_PATH)
    if (SDL2IMAGE_ROOT)
        if (EXISTS "${SDL2IMAGE_ROOT}/build/Debug/SDL2_image.lib")
            list (APPEND SDL2_INCLUDE_DIRS "${SDL2IMAGE_ROOT}/include")
            list (APPEND SDL2_LIBS "${SDL2IMAGE_ROOT}/build/Debug/SDL2_image.lib")
            list (APPEND SDL2_DLLS "${SDL2IMAGE_ROOT}/build/Debug/SDL2_image.dll")
        endif ()
    endif ()
    if (NOT SDL2IMAGE_FOUND)
        # Search for SDL2 in extern/SDL2_image-2.0.2
        find_path (SDL2IMAGE_ROOT "include/SDL_image.h" PATHS "${CMAKE_CURRENT_LIST_DIR}/../../extern/SDL2_image-2.0.2" NO_DEFAULT_PATH)
        if (SDL2IMAGE_ROOT)
            list (APPEND SDL2_INCLUDE_DIRS "${SDL2IMAGE_ROOT}/include")
            if ("${CMAKE_GENERATOR}" MATCHES "Win64")
                list (APPEND SDL2_LIBS "${SDL2IMAGE_ROOT}/lib/x64/SDL2_image.lib")
                list (APPEND SDL2_DLLS "${SDL2IMAGE_ROOT}/lib/x64/SDL2_image.dll")
            else ()
                list (APPEND SDL2_LIBS "${SDL2IMAGE_ROOT}/lib/x86/SDL2_image.lib")
                list (APPEND SDL2_DLLS "${SDL2IMAGE_ROOT}/lib/x86/SDL2_image.dll")
            endif ()
        endif ()
    endif ()

    mark_as_advanced (SDL2IMAGE_ROOT)
    find_package_handle_standard_args (SDL2_IMAGE DEFAULT_MSG SDL2_INCLUDE_DIRS SDL2_LIBS SDL2_DLLS)
else ()
    # On MacOS, should be installed via Macports
    # On Ubuntu, install with: apt-get install libsdl2_image-dev
    find_path (SDL2_INCLUDE_DIRS SDL_image.h PATH_SUFFIXES SDL2IMAGE)
    find_library (_SDL2IMAGE_LIB SDL2IMAGE)
    list (APPEND SDL2_LIBS ${SDL2IMAGE})

    mark_as_advanced (SDL2_INCLUDE_DIRS _SDL2IMAGE_LIB)
    find_package_handle_standard_args (SDL2IMAGE DEFAULT_MSG SDL2_INCLUDE_DIRS SDL2_LIBS)
endif ()
