#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/imgproc/imgproc.hpp>
//#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <stdlib.h>
#include <stdio.h>

using namespace cv;
/// Global variables
Mat src, src_gray;
Mat dst, detected_edges;
Mat * dst_ptr;
int edgeThresh = 1;
int lowThreshold = 10;
int const max_lowThreshold = 100;
int ratio = 3;
int kernel_size = 3;
const char* window_name = "Edge Map";
//static const std::string OPENCV_WINDOW = "Image window";

class ImageConverter
{
ros::NodeHandle nh_;
image_transport::ImageTransport it_;
image_transport::Subscriber image_sub_;
image_transport::Publisher image_pub_;

public:
ImageConverter()
: it_(nh_)
{
// Subscrive to input video feed and publish output video feed
image_sub_ = it_.subscribe("/bebop/image_raw", 1, 
&ImageConverter::imageCb, this);
image_pub_ = it_.advertise("/bebop_vision/output_video", 1);

//cv::namedWindow(OPENCV_WINDOW);
}

~ImageConverter()
{
//cv::destroyWindow(OPENCV_WINDOW);
}

void imageCb(const sensor_msgs::ImageConstPtr& msg)
{
cv_bridge::CvImagePtr cv_ptr;
try
{
cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
}
	catch (cv_bridge::Exception& e)
{
ROS_ERROR("cv_bridge exception: %s", e.what());
return;
}
src = cv_ptr->image;
//ROS_INFO("Rows_src: %s", src.rows);
//ROS_INFO("Cols_src %s", src.cols);
/// Create a matrix of the same type and size as src (for dst)
dst.create( src.size(), src.type() );
/// Convert the image to grayscale
cvtColor( src, src_gray, COLOR_BGR2GRAY );
/// Create a Trackbar for user to enter threshold
//createTrackbar( "Min Threshold:", window_name, &lowThreshold, max_lowThreshold, CannyThreshold );
/// Show the image
/// Reduce noise with a kernel 3x3
blur( src_gray, detected_edges, Size(3,3) );
/// Canny detector
Canny( detected_edges, detected_edges, lowThreshold, lowThreshold*ratio, kernel_size );
/// Using Canny's output as a mask, we display our result
dst = Scalar::all(0);
src.copyTo( dst, detected_edges);
//ROS_INFO("Rows_dst: %s", dst.rows);
//ROS_INFO("Cols_dst %s", dst.cols);
cv_bridge::CvImage dst_out;
dst_out.header   = cv_ptr->header; // Same timestamp and tf frame as input image
dst_out.encoding = sensor_msgs::image_encodings::MONO16; // Or whatever
dst_out.image    = dst; // Your cv::Mat

//saliency_img_pub.publish(out_msg.toImageMsg());
// Output modified video stream
image_pub_.publish(dst_out.toImageMsg());

/// Create a window
namedWindow( window_name, CV_WINDOW_AUTOSIZE );
/// Create a Trackbar for user to enter threshold
createTrackbar( "Min Threshold:", window_name, &lowThreshold, max_lowThreshold);

/*    // Draw an example circle on the video stream
if (cv_ptr->image.rows > 60 && cv_ptr->image.cols > 60)
cv::circle(cv_ptr->image, cv::Point(50, 50), 10, CV_RGB(255,0,0));

// Update GUI Window
cv::imshow(OPENCV_WINDOW, cv_ptr->image);
cv::waitKey(3);

// Output modified video stream
image_pub_.publish(cv_ptr->toImageMsg()); */
}
};

int main(int argc, char** argv)
{
ros::init(argc, argv, "image_converter");
ImageConverter ic;
ros::spin();
return 0;
}
