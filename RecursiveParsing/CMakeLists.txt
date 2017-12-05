cmake_minimum_required(VERSION 3.8)
project(2lab)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")


set(SOURCE_FILES main.cpp lexicalAnalyzer.cpp lexicalAnalyzer.h parser.cpp parser.h)

find_library(GRAPHVISLIBS NAMES libcgraph.so.6.0.0 libgvc.so.6.0.0 libcdt.so.5.0.0)

add_executable(2lab ${SOURCE_FILES})


target_link_libraries(${TARGET} 2lab ${GRAPHVISLIBS} gvc cgraph cdt)