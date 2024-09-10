cmake_minimum_required(VERSION 3.18)

project(QmlGraphicEditor)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt5 REQUIRED COMPONENTS Core Quick)

list(APPEND LIBS
Qt5::Core
Qt5::Quick)

file(GLOB_RECURSE SRCS src/*.cpp)
file(GLOB_RECURSE QRCS qml/*.qrc icons/*.qrc backgrounds/*.qrc addtional/*.qrc)
file(GLOB_RECURSE QMLS qml/*.qml)

add_executable(${PROJECT_NAME} ${SRCS} ${QRCS})

target_link_libraries(${PROJECT_NAME} PUBLIC ${LIBS})
