    //
//  MotionTouchScareViewController.m
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MotionTouchScareViewController.h"

@implementation MotionTouchScareViewController

@synthesize scareState, showingSafe, showingScare, scareOnSafeTouch;
@synthesize defaults, mySettingsArray, timer;
@synthesize windowFS, view1, view2, imgSafe, imgScare, imgViewBlood, imgViewShown;
@synthesize btnStartTimer, txtCaption, slider, lblSlider, lblCount;

-(void)viewDidLoad
{
    [super viewDidLoad];
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	moved = [[Movement alloc] init];
	moved.active = NO;
		
	scareState = 0;
	showingSafe = NO;
	showingScare = NO;
	scareOnSafeTouch = NO;
	
	view1.hidden = NO;
	view2.hidden = YES;
	windowFS.hidden = YES;
	[self.view bringSubviewToFront:windowFS];
	
	slider.minimumValue = [[[self.mySettingsArray objectAtIndex:kMTS_GForceValue] objectForKey:@"SliderMin"] floatValue];
	slider.maximumValue = [[[self.mySettingsArray objectAtIndex:kMTS_GForceValue] objectForKey:@"SliderMax"] floatValue];
	slider.value = [defaults floatForKey:@"GForceValueKey"];
	
	if (slider.value == slider.maximumValue)
		lblSlider.text = @"10.00";
	else
		lblSlider.text = [NSString stringWithFormat:@"%2.2f", (pow(slider.value, 3) + 0.1)];
	
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
	txtCaption.text = @"Set the sensitivity required to set off the scare below. The lower the number, the more sensitive it is. The most common values are between 0.4 and 0.8. Press 'Start Timer' and you will have 5 seconds to place the iDevice down where you want it.\n\nSet the value to 10.00 if you want the scare to be touch activated rather than motion activated.";
}

-(void)viewDidAppear:(BOOL)animated
{
	if (scareState != 0)
	{
		[self resetScare];
	}
	
	slider.value = [defaults floatForKey:@"GForceValueKey"];
	
	if (slider.value == slider.maximumValue)
		lblSlider.text = @"10.00";
	else
		lblSlider.text = [NSString stringWithFormat:@"%2.2f", (pow(slider.value, 3) + 0.1)];
	
	if (moved.active)
	{
		[moved stopAcceleromter];
		
		if ([timer isValid])
		{
			[timer invalidate];
			timer = nil;
		}
	}
}

-(void) resetScare
{
	scareState = 0;
	
	if ([timer isValid])
		[timer invalidate];
	
	timer = nil;
	
	if (moved.active == YES)
	{
		[moved stopAcceleromter];
	}
	
	showingSafe = NO;
	showingScare = NO;
	
	view2.hidden = YES;
	view1.alpha = 0.0;
	view1.hidden = NO;
	windowFS.hidden = YES;
	
	[imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 0)];
	
	[UIView animateWithDuration:1.0
					 animations:^{
						 view1.alpha = 1.0;
					 }];
}

-(void)setSettingsArray:(NSArray *)array
{
	self.mySettingsArray = array;
}

-(IBAction)movedSlider
{
	lblSlider.text = [NSString stringWithFormat:@"%2.2f", (pow(slider.value, 3) + 0.1)];
	if (slider.value == slider.maximumValue)
		lblSlider.text = @"10.00";
	
	[defaults setFloat:slider.value forKey:@"GForceValueKey"];
}

-(IBAction)startMotionTouchScare
{
	scareState = 1;
	
	if (lblSlider.text == @"10.00")
		scareOnSafeTouch = YES;
	else
		scareOnSafeTouch = NO;

	if (scareOnSafeTouch)
	{
		[UIView animateWithDuration:2.0
						 animations:^{
							 [imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 411)];
						 }
						 completion:^(BOOL finished){
							 [self doAfterCountdown];
						 }];
	}
	else
	{
		[UIView animateWithDuration:1.0
						 animations:^{
							 view1.alpha = 0.0;
						 }
						 completion:^(BOOL finished){
							 [self countDownNow:view2 :view1];
						 }];
	}
}

-(IBAction)scarePressed
{
	if (showingScare)
	{
		[self resetScare];
	}
	else
	{
		if (scareOnSafeTouch)
		{
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
}

-(void)checkForMovement:(NSTimer *)theTimer
{
	double curValue;	

	curValue = [lblSlider.text doubleValue];
	
	if (scareState == 0)
	{
		[self resetScare];
	}
	
	if ([moved howMuch] >= curValue)
	{
		if (showingSafe)
		{
			showingSafe = NO;
			showingScare = YES;
			[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicScare%.2d.png", [defaults integerForKey:@"ScareImageKey"]]]];
			
			Sound *snd;
			snd = [[Sound alloc] init];
			snd.name = [NSString stringWithFormat:@"SndScare%.2d", [defaults integerForKey:@"ScareSoundKey"]];
			
			[snd playSound];
		}
	}
}

-(void)countDownNow:(UIView *)viewA :(UIView *)viewB
{
	viewA.hidden = NO;
	viewB.hidden = YES;
	
	lblCount.text = @"5";
	lblCount.alpha = 0.0;
	
	if (scareState == 1)
        // NOW THAT THE COUNTDOWN IS WORKING, SWITCH TO A LOOP TO GET RID OF THIS MESS!!!
		[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 1.0; } completion:^(BOOL finished){
			[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 0.0; } completion:^(BOOL finished){
				lblCount.text = @"4";
				if (scareState == 1)
					[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 1.0; } completion:^(BOOL finished){
						[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 0.0; } completion:^(BOOL finished){
							lblCount.text = @"3";
							if (scareState == 1)
								[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 1.0; } completion:^(BOOL finished){
									[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 0.0; } completion:^(BOOL finished){
										lblCount.text = @"2";
										if (scareState == 1)
											[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 1.0; } completion:^(BOOL finished){
												[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 0.0; } completion:^(BOOL finished){
													lblCount.text = @"1";
													if (scareState == 1)
														[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 1.0; } completion:^(BOOL finished){
															[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 0.0; } completion:^(BOOL finished){
																lblCount.text = @"0";
																if (scareState == 1)
																	[UIView animateWithDuration:0.5 animations:^{ lblCount.alpha = 1.0; } completion:^(BOOL finished){
																		[UIView animateWithDuration:1.0 animations:^{ lblCount.alpha = 0.0; } completion:^(BOOL finished){
																			if (scareState == 1)
																				[self doAfterCountdown];
																			else
																				[self resetScare];
																		}];
																	}];
																else
																	[self resetScare];
															}];
														}];
													else
														[self resetScare];
												}];
											}];
										else
											[self resetScare];
									}];
								}];
							else
								[self resetScare];
						}];
					}];
				else
					[self resetScare];
			}];
		}];
	else
		[self resetScare];
}

-(void)doAfterCountdown
{
	scareState = 2;
	[imgViewShown setImage:[UIImage imageNamed:[NSString stringWithFormat:@"PicSafe%.2d.png", [defaults integerForKey:@"SafeImageKey"]]]];
	windowFS.alpha = 0.0;
	windowFS.hidden = NO;
	
	[UIView animateWithDuration:1.0
					 animations:^{
						 windowFS.alpha = 1.0;
					 }
					 completion:^(BOOL finished){
						 [imgViewBlood setFrame:CGRectMake(imgViewBlood.frame.origin.x, imgViewBlood.frame.origin.y, 320, 0)];
					 }];
	
	showingScare = NO;
	showingSafe = YES;
	
	[moved startAccelerometer];
	timer = [NSTimer scheduledTimerWithTimeInterval:0.05
											 target:self
										   selector:@selector(checkForMovement:)
										   userInfo:nil
											repeats:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated
{
}

-(void)viewDidUnload
{
    [super viewDidUnload];	
}

-(void)dealloc
{
	[moved release];
	[super dealloc];
}

@end
