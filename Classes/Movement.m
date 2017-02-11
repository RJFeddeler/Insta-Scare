//
//  Movement.m
//  HauntedPhone
//
//  Created by RoB on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Movement.h"

@implementation Movement

@synthesize motionManager, motionQueue;
@synthesize active, startX, startY, startZ, curX, curY, curZ, maxX, maxY, maxZ;

-(id)init
{
	self = [super init];
	
	if (self)
	{
		motionManager = [[CMMotionManager alloc] init];
		motionQueue = [[NSOperationQueue alloc] init];
	}
	
	return self;
}

-(void)stopAcceleromter
{
	[motionManager stopAccelerometerUpdates];
	active = NO;
}

-(void)startAccelerometer
{	
	maxX = 0.0;
	maxY = 0.0;
	maxZ = 0.0;
	
	motionManager.accelerometerUpdateInterval = 1.0 / 50.0;
	
	[motionManager startAccelerometerUpdatesToQueue:motionQueue withHandler:^(CMAccelerometerData* data, NSError* error)
	 {
		 double diffX, diffY, diffZ;
		 
		 if (!active)
		 {
			 active = YES;
			 startX = data.acceleration.x;
			 startY = data.acceleration.y;
			 startZ = data.acceleration.z;
		 }
		 
		 curX = data.acceleration.x;
		 curY = data.acceleration.y;
		 curZ = data.acceleration.z;
		 
		 diffX = (curX - startX);
		 if (diffX < 0)
			 diffX *= -1.0;
		 
		 diffY = (curY - startY);
		 if (diffY < 0)
			 diffY *= -1.0;
		 
		 diffZ = (curZ - startZ);
		 if (diffZ < 0)
			 diffZ *= -1.0;
		 
		 if ((diffX + diffY + diffZ) > (maxX + maxY + maxZ))
		 {
			 maxX = diffX;
			 maxY = diffY;
			 maxZ = diffZ;
		 }
	 }];
}

-(double)howMuch
{
	return maxX + maxY + maxZ;
}

-(void)dealloc
{
	[super dealloc];
	
	[motionManager release];
	[motionQueue release];
}

@end
