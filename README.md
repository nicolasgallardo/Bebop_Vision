# Bebop_Vision

Processes:
1. Implements a ROS version of color tracking using OpenCV found here:

2. Formation control based on color coded UGV's.

email for support: hbq744@my.utsa.edu

I will be working on making this a more formal ROS package download. As for right now you can copy/paste bebop_ws/src/bebop_vision
into your ROS workspace and try to catkin_make or alternatively, I use catkin build -DCMAKE_BUILD_TYPE=RelWithDebInfo

If you get errors its most likely because you are missing dependencies. This package uses OpenCV and the bebop_autonomy driver, you will also need a bebop drone.
