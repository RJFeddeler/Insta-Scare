//
//  FrightNightViewController.h
//  HauntedPhone
//
//  Created by RoB on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "Constants.h"

@interface FrightNightViewController : UIViewController
{
	NSUserDefaults *defaults;
	
	NSInteger scareState;
	BOOL showingSafe;
	BOOL showingScare;
	
	NSArray *mySettingsArray;
	
	NSDate *now;
	NSInteger curTimeFromNow;
	
	UIImageView *imgViewBlood;
	UIImageView *imgViewShown;
	UIWindow *windowFS;
	UIView *view1;
	
	UITextView *txtCaption;
	UIButton *btnClear;
	UIButton *btnStart;
	UISlider *sliderMin;
	UISlider *sliderMax;
	UISlider *sliderDuration;
	UILabel *lblMin;
	UILabel *lblMax;
	UILabel *lblDuration;
}

-(IBAction)clearNotificationList;
-(IBAction)startFrightNight;
-(IBAction)sliderMinChanged;
-(IBAction)sliderMaxChanged;
-(IBAction)sliderDurationChanged;
-(IBAction)scarePressed;
-(void)setSettingsArray:(NSArray *)array;
-(void)setupForReturnSafe;
-(void)setupForReturnScare;
-(void)resetScare;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property NSInteger scareState;
@property BOOL showingSafe;
@property BOOL showingScare;

@property (nonatomic, retain) NSArray *mySettingsArray;

@property (nonatomic, retain) NSDate *now;
@property NSInteger curTimeFromNow;

@property (nonatomic, retain) IBOutlet UIImageView *imgViewBlood;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewShown;
@property (nonatomic, retain) IBOutlet UIWindow *windowFS;
@property (nonatomic, retain) IBOutlet UIView *view1;

@property (nonatomic, retain) IBOutlet UITextView *txtCaption;
@property (nonatomic, retain) IBOutlet UIButton *btnClear;
@property (nonatomic, retain) IBOutlet UIButton *btnStart;
@property (nonatomic, retain) IBOutlet UISlider *sliderMin;
@property (nonatomic, retain) IBOutlet UISlider *sliderMax;
@property (nonatomic, retain) IBOutlet UISlider *sliderDuration;
@property (nonatomic, retain) IBOutlet UILabel *lblMin;
@property (nonatomic, retain) IBOutlet UILabel *lblMax;
@property (nonatomic, retain) IBOutlet UILabel *lblDuration;
@end
