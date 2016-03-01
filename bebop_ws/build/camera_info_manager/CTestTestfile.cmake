# CMake generated Testfile for 
# Source directory: /home/robot/bebop_ws/src/image_common/camera_info_manager
# Build directory: /home/robot/bebop_ws/build/camera_info_manager
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(_ctest_camera_info_manager_rostest_tests_unit_test.test "/home/robot/bebop_ws/build/camera_info_manager/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/indigo/share/catkin/cmake/test/run_tests.py" "/home/robot/bebop_ws/build/camera_info_manager/test_results/camera_info_manager/rostest-tests_unit_test.xml" "--return-code" "/opt/ros/indigo/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/robot/bebop_ws/src/image_common/camera_info_manager --package=camera_info_manager --results-filename tests_unit_test.xml --results-base-dir \"/home/robot/bebop_ws/build/camera_info_manager/test_results\" /home/robot/bebop_ws/src/image_common/camera_info_manager/tests/unit_test.test ")
SUBDIRS(gtest)
