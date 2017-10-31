    project (hello-world)

    cmake_minimum_required (VERSION 3.1)
    include (CMakeToolsHelpers OPTIONAL)

    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
    
    set (EXEC_NAME "hello-world")
    set (RELEASE_NAME "A hello world.")
    set (VERSION "0.0.1")
    set (VERSION_INFO "whats up world")

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
    
    configure_file ( ${CMAKE_SOURCE_DIR}/src/Config.vala.base ${CMAKE_SOURCE_DIR}/src/Config.vala )
    add_definitions ( -DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\" )
    
    vala_precompile (
        VALA_C ${EXEC_NAME}
            src/Config.vala
            src/Bosco/AbstractGame.gs
            src/Bosco/Bag.gs
            src/Bosco/ECS/CoreTest.vala
            src/Bosco/ECS/EntityBase.gs
            src/Bosco/ECS/EntityPool.vala
            src/Bosco/ECS/Exceptions.gs
            src/Bosco/ECS/Group.gs
            src/Bosco/ECS/Matcher.gs
            src/Bosco/ECS/WorldBase.gs
            src/Bosco/Events/ComponentReplaced.gs
            src/Bosco/Events/EntityChanged.gs
            src/Bosco/Events/EntityReleased.gs
            src/Bosco/Events/GroupChanged.gs
            src/Bosco/Events/GroupUpdated.gs
            src/Bosco/Events/GroupsChanged.gs
            src/Bosco/Events/WorldChanged.gs
            src/Bosco/Interfaces/IComponent.vala
            src/Bosco/Interfaces/IMatcher.vala
            src/Bosco/Interfaces/ISystem.vala
            src/Bosco/Sprite.gs
            src/Bosco/Version.gs
            src/DarkMatter.vala
            src/Utils/UUID.vala
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
            --verbose
            --gresources=${CMAKE_SOURCE_DIR}/data/resources.gresource.xml
            --vapidir=${CMAKE_SOURCE_DIR}/src/vapis
    )

    if (WIN32)  
        set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mwindows" )
    endif ()
    
    set (VALA_C ${VALA_C} ${resources_gresource_xml_C_FILE} )
    add_executable ( ${EXEC_NAME} ${VALA_C} )
    add_dependencies ( ${EXEC_NAME} resources_gresource_xml )
    target_link_libraries ( ${EXEC_NAME} m )
        
    # install the binaries we just made
    install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

