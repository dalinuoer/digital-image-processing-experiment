cmake_minimum_required(VERSION 3.5.0)

project(exp01)

find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})

set(SOURCES
    src/main.cpp
)

add_executable(exp01 ${SOURCES})

target_link_libraries(exp01
    ${OpenCV_LIBS}
)