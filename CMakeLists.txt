# Set cmake minimum version required.
cmake_minimum_required(VERSION 4.0)

# Set the project name and project version.
#	- VERSION_MAJOR
#	- VERSION_MINOR
# VERSION 1.2: '1' represents MAJOR VERSION and '2' represent MINOR VERSION.
#
# This can be done in one command or in 2 separate commands.
# e.g project(CMAKE_LEARNING
# e.g project(${PROJECT_NAME} VERSION 1.2)
project(CMAKE_LEARNING
		VERSION 1.2
)

# Set C standard (optional).
set(CMAKE_C_STANDARD 11)

# "OS bitness" refers to whether your operating system (OS) is 32-bit (x86) or 64-bit (x64).
# 32-bit (x86) is mostly obsolete (only for very old hardware).
set(OSBitness 32)
# CMAKE_SIZEOF_VOID_P is a CMake variable that tells you the size of a pointer (void*) on your system.
# This helps determine if you're compiling for 32-bit or 64-bit.
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(OSBitness 64)
endif()


# Add config header file.
# config.h file is created in build directory, add build directory as well in project includes.
# configure_file(config.h.in config.h)

# Add include directory.
set( PROJECT_INCLUDES
	 ${PROJECT_SOURCE_DIR}/api
)

# Add all the source files.
set( PROJECT_SOURCES
	 ${PROJECT_SOURCE_DIR}/src/main.cpp
)


# Add includes in project directory.
# Add build directory (PROJECT_BINARY_DIR) as well, As it contains config.h file.
include_directories( ${PROJECT_INCLUDES}   # Needed to find include files '.h'.
				   # ${PROJECT_BINARY_DIR} # Needed to find `config.h`. If your project don't have 'config.h' file then no need for ${PROJECT_BINARY_DIR}.
)
					
# This CMake script organizes your build outputs (executables, libraries) into a structured folder system based on:
# 	- Operating System (Windows/Linux/Mac)
# 	- System bitness (32-bit/64-bit)
# 	- Build type (Debug/Release)


# Set Build type as Debug.
set(CMAKE_BUILD_TYPE "Debug"
)

# Set output directory. 
# Creates a path like: [project_root]/bin/Windows64/Debug.
# 
# - Components:
#	 - ${CMAKE_SOURCE_DIR} = Your project's root folder.
# 	 - bin/ = Base output directory.
# 	 - ${CMAKE_SYSTEM_NAME} = OS name (Windows, Linux, Darwin for Mac).
#  	 - ${OSBitness} = Your custom variable for 32/64-bit (likely "32" or "64").
# 	 - ${CMAKE_BUILD_TYPE} = Debug/Release/RelWithDebInfo.
# set(FullOutputDir "${CMAKE_SOURCE_DIR}/bin/${CMAKE_SYSTEM_NAME}${OSBitness}/${CMAKE_BUILD_TYPE}")
set(FullOutputDir "${CMAKE_SYSTEM_NAME}${OSBitness}/${CMAKE_BUILD_TYPE}")

# ARCHIVE_OUTPUT_DIRECTORY = Where static libraries (.lib/.a) go.
#	Example: bin/Windows64/Debug/static libs/
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${FullOutputDir}/static libs")

# LIBRARY_OUTPUT_DIRECTORY = Where shared libraries (.dll/.so) go.
#	Example: bin/Windows64/Debug/
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${FullOutputDir}")

# RUNTIME_OUTPUT_DIRECTORY = Where executables (.exe) go.
#	Example: bin/Windows64/Debug/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${FullOutputDir}")


# Add executable target.
#add_executable(${PROJECT_NAME} src/main.cpp)

# OR

# Add the executable.
# It just required executable name (Which is Project name here) and Source includes.
# Build will be created with this name (${PROJECT_NAME}).
add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})

