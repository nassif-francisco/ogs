# This file initializes the required submodules
OPTION(OGS_ADDITIONAL_SUBMODULES_TO_CHECKOUT "User given submodules which should be checked out by CMake." "")
SET(REQUIRED_SUBMODULES
	ThirdParty/quickcheck
	${OGS_ADDITIONAL_SUBMODULES_TO_CHECKOUT}
)

FOREACH(SUBMODULE ${REQUIRED_SUBMODULES})
	# Check if submodule is already initialized
	# MESSAGE(STATUS "Checking module ${SUBMODULE}")
	EXECUTE_PROCESS(
		COMMAND ${BASH_TOOL_PATH} ${CMAKE_SOURCE_DIR}/scripts/cmake/SubmoduleCheck.sh ${SUBMODULE}
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		RESULT_VARIABLE SUBMODULE_STATE
	)

	IF(SUBMODULE_STATE EQUAL 1)
		MESSAGE(STATUS "Initializing submodule ${SUBMODULE}")
		EXECUTE_PROCESS(
			COMMAND ${GIT_TOOL_PATH} submodule update --init ${SUBMODULE}
			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		)
	ELSEIF(SUBMODULE_STATE EQUAL 2)
		MESSAGE(STATUS "Updating submodule ${SUBMODULE}")
		EXECUTE_PROCESS(
			COMMAND git submodule update ${SUBMODULE}
			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		)
	ENDIF()
ENDFOREACH()