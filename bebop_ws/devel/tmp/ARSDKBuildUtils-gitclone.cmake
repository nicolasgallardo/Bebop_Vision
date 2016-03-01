if("ARSDK3_version_3_6" STREQUAL "")
  message(FATAL_ERROR "Tag for git checkout should not be empty.")
endif()

set(run 0)

if("/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitinfo.txt" IS_NEWER_THAN "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitclone-lastrun.txt")
  set(run 1)
endif()

if(NOT run)
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/robot/bebop_ws/devel/src/ARSDKBuildUtils'")
endif()

# try the clone 3 times incase there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git" clone "https://github.com/ARDroneSDK3/ARSDKBuildUtils.git" "ARSDKBuildUtils"
    WORKING_DIRECTORY "/home/robot/bebop_ws/devel/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/ARDroneSDK3/ARSDKBuildUtils.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git" checkout ARSDK3_version_3_6
  WORKING_DIRECTORY "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'ARSDK3_version_3_6'")
endif()

execute_process(
  COMMAND "/usr/bin/git" submodule init
  WORKING_DIRECTORY "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to init submodules in: '/home/robot/bebop_ws/devel/src/ARSDKBuildUtils'")
endif()

execute_process(
  COMMAND "/usr/bin/git" submodule update --recursive
  WORKING_DIRECTORY "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/home/robot/bebop_ws/devel/src/ARSDKBuildUtils'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitinfo.txt"
    "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitclone-lastrun.txt"
  WORKING_DIRECTORY "/home/robot/bebop_ws/devel/src/ARSDKBuildUtils"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/robot/bebop_ws/devel/src/ARSDKBuildUtils-stamp/ARSDKBuildUtils-gitclone-lastrun.txt'")
endif()

