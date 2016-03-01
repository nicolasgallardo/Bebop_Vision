//Title/Info
//blue koboki = red
//orange kobuki = yellow
//purple kobuki = green

// Include Files
#include <ros/ros.h>
#include <stdlib.h>
#include <stdio.h>
#include <yocs_controllers/default_controller.hpp>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Point.h>
#include <math.h>
#include <ros/transport_hints.h>

// Global Variable
int dvl_x0[] = {0,0,0};
int dvl_y0[] = {0,0,0};
int da_x0[] = {0,0,0};
int da_y0[] = {0,0,0};
int dvl_x[] = {0,0,0};
int dvl_y[] = {0,0,0};
int da_x[] = {0,0,0};
int da_y[] = {0,0,0};
int xPos[] = {0,0,0,0};
int yPos[] = {0,0,0,0};
int xPos_last[] = {0,0,0,0};
int yPos_last[] = {0,0,0,0};
//float xPos[] = {0.0,0.0,0.0,0.0};
//float yPos[] = {0.0,0.0,0.0,0.0};
int firstIter = 0;
int iter = 0;
int init_X = 0;
int init_Y = 0;
int thetaLock = 0;
double leadForceX[] = {0.0,0.0,0.0};
double leadForceY[] = {0.0,0.0,0.0};
double agentForceX[] = {0.0,0.0,0.0};
double agentForceY[] = {0.0,0.0,0.0};
double totalForceX[] = {0.0,0.0,0.0};
double totalForceY[] = {0.0,0.0,0.0};
double totalForce[] = {0.0,0.0,0.0};
double theta[] = {0.0,0.0,0.0};
double theta_raw[] = {0.0,0.0,0.0};
double currTheta_blue = 0.0;
double currTheta_purp = 0.0;
double currTheta_orange = 0.0;
double targetTheta_blue = 0.0;
double targetTheta_purp= 0.0;
double targetTheta_orange = 0.0;
double errorTheta_blue = 0.0;
double errorTheta_purp = 0.0;
double errorTheta_orange = 0.0;
double lastError_blue= 0.0;
double lastError_purp = 0.0;
double lastError_orange = 0.0;
int color = 0; 
int blueL = 0;
int orangeL = 0;
int purpL = 0;
// Constants 
const float K_vl = 1.0;
const float K_ij = 0.2;
const int K_vel = 1;
const float forceLimit = 5.0;
const int numAgents = 3;
const float Kp = 1.0;
const float Kd = 0.75;
const float speed_theta = 1.0;
const float speed = .5;
const float PI = 3.14159265;
float start_time = 0.0;
bool not_triggered = true;
//yaw_direction = 1
float low_limit = 0.2;
float high_limit = 4.0;

class Move
{
	ros::NodeHandle n;
	ros::Publisher move_purp;
	ros::Publisher move_orange;
	ros::Publisher move_blue;	
	ros::Publisher initPosVL;
	ros::Subscriber pos_sub;
	ros::Subscriber pos_VL;
	ros::Subscriber theta_purp;
	ros::Subscriber theta_orange;
	ros::Subscriber theta_blue;
	geometry_msgs::Point initial_VL;
	geometry_msgs::Twist movement_purp;
	geometry_msgs::Twist movement_orange;
	geometry_msgs::Twist movement_blue;
//	geometry_msgs::Vector3 theta_purp;
//	geometry_msgs::Vector3 theta_orange;
//	geometry_msgs::Vector3 theta_blue;

	public:
	Move()
	{
		pos_sub = n.subscribe<geometry_msgs::Point>("/bebop_vision/position", 50,&Move::positionCB,this,ros::TransportHints().tcpNoDelay(true));
		pos_VL = n.subscribe<geometry_msgs::Point>("/formation_control/VLPosition",50, &Move::vlCB,this,ros::TransportHints().tcpNoDelay(true));
		move_purp = n.advertise<geometry_msgs::Twist>("/don/mobile_base/commands/velocity", 50);
		move_orange = n.advertise<geometry_msgs::Twist>("/mikey/mobile_base/commands/velocity", 50);
		move_blue = n.advertise<geometry_msgs::Twist>("/leo/mobile_base/commands/velocity", 50);
		initPosVL = n.advertise<geometry_msgs::Point>("/formation_control/initVL",50);
		theta_purp = n.subscribe<geometry_msgs::Vector3>("/don/mobile_base/commands/eulerRPY", 50,&Move::thetaDonCB,this,ros::TransportHints().tcpNoDelay(true));
		theta_orange = n.subscribe<geometry_msgs::Vector3>("/mikey/mobile_base/commands/eulerRPY", 50,&Move::thetaMikeyCB,this,ros::TransportHints().tcpNoDelay(true));
		theta_blue = n.subscribe<geometry_msgs::Vector3>("/leo/mobile_base/commands/eulerRPY", 50,&Move::thetaLeoCB,this,ros::TransportHints().tcpNoDelay(true));
	}
	~Move(){}
	
	public:
	void positionCB(const geometry_msgs::Point::ConstPtr& msg)
	{	
		//ROS_INFO("IN POSITION CB");
		if(firstIter == 0)
		{
			color = msg->z;
			xPos[color] = msg->x;
			yPos[color] = msg->y;
			yPos[color] = yPos[color] * -1;
		}
		else
		{
			color = msg->z;
			xPos[color] = msg->x;
			yPos[color] = msg->y;
			yPos[color] = yPos[color] * -1;
			if((xPos[color] - xPos_last[color] > 30 || xPos[color] - xPos_last[color] < -30) || (yPos[color] - yPos_last[color] > 30 || yPos[color] - yPos_last[color] < -30))
			{	
				xPos[color] = xPos_last[color];
				yPos[color] = yPos_last[color];
			}
			else
			{
				xPos_last[color] = xPos[color];
				yPos_last[color] = yPos[color];
			}
		}
		iter++;
		//ROS_INFO("X = %d, Y = %d, color = %d",xPos[color],yPos[color], color);

		
		if(iter == numAgents)
		{
			if(firstIter == 0)
			{
				for(int i = 0; i < numAgents;i++)
				{
					init_X = init_X + xPos[i];
					init_Y = init_Y + yPos[i];
					xPos_last[i] = xPos[i];
					yPos_last[i] = yPos[i];
					//ROS_INFO("X = %d, Y = %d",xPos[i],yPos[i]);	
				}
				init_X = init_X/numAgents;
				init_Y = init_Y/numAgents;	
				xPos[numAgents] = init_X;
				yPos[numAgents] = init_Y;
				initial_VL.x = init_X;
				initial_VL.y = init_Y;
				initial_VL.z = 0.0;
				initPosVL.publish(initial_VL);				
				//ROS_INFO("VL X = %d, VL Y = %d",init_X,init_Y);			
			}
			forceCalc(xPos,yPos,numAgents);
			iter = 0;
		}
	}
	
	void vlCB(const geometry_msgs::Point::ConstPtr& msg)
	{
		xPos[numAgents] = msg->x;
		yPos[numAgents] = (msg->y)*-1.0;
	}
	
	void thetaDonCB(const geometry_msgs::Vector3::ConstPtr& msg)
	{
		//ROS_INFO("IN THETA DON CB");
		lastError_purp = currTheta_purp;
		currTheta_purp = msg->z;
		//errorTheta_purp = targetTheta_purp - currTheta_purp;
		//ROS_INFO("THETA PURPLE= %f", currTheta_purp);
		if(targetTheta_purp >= currTheta_purp)
		{
			errorTheta_purp = targetTheta_purp - currTheta_purp;
		}
		if(targetTheta_purp < currTheta_purp)
		{
			errorTheta_purp = 360.0 - currTheta_purp + targetTheta_purp;
		}
		//ROS_INFO("ERROR_PURPLE = %f", errorTheta_purp);
	}
	
	void thetaMikeyCB(const geometry_msgs::Vector3::ConstPtr& msg)
	{
		//ROS_INFO("IN THETA MIKE CB");
		lastError_orange = currTheta_orange;
		currTheta_orange = msg->z;
		//errorTheta_orange = targetTheta_orange - currTheta_orange;
		if(targetTheta_orange >= currTheta_orange)
		{
			errorTheta_orange = targetTheta_orange - currTheta_orange;
		}
		if(targetTheta_orange < currTheta_orange)
		{
			errorTheta_orange = 360.0 - currTheta_orange + targetTheta_orange;
		}
		//ROS_INFO("ERROR_ORANGE = %f", errorTheta_orange);
	}
	
	void thetaLeoCB(const geometry_msgs::Vector3::ConstPtr& msg)
	{
		//ROS_INFO("IN THETA LEO CB");
		lastError_blue = currTheta_blue;
		currTheta_blue = msg->z;
		//errorTheta_blue = targetTheta_blue - currTheta_blue;
		if(targetTheta_blue >= currTheta_blue)
		{
			errorTheta_blue = targetTheta_blue - currTheta_blue;
		}
		if(targetTheta_blue < currTheta_blue)
		{
			errorTheta_blue = 360.0 - currTheta_blue + targetTheta_blue;
		}
		//ROS_INFO("ERROR_BLUE = %f", errorTheta_blue);
	}

	void forceCalc(int xPos[],int yPos[],int numAgents)
	{	
		//ROS_INFO("IN FORCE CALC");
		// If this is the first iteration through the program
		// calculate the equilibrium (initial) distances 
		if(firstIter == 0)
		{
			//ROS_INFO("IN FIRST ITER");
			for(int i = 0; i <= numAgents-1; i++)
			{
				//ROS_INFO("IN FIRST ITER FOR LOOP");
				//dvl_x0[i] = xPos[numAgents] - xPos[i] ;
				//dvl_y0[i]= yPos[numAgents] - yPos[i];
				dvl_x0[i] = init_X - xPos[i] ;
				dvl_y0[i]= init_Y - yPos[i];
				if(i != numAgents-1)
				{
					da_x0[i] = xPos[i+1] - xPos[i];
					da_y0[i] = yPos[i+1] - yPos[i];				
				}
				else
				{
					da_x0[i] = xPos[0] - xPos[numAgents-1];
					da_y0[i] = yPos[0] - yPos[numAgents-1];
				}
			}
			// Since this is the first iteration, these positions are
			// assumed to be equilibrium, therefore all forces are 0.	
			leadForceX[numAgents] = {0.0};
			leadForceY[numAgents] = {0.0};
			agentForceX[numAgents] = {0.0};
			agentForceY[numAgents] = {0.0};
		    totalForceX[numAgents] = {0.0};
			totalForceY[numAgents] = {0.0};	
			//totalForceCalc(totalForceX,totalForceY,numAgents);
			firstIter = 1;
			//ROS_INFO("FIRST ITER = %d",firstIter);
		}
		else
		{
			for(int i = 0; i <= numAgents-1; i++)
			{
				//ROS_INFO("IN SECOND ITER");
				// Calculate distances for virtual leader and neighboring agents.
				dvl_x[i] = xPos[numAgents] - xPos[i];
				dvl_y[i]= yPos[numAgents] - yPos[i];
				if(i != numAgents-1)
				{
					da_x[i] = xPos[i+1] - xPos[i];
					da_y[i] = yPos[i+1] - yPos[i];				
				}
				else
				{
					da_x[i] = xPos[0] - xPos[numAgents-1];
					da_y[i] = yPos[0] - yPos[numAgents-1];
				}
				// Calculate the forces for the virtual leader and neighboring agents.
				leadForceX[i] = K_vl*(dvl_x[i] - dvl_x0[i]);
				leadForceY[i] = K_vl*(dvl_y[i] - dvl_y0[i]);
				agentForceX[i] = K_ij*(da_x[i] - da_x0[i]);
				agentForceY[i] = K_ij*(da_y[i] - da_y0[i]);	
				totalForceX[i] = leadForceX[i] + agentForceX[i];
				totalForceY[i] = leadForceY[i] + agentForceY[i];
			}
			totalForceCalc(totalForceX,totalForceY,numAgents);	
		}
	}

	void totalForceCalc(double fX[],double fY[],int numAgents)
	{
		//ROS_INFO("Fx_BLUE = %f , Fx_ORANGE = %f, Fx_PURPLE = %f", fX[0], fX[1], fX[2]);
		//ROS_INFO("Fy_BLUE = %f , Fy_ORANGE = %f, Fy_PURPLE = %f", fY[0], fY[1], fY[2]);
		//ROS_INFO("Fy_BLUE = %f , Fy_ORANGE = %f, Fy_PURPLE = %f", fabs(fY[0]), fabs(fY[1]), fabs(fY[2]));
		
		//ROS_INFO("IN TOTAL FORCE CALC");
		for(int i = 0; i <= numAgents-1; i++)
		{	
		if(abs(fX[i]) < forceLimit && abs(fY[i]) < forceLimit)
		{
			theta[i] = 0.0;
			totalForce[i] = 0.0;
		}
		else
		{	
			if(fX[i] < 0.1 && fX[i] >= 0.0)
			{
				fX[i] = 0.1;
			}
			else if(fX[i] > -0.1 && fX[i] < 0.0)
			{
				fX[i] = -0.1;
			}
			theta_raw[i] = atan2(fY[i],fX[i]);
			//theta[i] = theta_raw[i];
			if(theta_raw[i] < 0.0)
			{
				theta[i] = theta_raw[i] + 2.0*PI;
			}
			else
			{
				theta[i] = theta_raw[i];
			}
			totalForce[i] = sqrt(pow(fX[i],2.0) + pow(fY[i],2.0));
			//if(fX[i] > fY[i])
			//{
				//totalForce[i] = fX[i]/(cos(theta[i]));
			//}
			//else
			//{
				//totalForce[i] = fY[i]/(sin(theta[i]));
			//}
			//if(fX[i] < 0.0 && fY[i] >= 0.0)
			//{
				//theta[i] = PI - theta[i];
			//}
			//else if(fX[i] < 0.0 && fY[i] <= 0.0)
			//{
				//theta[i] = PI + theta[i];
			//} 
			//else if(fX[i] > 0.0 && fY[i] <= 0.0)
			//{
				//theta[i] = 2.0*PI - theta[i];
			//}

		}
		theta[i] = theta[i]*(180.0/PI);
		}	
		//ROS_INFO("F_BLUE = %f , F_ORANGE = %f, F_PURPLE = %f", ((abs(totalForce[0])*1.5)/450.0), ((abs(totalForce[1])*1.5)/450.0), ((abs(totalForce[2])*1.5)/450.0));
		ROS_INFO("T_YELLOW = %f , T_GREEN = %f, T_RED = %f", theta[2], theta[1], theta[0]);
		ROS_INFO("E_YELLOW = %f , E_GREEN = %f, E_RED = %f", errorTheta_blue, errorTheta_orange, errorTheta_purp);
		//ROS_INFO("F_BLUE = %f , F_ORANGE = %f, F_PURPLE = %f", totalForce[0], totalForce[1], totalForce[2]);
		//velCmd(totalForce,theta);
		targetTheta_blue = theta[2];
		targetTheta_purp = theta[0];
		targetTheta_orange = theta[1];
		moveMikey(totalForce[1]);
		moveLeo(totalForce[2]);
		moveDon(totalForce[0]);
		
		
	}
	//Move in parrallel///////
	
	void moveMikey(double totalForce_cmd)
	{
		
		if(errorTheta_orange > 5.0 && errorTheta_orange < 355.0)
		{
				movement_orange.linear.x = 0.0;
				movement_orange.linear.y = 0.0;
				movement_orange.linear.z = 0.0;
				movement_orange.angular.x = 0.0;
				movement_orange.angular.y = 0.0;
				movement_orange.angular.z = 0.0;
		//movement_orange.angular.z = Kp * (errorTheta_orange*5.0/360.0);// + Kd * ((errorTheta_orange*1.5/360.0) - (lastError_orange*1.5/360.0));
				if(errorTheta_orange <= 180.0)
				{
					movement_orange.angular.z = 0.4;
				}
				else
				{
					movement_orange.angular.z = -0.4;
				}
				//move_orange.publish(movement_orange);
		}
		else
		{
			movement_orange.linear.y = 0.0;
			if(speed*(totalForce_cmd/400.0) > 1.0)
			{
				movement_orange.linear.x = 1.0;
			}
			else
			{
				movement_orange.linear.x = speed*((totalForce_cmd)/400.0);
			}
			movement_orange.linear.z = 0.0;
			movement_orange.angular.x = 0.0;
			movement_orange.angular.y = 0.0;
			movement_orange.angular.z = 0.0;
			ROS_INFO("IN MOVE ORANGE");
		//move_orange.publish(movement_orange);
			
		}
		move_orange.publish(movement_orange);
	}
	
	void moveDon(double totalForce_cmd)
	{
		if(errorTheta_purp > 5.0 && errorTheta_purp < 355.0)
		{
				movement_purp.linear.x = 0.0;
				movement_purp.linear.y = 0.0;
				movement_purp.linear.z = 0.0;
				movement_purp.angular.x = 0.0;
				movement_purp.angular.y = 0.0;
		//movement_orange.angular.z = Kp * (errorTheta_orange*5.0/360.0);// + Kd * ((errorTheta_orange*1.5/360.0) - (lastError_orange*1.5/360.0));
				if(errorTheta_purp <= 180.0)
				{
					movement_purp.angular.z = 0.4;
				}
				else
				{
					movement_purp.angular.z = -0.4;
				}
				//move_purp.publish(movement_purp);
		}
		else
		{
			movement_purp.linear.y = 0.0;
			if(speed*(totalForce_cmd/400.0) > 1.0)
			{
				movement_purp.linear.x = 1.0;
			}
			else
			{
				movement_purp.linear.x = speed*(totalForce_cmd/400.0);
			}
			movement_purp.linear.z = 0.0;
			movement_purp.angular.x = 0.0;
			movement_purp.angular.y = 0.0;
			movement_purp.angular.z = 0.0;
			ROS_INFO("IN MOVE PURPLE");
			//move_purp.publish(movement_purp);
			
		}
		move_purp.publish(movement_purp);
	}
	
	void moveLeo(double totalForce_cmd)
	{
		if(errorTheta_blue > 5.0 && errorTheta_blue < 355.0)
		{
				movement_blue.linear.x = 0.0;
				movement_blue.linear.y = 0.0;
				movement_blue.linear.z = 0.0;
				movement_blue.angular.x = 0.0;
				movement_blue.angular.y = 0.0;
		//movement_orange.angular.z = Kp * (errorTheta_orange*5.0/360.0);// + Kd * ((errorTheta_orange*1.5/360.0) - (lastError_orange*1.5/360.0));
				if(errorTheta_blue <= 180.0)
				{
					movement_blue.angular.z = 0.4;
				}
				else
				{
					movement_blue.angular.z = -0.4;
				}
			//move_blue.publish(movement_blue);
		}
		else
		{
			movement_blue.linear.y = 0.0;
			if(speed*(totalForce_cmd/400.0) > 1.0)
			{
				movement_blue.linear.x = 1.0;
			}
			else
			{
				movement_blue.linear.x = speed*(totalForce_cmd/400.0);
			}
			movement_blue.linear.z = 0.0;
			movement_blue.angular.x = 0.0;
			movement_blue.angular.y = 0.0;
			movement_blue.angular.z = 0.0;
			ROS_INFO("IN MOVE BLUE");
			//move_blue.publish(movement_blue);
			
		}
		move_blue.publish(movement_blue);
	}
	
	///////////////////
	
	
	void velCmd(double totalForce_cmd[], double theta_cmd[])
	{
	//ROS_INFO("T_BLUE_RAW = %f , T_ORANGE_RAW = %f, T_PURPLE_RAW = %f", theta_raw[0]*180.0/PI, theta_raw[1]*180.0/PI, theta_raw[2]*180.0/PI);
	//ROS_INFO("T_BLUE = %f , T_ORANGE = %f, T_PURPLE = %f", theta_cmd[0], theta_cmd[1], theta_cmd[2]);
	targetTheta_blue = theta_cmd[0];
	targetTheta_purp = theta_cmd[2];
	targetTheta_orange = theta_cmd[1];

	if((errorTheta_blue < 5.0 || errorTheta_blue > 355.0) && (errorTheta_orange < 5.0 || errorTheta_orange > 355.0) && (errorTheta_purp < 5.0 || errorTheta_purp > 355.0))
	{
		thetaLock = 0;
		blueL = 0;
		orangeL = 0;
		purpL = 0;
	}
	
	else
	{
		thetaLock = 1;
	}
	
	if(thetaLock == 1)
	{
		//ROS_INFO("IN THETA COMMAND");
		if(errorTheta_blue > 4.0)// && errorTheta_blue < 350.0)
		{
		//ROS_INFO("IN ROTATE BLUE");
		movement_blue.linear.x = 0.0;
		movement_blue.linear.y = 0.0;
		movement_blue.linear.z = 0.0;
		movement_blue.angular.x = 0.0;
		movement_blue.angular.y = 0.0;
		//movement_blue.angular.z =  Kp * (errorTheta_blue*5.0/360.0);
			if(errorTheta_blue <= 180.0)
			{
			movement_blue.angular.z = 0.6;
			}
			else
			{
			movement_blue.angular.z = -0.6;
			}
		}
		else
		{
		movement_blue.linear.x = 0.0;
		movement_blue.linear.y = 0.0;
		movement_blue.linear.z = 0.0;
		movement_blue.angular.x = 0.0;
		movement_blue.angular.y = 0.0;
		movement_blue.angular.z = 0.0;
		//blueL = 1;
		}
	
		if(errorTheta_purp > 4.0)//errorTheta_purp < 350.0)
		{
		//ROS_INFO("IN ROTATE PURPLE");
		movement_purp.linear.x = 0.0;
		movement_purp.linear.y = 0.0;
		movement_purp.linear.z = 0.0;		
		movement_purp.angular.x = 0.0;	
		movement_purp.angular.y = 0.0;
		//movement_purp.angular.z = Kp * (errorTheta_purp*5.0/360.0);// + Kd * ((errorTheta_purp*1.5/360.0) - (lastError_purp*1.5/360.0));
		if(errorTheta_purp <=180.0)
		{
		movement_purp.angular.z = 0.6;
		}
		else
		{
			movement_purp.angular.z = -0.6;
		}
		}
		else
		{
		movement_purp.linear.x = 0.0;
		movement_purp.linear.y = 0.0;
		movement_purp.linear.z = 0.0;		
		movement_purp.angular.x = 0.0;	
		movement_purp.angular.y = 0.0;
		movement_purp.angular.z = 0.0;	
		//purpL = 1;		
		}
	
		if(errorTheta_orange > 4.0)// && errorTheta_orange < 350.0)
		{
		//ROS_INFO("IN ROTATE ORANGE");
		movement_orange.linear.x = 0.0;
		movement_orange.linear.y = 0.0;
		movement_orange.linear.z = 0.0;
		movement_orange.angular.x = 0.0;
		movement_orange.angular.y = 0.0;
		//movement_orange.angular.z = Kp * (errorTheta_orange*5.0/360.0);// + Kd * ((errorTheta_orange*1.5/360.0) - (lastError_orange*1.5/360.0));
		if(errorTheta_orange <= 180.0)
		{
		movement_orange.angular.z = 0.6;
		}
		else
		{
		movement_orange.angular.z = -0.6;
		}
		}
		else
		{
		movement_orange.linear.x = 0.0;
		movement_orange.linear.y = 0.0;
		movement_orange.linear.z = 0.0;
		movement_orange.angular.x = 0.0;
		movement_orange.angular.y = 0.0;
		movement_orange.angular.z = 0.0;
		//orangeL = 1;
		}
		move_blue.publish(movement_blue);
		move_purp.publish(movement_purp);
		move_orange.publish(movement_orange);
	}
	else
	{
		//ROS_INFO("IN MOTOR COMMAND");
	// Koboki speed command
		movement_blue.linear.y = 0.0;
		if(speed*((abs(totalForce_cmd[0])*1.2)/400.0) > 1.2)
		{
			movement_blue.linear.x = 1.2;
		}
		else
		{
		movement_blue.linear.x = speed*((fabs(totalForce_cmd[0])*1.2)/400.0);
		}
		movement_blue.linear.z = 0.0;
		movement_blue.angular.x = 0.0;
		movement_blue.angular.y = 0.0;
		movement_blue.angular.z = 0.0;
		
		movement_purp.linear.y = 0.0;
		if(speed*((fabs(totalForce_cmd[2])*1.2)/400.0) > 1.2)
		{
			movement_purp.linear.x = 1.2;
		}
		else
		{
		movement_purp.linear.x = speed*((fabs(totalForce_cmd[2])*1.2)/400.0);
		}
		movement_purp.linear.z = 0.0;
		movement_purp.angular.x = 0.0;
		movement_purp.angular.y = 0.0;
		movement_purp.angular.z = 0.0;
			
		movement_orange.linear.y = 0.0;
		if(speed*((fabs(totalForce_cmd[1])*1.2)/400.0) > 1.2)
		{
			movement_orange.linear.x = 1.2;
		}
		else
		{
		movement_orange.linear.x = speed*((fabs(totalForce_cmd[1])*1.2)/400.0);
		}
		movement_orange.linear.z = 0.0;
		movement_orange.angular.x = 0.0;
		movement_orange.angular.y = 0.0;
		movement_orange.angular.z = 0.0;
		
		//move_blue.publish(movement_blue);
		//move_purp.publish(movement_purp);
		//move_orange.publish(movement_orange);
	}
	//ROS_INFO("F_BLUE = %f , F_ORANGE = %f, F_PURPLE = %f", totalForce_cmd[0], totalForce_cmd[1], totalForce_cmd[2]);

	//ros::Duration(0.2).sleep();
	}
};

int main(int argc, char** argv)
{
	ros::init(argc, argv, "formation_control");
	Move move;
	ros::spin();
	return 0;
}
