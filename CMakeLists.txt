cmake_minimum_required ( VERSION 3.1 )
###################################################################################
#
#   Build frodo
#
###################################################################################
project ( frodo VERSION 0.0.1 )

#
# enable features
#
include ( CMakeToolsHelpers OPTIONAL )
list ( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/adria)
find_package (PkgConfig)
find_package (Vala REQUIRED)

#
#   libraries - sources & packages
#
add_subdirectory ( .lib/entitas )
add_subdirectory ( .lib/goop )
add_subdirectory ( .lib/sdx )
add_subdirectory ( .lib/mt19937 )
add_subdirectory ( .lib/zerog )
if (EXISTS ${CMAKE_SOURCE_DIR}/data )
    add_subdirectory (data)
    list ( APPEND RESOURCES ${resources_gresource_xml_C_FILE} )
endif ()

#
#   generated code configuration
#
configure_file ( 
    ${CMAKE_SOURCE_DIR}/src/Config.vala.base 
    ${CMAKE_BINARY_DIR}/src/Config.vala 
)
file (RELATIVE_PATH CONFIG_VALA ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/src/Config.vala)

#
#   out of tree build location
#
configure_file ( src/components.vala src/components.vala )
configure_file ( src/entity.vala src/entity.vala )
configure_file ( src/Factory.vala src/Factory.vala )
configure_file ( src/frodo.vala src/frodo.vala )
configure_file ( src/Game.vala src/Game.vala )
configure_file ( src/main.vala src/main.vala )
configure_file ( src/shmupwarz.vala src/shmupwarz.vala )
configure_file ( src/systems/AnimationSystem.vala src/systems/AnimationSystem.vala )
configure_file ( src/systems/CollisionSystem.vala src/systems/CollisionSystem.vala )
configure_file ( src/systems/DisplaySystem.vala src/systems/DisplaySystem.vala )
configure_file ( src/systems/ExpireSystem.vala src/systems/ExpireSystem.vala )
configure_file ( src/systems/InputSystem.vala src/systems/InputSystem.vala )
configure_file ( src/systems/PhysicsSystem.vala src/systems/PhysicsSystem.vala )
configure_file ( src/systems/RemoveSystem.vala src/systems/RemoveSystem.vala )
configure_file ( src/systems/ScoreSystem.vala src/systems/ScoreSystem.vala )
configure_file ( src/systems/SpawnSystem.vala src/systems/SpawnSystem.vala )
configure_file ( src/systems/SoundSystem.vala src/systems/SoundSystem.vala )
#
#   application source
#
list ( APPEND VALA_SOURCES ${CONFIG_VALA} )
list ( APPEND VALA_SOURCES build/src/components.vala )
list ( APPEND VALA_SOURCES build/src/entity.vala )
list ( APPEND VALA_SOURCES build/src/Factory.vala )
list ( APPEND VALA_SOURCES build/src/frodo.vala )
list ( APPEND VALA_SOURCES build/src/Game.vala )
list ( APPEND VALA_SOURCES build/src/main.vala )
list ( APPEND VALA_SOURCES build/src/shmupwarz.vala )
list ( APPEND VALA_SOURCES build/src/systems/AnimationSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/CollisionSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/DisplaySystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/ExpireSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/InputSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/PhysicsSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/RemoveSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/ScoreSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/SpawnSystem.vala )
list ( APPEND VALA_SOURCES build/src/systems/SoundSystem.vala )
#
#   pkg-config dependencies
#

pkg_check_modules (DEPS REQUIRED ${PACKAGES})
add_definitions ( ${DEPS_CFLAGS} )
link_libraries ( ${DEPS_LIBRARIES} )
link_directories ( ${DEPS_LIBRARY_DIRS} )

#
#   compiler options
#
list ( APPEND VALAC_OPTIONS --disable-warnings)
list ( APPEND VALAC_OPTIONS --vapidir=${CMAKE_SOURCE_DIR}/src/vapis)

if (WIN32)  
    set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mwindows" )
endif ()
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w" )

include_directories(AFTER ${INCLUDES})
#
#   compile vala code
#
include (ValaVersion)
ensure_vala_version (0.34 MINIMUM)
include (ValaPrecompile)
vala_precompile (
    VALA_C ${PROJECT_NAME}
        ${VALA_SOURCES}
    PACKAGES
        ${PACKAGES}
    CUSTOM_VAPIS
        ${CUSTOM_VAPIS}
    OPTIONS
        ${VALAC_OPTIONS}
    )

#
#   compile ccode & link executable
#
add_executable ( ${PROJECT_NAME} ${VALA_C} ${C_SOURCES} ${RESOURCES} )
target_link_libraries ( ${PROJECT_NAME} m )
install (TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)


# (generated from template: adria. Do not modify. )
