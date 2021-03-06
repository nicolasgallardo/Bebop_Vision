# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/robot/bebop_ws/src/bebop_autonomy/bebop_driver

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/robot/bebop_ws/build/bebop_driver

# Utility rule file for ARSDKBuildUtils.

# Include the progress variables for this target.
include CMakeFiles/ARSDKBuildUtils.dir/progress.make

CMakeFiles/ARSDKBuildUtils: CMakeFiles/ARSDKBuildUtils-complete

CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-install
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-mkdir
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-update
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-patch
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-build
CMakeFiles/ARSDKBuildUtils-complete: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-install
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Completed 'ARSDKBuildUtils'"
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/build/bebop_driver/CMakeFiles
	/usr/bin/cmake -E touch /home/robot/bebop_ws/build/bebop_driver/CMakeFiles/ARSDKBuildUtils-complete
	/usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-done

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-install: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-build
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Performing install step for 'ARSDKBuildUtils'"
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && echo "No install"
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && /usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-install

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-mkdir:
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Creating directories for 'ARSDKBuildUtils'"
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/devel/src/ARSDKBuildUtils
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/devel/src/ARSDKBuildUtils
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/devel
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/devel/tmp
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp
	/usr/bin/cmake -E make_directory /home/robot/bebop_ws/devel/src
	/usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-mkdir

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitinfo.txt
/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-mkdir
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Performing download step (git clone) for 'ARSDKBuildUtils'"
	cd /home/robot/bebop_ws/devel/src && /usr/bin/cmake -P /home/robot/bebop_ws/devel/tmp/ARSDKBuildUtils-gitclone.cmake
	cd /home/robot/bebop_ws/devel/src && /usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-update: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_5)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Performing update step for 'ARSDKBuildUtils'"
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && /usr/bin/cmake -P /home/robot/bebop_ws/devel/tmp/ARSDKBuildUtils-gitupdate.cmake

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-patch: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_6)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "No patch step for 'ARSDKBuildUtils'"
	/usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-patch

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure: /home/robot/bebop_ws/devel/tmp/ARSDKBuildUtils-cfgcmd.txt
/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-update
/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-patch
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_7)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Performing configure step for 'ARSDKBuildUtils'"
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && echo "No configure"
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && /usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure

/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-build: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure
	$(CMAKE_COMMAND) -E cmake_progress_report /home/robot/bebop_ws/build/bebop_driver/CMakeFiles $(CMAKE_PROGRESS_8)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Performing build step for 'ARSDKBuildUtils'"
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && ./SDK3Build.py -t Unix
	cd /home/robot/bebop_ws/devel/src/ARSDKBuildUtils && /usr/bin/cmake -E touch /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-build

ARSDKBuildUtils: CMakeFiles/ARSDKBuildUtils
ARSDKBuildUtils: CMakeFiles/ARSDKBuildUtils-complete
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-install
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-mkdir
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-download
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-update
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-patch
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-configure
ARSDKBuildUtils: /home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-build
ARSDKBuildUtils: CMakeFiles/ARSDKBuildUtils.dir/build.make
.PHONY : ARSDKBuildUtils

# Rule to build all files generated by this target.
CMakeFiles/ARSDKBuildUtils.dir/build: ARSDKBuildUtils
.PHONY : CMakeFiles/ARSDKBuildUtils.dir/build

CMakeFiles/ARSDKBuildUtils.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ARSDKBuildUtils.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ARSDKBuildUtils.dir/clean

CMakeFiles/ARSDKBuildUtils.dir/depend:
	cd /home/robot/bebop_ws/build/bebop_driver && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/robot/bebop_ws/src/bebop_autonomy/bebop_driver /home/robot/bebop_ws/src/bebop_autonomy/bebop_driver /home/robot/bebop_ws/build/bebop_driver /home/robot/bebop_ws/build/bebop_driver /home/robot/bebop_ws/build/bebop_driver/CMakeFiles/ARSDKBuildUtils.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ARSDKBuildUtils.dir/depend

