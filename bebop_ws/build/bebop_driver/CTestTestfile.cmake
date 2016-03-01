# CMake generated Testfile for 
# Source directory: /home/robot/bebop_ws/src/bebop_autonomy/bebop_driver
# Build directory: /home/robot/bebop_ws/build/bebop_driver
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(_ctest_bebop_driver_rostest_test_bebop_itl_test.test "/home/robot/bebop_ws/build/bebop_driver/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/indigo/share/catkin/cmake/test/run_tests.py" "/home/robot/bebop_ws/build/bebop_driver/test_results/bebop_driver/rostest-test_bebop_itl_test.xml" "--return-code" "/opt/ros/indigo/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/robot/bebop_ws/src/bebop_autonomy/bebop_driver --package=bebop_driver --results-filename test_bebop_itl_test.xml --results-base-dir \"/home/robot/bebop_ws/build/bebop_driver/test_results\" /home/robot/bebop_ws/src/bebop_autonomy/bebop_driver/test/bebop_itl_test.test ")
SUBDIRS(gtest)
