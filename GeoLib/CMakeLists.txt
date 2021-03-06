# Source files
get_source_files(SOURCES)

append_source_files(SOURCES IO)

append_source_files(SOURCES IO/XmlIO/Boost)

if(OGS_BUILD_GUI)
    append_source_files(SOURCES IO/XmlIO/Qt)
endif()

# Create the library
ogs_add_library(GeoLib ${SOURCES})

target_link_libraries(GeoLib PUBLIC BaseLib MathLib PRIVATE tet spdlog::spdlog)

if(OGS_BUILD_GUI)
    target_link_libraries(GeoLib PUBLIC Qt5::Xml Qt5::XmlPatterns)
endif()

configure_file(IO/XmlIO/OpenGeoSysGLI.xsd
               ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/OpenGeoSysGLI.xsd COPYONLY)
configure_file(IO/XmlIO/OpenGeoSysSTN.xsd
               ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/OpenGeoSysSTN.xsd COPYONLY)
install(FILES IO/XmlIO/OpenGeoSysGLI.xsd IO/XmlIO/OpenGeoSysSTN.xsd
        DESTINATION bin
        COMPONENT ogs_cli)
