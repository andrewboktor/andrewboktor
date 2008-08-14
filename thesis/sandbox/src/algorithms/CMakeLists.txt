link_directories(graph)
include_directories(graph)

add_library(algorithms layout.m nodes.m navigation.m script.m)
target_link_libraries(algorithms graph)

