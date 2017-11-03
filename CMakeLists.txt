    project (hello-world)

    cmake_minimum_required (VERSION 3.1)
    include (CMakeToolsHelpers OPTIONAL)
    add_definitions ( -DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\" )
    
    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
    
    set (EXEC_NAME "hello-world")
    set (RELEASE_NAME "snappy snowflake")
    set (VERSION "0.0.1")
    set (VERSION_INFO "A hello world.")

    find_package (PkgConfig)
    pkg_check_modules (
        DEPS REQUIRED 
            sdl2
            SDL2_image
            SDL2_mixer
            SDL2_ttf
            gee-0.8
            gio-2.0
            glib-2.0
            gobject-2.0
    )
    
    find_program ( WHERE_GRESOURCE glib-compile-resources )
    if ( NOT WHERE_GRESOURCE )
        message (FATAL_ERROR "Error! GLIB-COMPILE-RESOURCES is not installed.")
    endif ()
    add_subdirectory (data)
    
    add_definitions ( ${DEPS_CFLAGS} )
    link_libraries ( ${DEPS_LIBRARIES} )
    link_directories ( ${DEPS_LIBRARY_DIRS} )
    
    find_package (Vala REQUIRED)
    include (ValaVersion)
    ensure_vala_version ("0.30" MINIMUM)
    include (ValaPrecompile)
    
    configure_file ( ${CMAKE_SOURCE_DIR}/src/Config.vala.base ${CMAKE_BINARY_DIR}/src/Config.vala )
    file (RELATIVE_PATH CONFIG ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/src/Config.vala)

    include (.lib/Bosco/include.cmake)
    include (.lib/Utils/include.cmake)

    vala_precompile (
        VALA_C ${EXEC_NAME}
            ${CONFIG}
            ${LIB_SOURCES}
            src/DarkMatter.vala
            src/game/Components.gs
            src/game/Entities.gs
            src/game/Game.gs
            src/game/systems/CollisionSystem.gs
            src/game/systems/ColorTweenSystem.gs
            src/game/systems/DestroySystem.gs
            src/game/systems/EntitySpawningTimerSystem.gs
            src/game/systems/ExpiringSystem.gs
            src/game/systems/HudRenderSystem.gs
            src/game/systems/MovementSystem.gs
            src/game/systems/PlayerInputSystem.gs
            src/game/systems/RemoveOffscreenShipsSystem.gs
            src/game/systems/RenderPositionSystem.gs
            src/game/systems/ScaleTweenSystem.gs
            src/game/systems/SoundEffectSystem.gs
            src/game/systems/ViewManagerSystem.gs
        PACKAGES
            sdl2
            SDL2_image
            SDL2_mixer
            SDL2_ttf
            gee-0.8
            gio-2.0
            glib-2.0
            gobject-2.0
        OPTIONS
            --disable-warnings 
            --gresources=${CMAKE_SOURCE_DIR}/data/resources.gresource.xml
            --vapidir=${CMAKE_SOURCE_DIR}/src/vapis
    )

    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w" )
    if (WIN32)  
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mwindows" )
    endif ()
    
    set (VALA_C ${VALA_C} ${resources_gresource_xml_C_FILE} )
    add_executable ( ${EXEC_NAME} ${VALA_C} )
    add_dependencies ( ${EXEC_NAME} resources_gresource_xml )
    target_link_libraries ( ${EXEC_NAME} m )
        
    # install the binaries we just made
    install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

