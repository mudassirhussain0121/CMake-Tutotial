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
	
## Project Structure

```
my_project/
├── CMakeLists.txt
├── api/
│   └── hello.h
├── src/
│   └── main.c
└── build/
```

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
	
```
project(<PROJECT-NAME>
	[VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
	[DESCRIPTION <project-description>]
	[LANGUAGES <language1> <language2>...]
)
``` 

Example 1:  
	
```
project(CMAKE_LEARNING) 

project(${PROJECT_NAME} VERSION 1.2)
```

Example 2: Can be define in one command.  

```
project(CMAKE_LEARNING
        VERSION 1.2
)
```  

- `set()` Command:
	- The `set()` command is used to define variables in CMake.
	- Variables can store strings, lists, paths, or boolean values, and they control how your project is configured, built, and installed.

```
set(<variable> <value>... [PARENT_SCOPE])

* <variable>: Name of the variable to set (case-sensitive).
* <value>...: Value(s) assigned (can be a single item or a list).
* [PARENT_SCOPE] (Optional): Propagates the variable to the parent scope (useful in functions/subdirectories).
```  

```
Example: Setting Simple Variables:

set(MY_NAME "John Doe")   # String
set(ENABLE_FEATURE ON)    # Boolean (ON/OFF)
set(NUMBER 42)            # Integer (treated as string)
```  

Example 1: In the following example, creates a CMake variable named `PROJECT_INCLUDES` and assigns it the value `${PROJECT_SOURCE_DIR}/api`.  
	- Defines a variable: `PROJECT_INCLUDES` now holds the path to the `api/ subdirectory` in your project.  
	- `PROJECT_SOURCE_DIR`: This is a CMake-builtin variable pointing to your project’s root (where the top-level CMakeLists.txt lives).  

```
# Add include directory.
set( PROJECT_INCLUDES
     ${PROJECT_SOURCE_DIR}/api
)
```  

Example 2: `PROJECT_SOURCES` is variable name and `${PROJECT_SOURCE_DIR}/src/main.cpp` is th value assigned to it.

```
# Add all the source files.
set( PROJECT_SOURCES
     ${PROJECT_SOURCE_DIR}/src/main.cpp
)
```

- `include_directories()` Command:
	- The `include_directories()` command adds directories to the compiler's header search path, allowing your project to find header files (*.h, *.hpp) during compilation.
	- Example: include_directories( ${PROJECT_INCLUDES} )

```
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
	
```
add_executable(<target_name> [WIN32] [MACOSX_BUNDLE] [EXCLUDE_FROM_ALL] source1 [source2 ...])

* <target_name>: Name of the executable (e.g., my_app).
* source1, source2, ...: List of source files (.cpp, .c).
* Optional flags:
    * WIN32: Build as a Windows GUI app (no console).
    * MACOSX_BUNDLE: Create a macOS .app bundle.
    * EXCLUDE_FROM_ALL: Skip building this by default (build only when explicitly requested).
```  

Example:  

```
# Add executable target.
add_executable(${PROJECT_NAME} src/main.cpp)

OR

# Add the executable.
# It just required executable name (Which is project name in here) and Source includes.
# Build will be created with this name (${PROJECT_NAME})
add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
```  

## Cmake Variables

- Project Information Variables:

```
Variable              Description                                               Example
------------------    ------------------------------------------------------    ---------------------------
PROJECT_NAME	      Name of the most recent project() call.	                "MyProject"
PROJECT_SOURCE_DIR    Full path to the source directory of the project.	        /home/user/my_project
PROJECT_BINARY_DIR    Full path to the build directory (where cmake runs).      /home/user/my_project/build
CMAKE_PROJECT_NAME    Name of the top-level project (useful in subprojects).    "MyProject"
```

- Directory Paths:

```
Variable                    Description                                        Example
------------------------    -----------------------------------------------    -------------------------------
CMAKE_SOURCE_DIR            Path to the top-level source directory.            /home/user/my_project
CMAKE_BINARY_DIR            Path to the top-level build directory.             /home/user/my_project/build
CMAKE_CURRENT_SOURCE_DIR    Path to the current CMakeLists.txt's directory.    /home/user/my_project/src
CMAKE_CURRENT_BINARY_DIR    Build directory for the current CMakeLists.txt.    /home/user/my_project/build/src
```

- System & Compiler Info:

```
Variable              Description                                         Example
------------------    ------------------------------------------------    ------------
CMAKE_SYSTEM_NAME     Operating system (e.g., Linux, Windows, Darwin).    "Linux"
CMAKE_C_COMPILER      Path to the C compiler.                             /usr/bin/gcc
CMAKE_CXX_COMPILER    Path to the C++ compiler.                           /usr/bin/g++
CMAKE_BUILD_TYPE      Build type (Debug, Release, RelWithDebInfo).        "Debug"
```

- Build Control Variables:

```
Variable                Description                                     Example
--------------------    --------------------------------------------    -------------------------
CMAKE_CXX_FLAGS         C++ compiler flags.                             "-Wall -Wextra"
CMAKE_INSTALL_PREFIX    Installation prefix (/usr/local by default).    "/opt/my_project"
CMAKE_MODULE_PATH       Paths to search for CMake modules.              "/path/to/custom/modules"
```

- Generator-Specific Variables:

```
Variable              Description                                              Example
------------------    -----------------------------------------------------    ----------------
CMAKE_GENERATOR       Build system generator (e.g., Unix Makefiles, Ninja).    "Unix Makefiles"
CMAKE_MAKE_PROGRAM    Path to the build tool (e.g., make, ninja).              /usr/bin/ninja
```

- Platform-Specific Variables:

```
Variable    Description                                          Example
--------    -------------------------------------------------    -------------
WIN32       TRUE on Windows systems.                             FALSE (Linux)
APPLE       TRUE on macOS/iOS.                                   TRUE (macOS)
UNIX        TRUE on Linux, macOS, or other Unix-like systems.    TRUE
```

- Dependency Management:

```
Variable               Description                                         Example
-------------------    ------------------------------------------------    ----------------------
CMAKE_PREFIX_PATH      Paths to search for dependencies.                   "/usr/local;/opt/libs"
<PackageName>_FOUND    TRUE if a package is found (e.g., OpenCV_FOUND).    TRUE
```
