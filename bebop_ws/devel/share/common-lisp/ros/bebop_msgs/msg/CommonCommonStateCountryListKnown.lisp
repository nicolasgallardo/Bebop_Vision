; Auto-generated. Do not edit!


(cl:in-package bebop_msgs-msg)


;//! \htmlinclude CommonCommonStateCountryListKnown.msg.html

(cl:defclass <CommonCommonStateCountryListKnown> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (countryCodes
    :reader countryCodes
    :initarg :countryCodes
    :type cl:string
    :initform ""))
)

(cl:defclass CommonCommonStateCountryListKnown (<CommonCommonStateCountryListKnown>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CommonCommonStateCountryListKnown>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CommonCommonStateCountryListKnown)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name bebop_msgs-msg:<CommonCommonStateCountryListKnown> is deprecated: use bebop_msgs-msg:CommonCommonStateCountryListKnown instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CommonCommonStateCountryListKnown>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_msgs-msg:header-val is deprecated.  Use bebop_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'countryCodes-val :lambda-list '(m))
(cl:defmethod countryCodes-val ((m <CommonCommonStateCountryListKnown>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bebop_msgs-msg:countryCodes-val is deprecated.  Use bebop_msgs-msg:countryCodes instead.")
  (countryCodes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CommonCommonStateCountryListKnown>) ostream)
  "Serializes a message object of type '<CommonCommonStateCountryListKnown>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'countryCodes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'countryCodes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CommonCommonStateCountryListKnown>) istream)
  "Deserializes a message object of type '<CommonCommonStateCountryListKnown>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'countryCodes) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'countryCodes) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CommonCommonStateCountryListKnown>)))
  "Returns string type for a message object of type '<CommonCommonStateCountryListKnown>"
  "bebop_msgs/CommonCommonStateCountryListKnown")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CommonCommonStateCountryListKnown)))
  "Returns string type for a message object of type 'CommonCommonStateCountryListKnown"
  "bebop_msgs/CommonCommonStateCountryListKnown")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CommonCommonStateCountryListKnown>)))
  "Returns md5sum for a message object of type '<CommonCommonStateCountryListKnown>"
  "f1be805252f69f504c97e66eab70f6b7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CommonCommonStateCountryListKnown)))
  "Returns md5sum for a message object of type 'CommonCommonStateCountryListKnown"
  "f1be805252f69f504c97e66eab70f6b7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CommonCommonStateCountryListKnown>)))
  "Returns full string definition for message of type '<CommonCommonStateCountryListKnown>"
  (cl:format cl:nil "# CommonCommonStateCountryListKnown~%# auto-generated from https://raw.githubusercontent.com/Parrot-Developers/libARCommands/7e2f55fafcd45ba2380ca2574a08b7359c005f47/Xml/common_commands.xml~%# Do not modify this file by hand. Check scripts/meta folder for generator files.~%#~%# SDK Comment: List of the countries known by the device~%~%Header header~%~%# Following of country code with ISO 3166 format, separated by ;. Be careful of the command size allowed by the network used. If necessary, split the list in several commands.~%string countryCodes~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CommonCommonStateCountryListKnown)))
  "Returns full string definition for message of type 'CommonCommonStateCountryListKnown"
  (cl:format cl:nil "# CommonCommonStateCountryListKnown~%# auto-generated from https://raw.githubusercontent.com/Parrot-Developers/libARCommands/7e2f55fafcd45ba2380ca2574a08b7359c005f47/Xml/common_commands.xml~%# Do not modify this file by hand. Check scripts/meta folder for generator files.~%#~%# SDK Comment: List of the countries known by the device~%~%Header header~%~%# Following of country code with ISO 3166 format, separated by ;. Be careful of the command size allowed by the network used. If necessary, split the list in several commands.~%string countryCodes~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CommonCommonStateCountryListKnown>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'countryCodes))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CommonCommonStateCountryListKnown>))
  "Converts a ROS message object to a list"
  (cl:list 'CommonCommonStateCountryListKnown
    (cl:cons ':header (header msg))
    (cl:cons ':countryCodes (countryCodes msg))
))
