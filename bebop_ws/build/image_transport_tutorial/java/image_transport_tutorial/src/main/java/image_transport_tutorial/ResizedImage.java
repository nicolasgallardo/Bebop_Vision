package image_transport_tutorial;

public interface ResizedImage extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "image_transport_tutorial/ResizedImage";
  static final java.lang.String _DEFINITION = "uint32 original_height\nuint32 original_width\nsensor_msgs/Image image\n";
  int getOriginalHeight();
  void setOriginalHeight(int value);
  int getOriginalWidth();
  void setOriginalWidth(int value);
  sensor_msgs.Image getImage();
  void setImage(sensor_msgs.Image value);
}
