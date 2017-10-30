### CMakeLists automatically created with AutoVala
### Do not edit

set (DATADIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_DATAROOTDIR}")
set (PKGDATADIR "${DATADIR}/shmupwarz-vala")
set (GETTEXT_PACKAGE "shmupwarz-vala")
set (RELEASE_NAME "shmupwarz-vala")
set (CMAKE_C_FLAGS "")
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (VERSION "1.0.0")
set (TESTSRCDIR "${CMAKE_SOURCE_DIR}")
set (DOLLAR "$")

configure_file (${CMAKE_SOURCE_DIR}/src/Config.vala.cmake ${CMAKE_BINARY_DIR}/src/Config.vala)
add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")
set (VERSION "1.0.0")
add_definitions (${DEPS_CFLAGS})
link_libraries ( ${DEPS_LIBRARIES} )
link_directories ( ${DEPS_LIBRARY_DIRS} )
find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.30" MINIMUM)
include (ValaPrecompile)

set (VALA_PACKAGES ${VALA_PACKAGES} SDL2_image)
set (VALA_PACKAGES ${VALA_PACKAGES} SDL2_mixer)
set (VALA_PACKAGES ${VALA_PACKAGES} SDL2_ttf)
set (VALA_PACKAGES ${VALA_PACKAGES} sdl2)
set (VALA_PACKAGES ${VALA_PACKAGES} gee-0.8)
set (VALA_PACKAGES ${VALA_PACKAGES} gio-2.0)
set (VALA_PACKAGES ${VALA_PACKAGES} glib-2.0)
set (VALA_PACKAGES ${VALA_PACKAGES} gobject-2.0)

set (APP_SOURCES ${APP_SOURCES} ${CMAKE_CURRENT_BINARY_DIR}/Config.vala)
set (APP_SOURCES ${APP_SOURCES} Bosco/AbstractGame.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Bag.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/CoreTest.vala)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/EntityBase.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/EntityPool.vala)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/Exceptions.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/Group.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/Matcher.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/ECS/WorldBase.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/ComponentReplaced.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/EntityChanged.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/EntityReleased.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/GroupChanged.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/GroupUpdated.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/GroupsChanged.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Events/WorldChanged.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Interfaces/IComponent.vala)
set (APP_SOURCES ${APP_SOURCES} Bosco/Interfaces/IMatcher.vala)
set (APP_SOURCES ${APP_SOURCES} Bosco/Interfaces/ISystem.vala)
set (APP_SOURCES ${APP_SOURCES} Bosco/Sprite.gs)
set (APP_SOURCES ${APP_SOURCES} Bosco/Version.gs)
set (APP_SOURCES ${APP_SOURCES} DarkMatter.vala)
set (APP_SOURCES ${APP_SOURCES} Utils/UUID.vala)
set (APP_SOURCES ${APP_SOURCES} game/Components.gs)
set (APP_SOURCES ${APP_SOURCES} game/Entities.gs)
set (APP_SOURCES ${APP_SOURCES} game/Game.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/CollisionSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/ColorTweenSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/DestroySystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/EntitySpawningTimerSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/ExpiringSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/HudRenderSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/MovementSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/PlayerInputSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/RemoveOffscreenShipsSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/RenderPositionSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/ScaleTweenSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/SoundEffectSystem.gs)
set (APP_SOURCES ${APP_SOURCES} game/systems/ViewManagerSystem.gs)
set (APP_SOURCES ${APP_SOURCES} shmupwarz-vala.gs)

set (COMPILE_OPTIONS ${COMPILE_OPTIONS} --vapidir=${CMAKE_SOURCE_DIR}/src/vapis )

if ((${CMAKE_BUILD_TYPE} STREQUAL "Debug") OR (${CMAKE_BUILD_TYPE} STREQUAL "RelWithDebInfo"))
	set(COMPILE_OPTIONS ${COMPILE_OPTIONS} "-g")
endif()

set (COMPILE_OPTIONS ${COMPILE_OPTIONS} --disable-warnings )

set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g" )

vala_precompile(VALA_C shmupwarz-vala
	${APP_SOURCES}
PACKAGES
	${VALA_PACKAGES}
OPTIONS
	${COMPILE_OPTIONS}
)

add_executable(shmupwarz-vala ${VALA_C})
target_link_libraries( shmupwarz-vala m )


install(TARGETS
	shmupwarz-vala
RUNTIME DESTINATION
	${CMAKE_INSTALL_BINDIR}
)
if(HAVE_VALADOC)
	valadoc(shmupwarz-vala
		${CMAKE_BINARY_DIR}/valadoc/shmupwarz-vala
		${APP_SOURCES}
	PACKAGES
		${VALA_PACKAGES}
	CUSTOM_VAPIS
		${CUSTOM_VAPIS_LIST}
	)
	install(DIRECTORY
		${CMAKE_BINARY_DIR}/valadoc
	DESTINATION
		${CMAKE_INSTALL_DATAROOTDIR}/doc/shmupwarz-vala
	)
endif()
