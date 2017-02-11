    //
//  FrightNightViewController.m
//  HauntedPhone
//
//  Created by RoB on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FrightNightViewController.h"

@implementation FrightNightViewController

@synthesize defaults, scareState, showingSafe, showingScare, mySettingsArray, now;
@synthesize curTimeFromNow, sliderMin, sliderMax, sliderDuration, lblMin, lblMax, lblDuration;
@synthesize txtCaption, btnClear, btnStart, imgViewBlood, imgViewShown, windowFS, view1;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	scareState = 0;
	showingSafe = NO;
	showingScare = NO;
	
	windowFS.hidden = YES;
	[self.view bringSubviewToFront:windowFS];
	
	//Create Button
	UIImage *buttonImageNormal = [UIImage imageNamed:@"redGlassButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];	
	[btnClear setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	[btnStart setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	
	UIImage *buttonImagePressed = [UIImage imageNamed:@"redGlassButton2.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[btnClear setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
	[btnStart setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];											 
	
	sliderMin.minimumValue = [[[self.mySettingsArray objectAtIndex:kFNS_MinInterval] objectForKey:@"SliderMin"] floatValue];
	sliderMin.maximumValue = [[[self.mySettingsArray objectAtIndex:kFNS_MinInterval] objectForKey:@"SliderMax"] floatValue];
	sliderMin.value = [defaults floatForKey:@"MinIntervalKey"];
	lblMin.text = [NSString stringWithFormat:@"%.2f", sliderMin.value];
	
	sliderMax.minimumValue = [[[self.mySettingsArray objectAtIndex:kFNS_MaxInterval] objectForKey:@"SliderMin"] floatValue];
	sliderMax.maximumValue = [[[self.mySettingsArray objectAtIndex:kFNS_MaxInterval] objectForKey:@"SliderMax"] floatValue];
	sliderMax.value = [defaults floatForKey:@"MaxIntervalKey"];
	lblMax.text = [NSString stringWithFormat:@"%.2f", sliderMax.value];
	
	sliderDuration.minimumValue = [[[self.mySettingsArray objectAtIndex:kFNS_TotalDuration] objectForKey:@"SliderMin"] floatValue];
	sliderDuration.maximumValue = [[[self.mySettingsArray objectAtIndex:kFNS_TotalDuration] objectForKey:@"SliderMax"] floatValue];
	sliderDuration.value = [defaults floatForKey:@"TotalDurationKey"];
	lblDuration.text = [NSString stringWithFormat:@"%2.2f", sliderDuration.value];
	
	txtCaption.editable = NO;
	txtCaption.font = [UIFont systemFontOfSize:14];
	txtCaption.text = @"A random creepy sound will play at a random time between the minimum interval and maximum interval. You can choose the creepy sounds in settings. The sounds will continue for the time period set by total duration. You can minimize this app and the sounds will still continue to play! Hide the iDevice somewhere by the victim to scare them throughout the night. If the victim finds the iDevice and clicks the screen they will get a bonus scare.";	
}

-(void)viewDidAppear:(BOOL)animated
{
	sliderMin.value = [defaults floatForKey:@"MinIntervalKey"];
	lblMin.text = [NSString stringWithFormat:@"%.2f", sliderMin.value];
	
	sliderMax.value = [defaults floatForKey:@"MaxIntervalKey"];
	lblMax.text = [NSString stringWithFormat:@"%.2f", sliderMax.value];
	
	sliderDuration.value = [defaults floatForKey:@"TotalDurationKey"];
	lblDuration.text = [NSString stringWithFormat:@"%2.2f", sliderDuration.value];
}

-(void)setSettingsArray:(NSArray *)array
{
	self.mySettingsArray = array;
}

-(IBAction)clearNotificationList
{
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

-(IBAction)startFrightNight
{
	scareState = 1;
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	curTimeFromNow = 0;
	
	NSMutableArray *soundList = [[NSMutableArray alloc] init];
	
	[soundList removeAllObjects];
	for (int x=0; x < 13; x++)
	{
		if ([defaults boolForKey:[NSString stringWithFormat:@"CreepySound%.2dKey", x]])
		{
			[soundList addObject:[NSString stringWithFormat:@"SndCreepy%.2d.wav", x]];		}
	}
	
	if ([soundList count] > 0)
	{
		int range;
		int min;
		NSInteger rndSound;
		NSInteger rndNum;
	
		while (curTimeFromNow <= ([defaults floatForKey:@"TotalDurationKey"] * 60 * 60))
		{
			range = (([defaults integerForKey:@"MaxIntervalKey"] - [defaults integerForKey:@"MinIntervalKey"]) * 60.0);
			min = ([defaults integerForKey:@"MinIntervalKey"] * 60.0);
			rndNum = (arc4random() % range) + min;
		
			rndSound = (arc4random() % [soundList count]);
		
			curTimeFromNow += rndNum;
		
			NSDate *dateNotif = [NSDate dateWithTimeIntervalSinceNow:curTimeFromNow];
		
			UILocalNotification *localNotif = [[UILocalNotification alloc] init];
			localNotif.fireDate = dateNotif;
			localNotif.timeZone = [NSTimeZone localTimeZone];
			localNotif.soundName = [soundList objectAtIndex:rndSound];
			[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
			[localNotif release];
		}
		
		[UIView animateWithDuration:2.0
						 animations:^{
							 [imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 411)];
						 }
						 completion:^(BOOL finished){
							 [imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicSafe%.2d.png", [defaults integerForKey:@"SafeImageKey"]]]];
							 windowFS.alpha = 0.0;
							 windowFS.hidden = NO;
							 
							 [UIView animateWithDuration:1.0
											  animations:^{
												  windowFS.alpha = 1.0;
											  }
											  completion:^(BOOL finished){
												  [imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 0)];
												  showingSafe = YES;
												  showingScare = NO;
												  scareState = 2;
											  }];
						 }];
	}
	
	[soundList release];
}

-(IBAction)scarePressed
{
	if (showingScare)
	{
		[UIView animateWithDuration:1.0
						 animations:^{
							 view1.alpha = 1.0;
						 }
						 completion:^(BOOL finished){
							 [self resetScare];
						 }];
	}
	else
	{
		[[UIApplication sharedApplication] cancelAllLocalNotifications];
		
		scareState = 3;
		showingSafe = NO;
		showingScare = YES;
		[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicScare%.2d.png", [defaults integerForKey:@"ScareImageKey"]]]];
			
			
		Sound *snd;
		snd = [[Sound alloc] init];
		snd.name = [NSString stringWithFormat:@"SndScare%.2d", [defaults integerForKey:@"ScareSoundKey"]];
		
		[snd playSound];
	}	
}

-(void)setupForReturnScare
{
	windowFS.hidden = NO;
	[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicScare%.2d.png", [defaults integerForKey:@"ScareImageKey"]]]];
	scareState = 3;
	showingScare = YES;
	showingSafe = NO;
	
	Sound *snd;
	snd = [[Sound alloc] init];
	snd.name = [NSString stringWithFormat:@"SndScare%.2d", [defaults integerForKey:@"ScareSoundKey"]];
	
	[snd playSound];
}

-(void)setupForReturnSafe
{
	windowFS.hidden = NO;
	[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicSafe%.2d.png", [defaults integerForKey:@"SafeImageKey"]]]];
	scareState = 2;
	showingScare = NO;
	showingSafe = YES;
}

-(void)resetScare
{
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	scareState = 0;
	
	showingScare = NO;
	showingSafe = NO;
	
	windowFS.hidden = YES;
	[imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 0)];
	windowFS.alpha = 1.0;
}

-(IBAction)sliderMinChanged
{
	if (sliderMin.value > sliderMax.value)
	{
		sliderMax.value = sliderMin.value;
		lblMax.text = [NSString stringWithFormat:@"%.2f", sliderMax.value];
		[defaults setFloat:sliderMax.value forKey:@"MaxIntervalKey"];
	}
					   
	lblMin.text = [NSString stringWithFormat:@"%.2f", sliderMin.value];	
	[defaults setFloat:sliderMin.value forKey:@"MinIntervalKey"];
}

-(IBAction)sliderMaxChanged
{
	if (sliderMin.value > sliderMax.value)
	{
		sliderMin.value = sliderMax.value;
		lblMin.text = [NSString stringWithFormat:@"%.2f", sliderMin.value];
		[defaults setFloat:sliderMin.value forKey:@"MinIntervalKey"];
	}
	
	lblMax.text = [NSString stringWithFormat:@"%.2f", sliderMax.value];
	[defaults setFloat:sliderMax.value forKey:@"MaxIntervalKey"];
}

-(IBAction)sliderDurationChanged
{
	lblDuration.text = [NSString stringWithFormat:@"%.2f", sliderDuration.value];
	
	[defaults setFloat:sliderDuration.value forKey:@"TotalDurationKey"];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


-(void)dealloc
{
    [super dealloc];
}

-(void)soundFinishedPlaying:(Sound *)sound
{
	[sound release];
}

@end
