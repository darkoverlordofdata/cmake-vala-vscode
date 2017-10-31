

execute_process ( 
	COMMAND glib-compile-resources 
			--sourcedir=${CMAKE_CURRENT_SOURCE_DIR} 
			--generate-source 
			--target=${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.c 
			${CMAKE_CURRENT_SOURCE_DIR}/resources.gresource.xml
)
execute_process ( 
	COMMAND glib-compile-resources 
			--sourcedir=${CMAKE_CURRENT_SOURCE_DIR} 
			--generate-header 
			--target=${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.h 
			${CMAKE_CURRENT_SOURCE_DIR}/resources.gresource.xml
)
add_custom_command (
	OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.c
	DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/resources.gresource.xml 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/BackdropBlackLittleSparkBlack.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/bang.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/bullet.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/enemy1.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/enemy2.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/enemy3.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/explosion.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/particle.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/fighter.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/star.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/images/tom-thumb-white.png 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/fonts/TitanOne-Regular.ttf 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/sounds/asplode.wav 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/sounds/pew.wav 
			${CMAKE_CURRENT_SOURCE_DIR}/assets/sounds/smallasplode.wav

	COMMAND glib-compile-resources 
			--sourcedir=${CMAKE_CURRENT_SOURCE_DIR} 
			--generate-source 
			--target=${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.c 
			${CMAKE_CURRENT_SOURCE_DIR}/resources.gresource.xml

	COMMAND glib-compile-resources 
			--sourcedir=${CMAKE_CURRENT_SOURCE_DIR} 
			--generate-header 
			--target=${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.h 
			${CMAKE_CURRENT_SOURCE_DIR}/resources.gresource.xml
)

add_custom_target (resources_gresource_xml DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.c)
set (resources_gresource_xml_C_FILE ${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.c PARENT_SCOPE)
set (resources_gresource_xml_H_FILE ${CMAKE_CURRENT_BINARY_DIR}/resources.gresource.xml.h PARENT_SCOPE)

if (!WIN32)
	install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/${EXEC_NAME}.desktop DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications/ )
endif ()
