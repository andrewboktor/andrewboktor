subdirs(adt graph gtk algorithms ui)
link_directories(${GTK_LIBRARY_DIRS}
	${GLIB_LIBRARY_DIRS} ${CAIRO_LIBRARY_DIRS} adt graph algorithms gtk ui)
include_directories(${GTK_INCLUDE_DIRS} 
	${GLIB_INCLUDE_DIRS} ${CAIRO_INCLUDE_DIRS} adt graph algorithms gtk ui)

add_executable(sandbox main.m)
target_link_libraries(sandbox gtk adt graph algorithms ui)

