cmake_minimum_required(VERSION 3.16)

project(Mindful-Journal VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMindful-Journal
    resources.qrc
    src/main.cpp
)

qt_add_qml_module(appMindful-Journal
    URI Mindful-Journal
    VERSION 1.0
    QML_FILES
    "src/ui/Main.qml"
    "src/ui/pages/home.qml"
    "src/ui/pages/settings.qml"
)

set_target_properties(appMindful-Journal PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMindful-Journal
    PRIVATE Qt6::Quick
)

install(TARGETS appMindful-Journal
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
