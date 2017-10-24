cmake_minimum_required(VERSION 3.8)
project(2lab)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")


set(SOURCE_FILES main.cpp lexicalAnalyzer.cpp lexicalAnalyzer.h parser.cpp parser.h)

add_executable(2lab ${SOURCE_FILES})

add_library(gvc SHARED IMPORTED)
set_property(TARGET gvc PROPERTY
                        IMPORTED_LOCATION /usr/lib/libgvc.so.6.0.0)





target_link_libraries(${TARGET} 2lab)