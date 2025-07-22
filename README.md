# CMake Basic Learning

CMake is an open-source, cross-platform build system that automates the process of compiling, linking, and packaging software.  
It doesn’t build the project directly—instead, it generates build files (like Makefiles, Visual Studio projects, or Ninja files) for native build tools.

## Softwares Required

- Cmake
- Ninja
- GCC
- Visual Studio Code (Optional)

## Build Commands

- cmake -G Ninja
- cmake --build . or Ninja

## What's Ninja
- Ninja is a super-fast build system (like make but faster). It reads instructions from CMake and compiles your code efficiently by:
	- Running tasks in parallel (uses multiple CPU cores).
    - Only rebuilding files that changed (incremental builds).
    - Being lightweight (no fancy UI, just raw speed).

## Step-by-Step Guide to Writing CMake Scripts (CMakeLists.txt)
Create a file `CMakeLists.txt` at the root of project. Following are the commands to create a basic Cmake file to build the project.

- `cmake_minimum_required()` Command:
	- This is the first command in `CMakeLists.txt` to specify cmake minimum version required for the build.
	- E.g. cmake_minimum_required(VERSION 4.0)
	
- `project()` Command:
	- Defines basic metadata about your project and initializes key variables.
		- Defines the project's name and optionally specifies:
			- Version (VERSION)
			- Description (DESCRIPTION)
			- Languages (LANGUAGES) used (e.g., C, CXX, Fortran).
	- This command should be called soon after `cmake_minimum_required()`.
	
```sh
project(<PROJECT-NAME>
	[VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
	[DESCRIPTION <project-description>]
	[LANGUAGES <language1> <language2>...]
)
``` 

Example 1:  
	
```sh
project(CMAKE_LEARNING) 

project(${PROJECT_NAME} VERSION 1.2)
```

Example 2: Can be define in one command.  

```sh	
project(CMAKE_LEARNING
        VERSION 1.2
)
```  

- `set()` Command:
	- The `set()` command is used to define variables in CMake.
	- Variables can store strings, lists, paths, or boolean values, and they control how your project is configured, built, and installed.

```sh	
set(<variable> <value>... [PARENT_SCOPE])

* <variable>: Name of the variable to set (case-sensitive).
* <value>...: Value(s) assigned (can be a single item or a list).
* [PARENT_SCOPE] (Optional): Propagates the variable to the parent scope (useful in functions/subdirectories).
```  

```sh
Example: Setting Simple Variables:

set(MY_NAME "John Doe")   # String
set(ENABLE_FEATURE ON)    # Boolean (ON/OFF)
set(NUMBER 42)            # Integer (treated as string)
```  

Example 1: In the following example, creates a CMake variable named `PROJECT_INCLUDES` and assigns it the value `${PROJECT_SOURCE_DIR}/api`.  
	- Defines a variable: `PROJECT_INCLUDES` now holds the path to the `api/ subdirectory` in your project.  
	- `PROJECT_SOURCE_DIR`: This is a CMake-builtin variable pointing to your project’s root (where the top-level CMakeLists.txt lives).  

```sh
# Add include directory.
set( PROJECT_INCLUDES
     ${PROJECT_SOURCE_DIR}/api
)
```  

Example 2: `PROJECT_SOURCES` is variable name and `${PROJECT_SOURCE_DIR}/src/main.cpp` is th value assigned to it.

```sh
# Add all the source files.
set( PROJECT_SOURCES
     ${PROJECT_SOURCE_DIR}/src/main.cpp
)
```

- `include_directories()` Command:
	- The `include_directories()` command adds directories to the compiler's header search path, allowing your project to find header files (*.h, *.hpp) during compilation.
	- Example: include_directories( ${PROJECT_INCLUDES} )

```sh
# Add a single directory
include_directories(${PROJECT_SOURCE_DIR}/api)

OR

# Add multiple directories
include_directories(
    ${PROJECT_SOURCE_DIR}/api
    ${PROJECT_SOURCE_DIR}/third_party
)
```

- `add_executable()` Command:
	- The `add_executable()` command defines an executable target (a program you can run) from a list of source files (.cpp, .c, etc.).
	
```sh
add_executable(<target_name> [WIN32] [MACOSX_BUNDLE] [EXCLUDE_FROM_ALL] source1 [source2 ...])

* <target_name>: Name of the executable (e.g., my_app).
* source1, source2, ...: List of source files (.cpp, .c).
* Optional flags:
    * WIN32: Build as a Windows GUI app (no console).
    * MACOSX_BUNDLE: Create a macOS .app bundle.
    * EXCLUDE_FROM_ALL: Skip building this by default (build only when explicitly requested).
```  

Example:  

```sh
# Add executable target.
add_executable(${PROJECT_NAME} src/main.cpp)

OR

# Add the executable.
# It just required executable name (Which is project name in here) and Source includes.
# Build will be created with this name (${PROJECT_NAME})
add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
```  
