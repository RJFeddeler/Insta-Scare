    //
//  IMScareViewController.m
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IMScareViewController.h"


@implementation IMScareViewController

@synthesize scareState, showingSafe, showingScare, showedNotification, scareSet;
@synthesize defaults, mySettingsArray, notifIM, theDate;
@synthesize windowFS, imgViewBlood, imgViewShown;
@synthesize txtCaption, txtMessage, lblSlider, slider, btnStartTimer;

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	scareState = 0;
	showedNotification = NO;
	scareSet = NO;
	showingSafe = NO;
	showingScare = NO;
	
	windowFS.hidden = YES;
	[self.view bringSubviewToFront:windowFS];
	
	slider.minimumValue = [[[self.mySettingsArray objectAtIndex:kMAS_TimeDelay] objectForKey:@"SliderMin"] floatValue];
	slider.maximumValue = [[[self.mySettingsArray objectAtIndex:kMAS_TimeDelay] objectForKey:@"SliderMax"] floatValue];
	slider.value = [defaults floatForKey:@"MessageDelayKey"];
	
	lblSlider.text = [NSString stringWithFormat:@"%2.2f", (pow(slider.value, 3) + 0.1)];
	if ([lblSlider.text doubleValue] > 90.0)
		lblSlider.text = @"90.0";
	
	txtMessage.text = [defaults stringForKey:@"MessageKey"];
	
	UIImage *buttonImageNormal = [UIImage imageNamed:@"redGlassButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal 
											 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[btnStartTimer setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];

	UIImage *buttonImagePressed = [UIImage imageNamed:@"redGlassButton2.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed 
											  stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[btnStartTimer setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];

	txtCaption.editable = NO;
	txtCaption.font = [UIFont systemFontOfSize:15];
	txtCaption.text = @"Set the time to wait by choosing the value, in minutes, using the slider. Customize the message that will appear and press 'Start Timer'.  The message will pop-up after the specified interval, whether this application is active or not, and the scare occurs when the user goes to view the message.";
}

-(void)viewDidAppear:(BOOL)animated
{
	slider.value = [defaults floatForKey:@"MessageDelayKey"];
	
	lblSlider.text = [NSString stringWithFormat:@"%2.2f", (pow(slider.value, 3) + 0.1)];
	if ([lblSlider.text doubleValue] > 90.0)
		lblSlider.text = @"90.0";
}

-(void)setSettingsArray:(NSArray *)array
{
	self.mySettingsArray = array;
}

-(IBAction)movedSlider
{
	lblSlider.text = [NSString stringWithFormat:@"%2.2f", (pow(slider.value, 3) + 0.1)];
	if ([lblSlider.text doubleValue] > 90.0)
		lblSlider.text = @"90.0";
	
	[defaults setFloat:slider.value forKey:@"MessageDelayKey"];
}

-(IBAction)startIMScare
{
	if (notifIM != nil)
	{
		[[UIApplication sharedApplication] cancelLocalNotification:notifIM];
		notifIM = nil;
	}
	
	scareState = 1;
	[self setNotification:[lblSlider.text doubleValue]];
}

-(void)setNotification:(float)timeDelay
{
	[UIView animateWithDuration:3.0
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
											  showingSafe = YES;
											  showingScare = NO;
											  [imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 0)];
										  }];
					 }];
		
	NSDate *date = [NSDate date];
	date = [date dateByAddingTimeInterval:(NSTimeInterval)(timeDelay * 60.0)];
	
	if (!notifIM)
		notifIM = [[UILocalNotification alloc] init];
	
	notifIM.fireDate = date;
	notifIM.timeZone = [NSTimeZone localTimeZone];
	notifIM.hasAction = YES;
	notifIM.alertAction = @"View";
	notifIM.alertBody = [self getMsg];
	notifIM.soundName = UILocalNotificationDefaultSoundName;
	[[UIApplication sharedApplication] scheduleLocalNotification:notifIM];
	scareState = 2;
}

-(void)resetScare
{
	if (notifIM != nil)
	{
		[[UIApplication sharedApplication] cancelLocalNotification:notifIM];
	}
	
	scareState = 0;
	
	showedNotification = NO;
	scareSet = NO;
	showingScare = NO;
	showingSafe = NO;
	
	windowFS.hidden = YES;
	[imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 0)];
	windowFS.alpha = 1.0;
}

-(void)setupForReturnScare
{
	scareState = 3;
	if (notifIM != nil)
	{
		if ([[notifIM fireDate] timeIntervalSinceNow] < 0)
		{
			windowFS.hidden = NO;
			[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicScare%.2d.png", [defaults integerForKey:@"ScareImageKey"]]]];
			showingScare = YES;
			showingSafe = NO;
			
			Sound *snd;
			snd = [[Sound alloc] init];
			snd.name = [NSString stringWithFormat:@"SndScare%.2d", [defaults integerForKey:@"ScareSoundKey"]];
			
			[snd playSound];
		}
		else
		{
			[self resetScare];
		}

		[[UIApplication sharedApplication] cancelLocalNotification:notifIM];
	}
}

-(void)setupForReturnSafe
{
	[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicSafe%.2d.png", [defaults integerForKey:@"SafeImageKey"]]]];
	windowFS.hidden = NO;
	scareState = 2;
	showingScare = NO;
	showingSafe = YES;
}

-(NSString *)getMsg
{
	return [NSString stringWithFormat:@"%@", txtMessage.text];
}

-(IBAction)windowPressed
{
	if (showingScare)
	{
		[self resetScare];
	}
}

-(IBAction)hideKeyboard
{
	[txtMessage resignFirstResponder];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
    [super dealloc];
	[notifIM release];
}

-(void)alertView:(UIAlertView *)alertView 
		clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.title == @"New Incoming Message")
	{
		[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicScare%.2d.png", [defaults integerForKey:@"ScareImageKey"]]]];
		windowFS.hidden = NO;
		scareState = 3;
		notifIM = nil;
		showingSafe = NO;
		showingScare = YES;
		
		Sound *snd;
		snd = [[Sound alloc] init];
		snd.name = [NSString stringWithFormat:@"SndScare%.2d", [defaults integerForKey:@"ScareSoundKey"]];
		
		[snd playSound];
	}
}

@end
