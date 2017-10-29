    project (hello-world)

    cmake_minimum_required (VERSION 2.6)
    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

    set (EXEC_NAME "hello-world")
    set (RELEASE_NAME "A hello world.")
    set (VERSION "0.0.1")
    set (VERSION_INFO "whats up world")

    find_package(PkgConfig)
    pkg_check_modules(
        DEPS REQUIRED 
            glib-2.0
    )

    add_definitions(${DEPS_CFLAGS})
    link_libraries(${DEPS_LIBRARIES})
    link_directories(${DEPS_LIBRARY_DIRS})

    find_package(Vala REQUIRED)
    include(ValaVersion)
    ensure_vala_version("0.30" MINIMUM)
    include(ValaPrecompile)
    
    
    vala_precompile(
        VALA_C ${EXEC_NAME}
            src/hello-world.vala
        PACKAGES
            glib-2.0
        OPTIONS
            --vapidir=src/vapis
            -g
    )

    # tell cmake what to call the executable we just made
    add_executable(${EXEC_NAME} ${VALA_C})

    # install the binaries we just made
    install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

    