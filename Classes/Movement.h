//
//  Movement.h
//  HauntedPhone
//
//  Created by RoB on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface Movement : NSObject
{
	CMMotionManager *motionManager;
	NSOperationQueue *motionQueue;
	BOOL active;
	
	double startX;
	double startY;
	double startZ;
	double curX;
	double curY;
	double curZ;
	double maxX;
	double maxY;
	double maxZ;
}

-(id)init;
-(void)startAccelerometer;
-(void)stopAcceleromter;
-(double)howMuch;

@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) NSOperationQueue *motionQueue;

@property BOOL active;
@property double startX;
@property double startY;
@property double startZ;
@property double curX;
@property double curY;
@property double curZ;
@property double maxX;
@property double maxY;
@property double maxZ;

@end
