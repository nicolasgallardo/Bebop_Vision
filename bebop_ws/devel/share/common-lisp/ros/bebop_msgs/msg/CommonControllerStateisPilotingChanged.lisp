; Auto-generated. Do not edit!


(cl:in-package bebop_msgs-msg)


;//! \htmlinclude CommonControllerStateisPilotingChanged.msg.html

(cl:defclass <CommonControllerStateisPilotingChanged> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (piloting
    :reader piloting
    :initarg :piloting
    :type cl:fixnum
    :initform 0))
)

(cl:defclass CommonControllerStateisPilotingChanged (<CommonControllerStateisPilotingChanged>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CommonControllerStateisPilotingChanged>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CommonControllerStateisPilotingChanged)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name bebop_msgs-msg:<CommonControllerStateisPilotingChanged> is deprecated: use bebop_msgs-msg:CommonControllerStateisPilotingChanged instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CommonControllerStateisPilotingChanged>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_msgs-msg:header-val is deprecated.  Use bebop_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'piloting-val :lambda-list '(m))
(cl:defmethod piloting-val ((m <CommonControllerStateisPilotingChanged>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_msgs-msg:piloting-val is deprecated.  Use bebop_msgs-msg:piloting instead.")
  (piloting m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CommonControllerStateisPilotingChanged>) ostream)
  "Serializes a message object of type '<CommonControllerStateisPilotingChanged>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'piloting)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CommonControllerStateisPilotingChanged>) istream)
  "Deserializes a message object of type '<CommonControllerStateisPilotingChanged>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'piloting)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CommonControllerStateisPilotingChanged>)))
  "Returns string type for a message object of type '<CommonControllerStateisPilotingChanged>"
  "bebop_msgs/CommonControllerStateisPilotingChanged")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CommonControllerStateisPilotingChanged)))
  "Returns string type for a message object of type 'CommonControllerStateisPilotingChanged"
  "bebop_msgs/CommonControllerStateisPilotingChanged")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CommonControllerStateisPilotingChanged>)))
  "Returns md5sum for a message object of type '<CommonControllerStateisPilotingChanged>"
  "58c8cfa4c09dedbc7459b83c5d31b9fd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CommonControllerStateisPilotingChanged)))
  "Returns md5sum for a message object of type 'CommonControllerStateisPilotingChanged"
  "58c8cfa4c09dedbc7459b83c5d31b9fd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CommonControllerStateisPilotingChanged>)))
  "Returns full string definition for message of type '<CommonControllerStateisPilotingChanged>"
  (cl:format cl:nil "# CommonControllerStateisPilotingChanged~%# auto-generated from https://raw.githubusercontent.com/Parrot-Developers/libARCommands/7e2f55fafcd45ba2380ca2574a08b7359c005f47/Xml/common_commands.xml~%# Do not modify this file by hand. Check scripts/meta folder for generator files.~%#~%# SDK Comment: Tell the device when the controller application enters/leaves the piloting HUD.~%~%Header header~%~%# 0 when the application is not in the piloting HUD, 1 when it enters the HUD.~%uint8 piloting~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CommonControllerStateisPilotingChanged)))
  "Returns full string definition for message of type 'CommonControllerStateisPilotingChanged"
  (cl:format cl:nil "# CommonControllerStateisPilotingChanged~%# auto-generated from https://raw.githubusercontent.com/Parrot-Developers/libARCommands/7e2f55fafcd45ba2380ca2574a08b7359c005f47/Xml/common_commands.xml~%# Do not modify this file by hand. Check scripts/meta folder for generator files.~%#~%# SDK Comment: Tell the device when the controller application enters/leaves the piloting HUD.~%~%Header header~%~%# 0 when the application is not in the piloting HUD, 1 when it enters the HUD.~%uint8 piloting~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CommonControllerStateisPilotingChanged>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CommonControllerStateisPilotingChanged>))
  "Converts a ROS message object to a list"
  (cl:list 'CommonControllerStateisPilotingChanged
    (cl:cons ':header (header msg))
    (cl:cons ':piloting (piloting msg))
))
