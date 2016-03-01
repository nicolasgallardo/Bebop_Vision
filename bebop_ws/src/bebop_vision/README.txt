---------ON ROS MASTER (YOUR COMPUTER)-----------

bebop driver:

roslaunch bebop_driver bebop_node.launch (alias = bebop)

-----------------ON KOBUKI-----------------------

launch the kobuki:

roslaunch kobuki_node minimal.launch (alias = k_launch)

angle feedback:

rosrun kobuki_controller controller.py (alias = k_angle)

---------BACK TO ROS MASTER (YOUR COMPUTER)------

color tracking:

rosrun bebop_vision bebop_color_track_node (alias = color_track)

view video feed:

rqt -s rqt_image_view (alias = video)

keyboard controller:

rosrun bebop_vision teleop_twist_keyboard.py (alias = b_controller)

formation control:

rosrun bebop_vision formation_control (alias = f_control)



