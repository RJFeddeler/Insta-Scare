//
//  MotionTouchScareViewController.h
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "Movement.h"
#import "Constants.h"

@interface MotionTouchScareViewController : UIViewController <UIAlertViewDelegate>
{
	Movement *moved;
	
	NSInteger scareState;
	BOOL showingSafe;
	BOOL showingScare;
	BOOL scareOnSafeTouch;
	
	NSUserDefaults *defaults;
	NSArray *mySettingsArray;
	NSTimer *timer;
	
	UIWindow *windowFS;
	UIView *view1;
	UIView *view2;
	
	UIImage *imgSafe;
	UIImage *imgScare;
	UIImageView *imgViewBlood;
	UIImageView *imgViewShown;
	UIButton *btnStartTimer;
	UITextView *txtCaption;
	UISlider *slider;
	UILabel *lblSlider;
	UILabel *lblCount;
}

-(IBAction)startMotionTouchScare;
-(IBAction)scarePressed;
-(IBAction)movedSlider;
-(void)checkForMovement:(NSTimer *)timer;
-(void)countDownNow: (UIView *)viewA :(UIView *)viewB;
-(void)doAfterCountdown;
-(void)setSettingsArray:(NSArray *)array;
-(void)resetScare;

@property NSInteger scareState;
@property BOOL showingSafe;
@property BOOL showingScare;
@property BOOL scareOnSafeTouch;

@property (nonatomic, retain) NSUserDefaults *defaults;
@property (nonatomic, retain) NSArray *mySettingsArray;
@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) IBOutlet UIWindow *windowFS;
@property (nonatomic, retain) IBOutlet UIView *view1;
@property (nonatomic, retain) IBOutlet UIView *view2;

@property (nonatomic, retain) UIImage *imgSafe;
@property (nonatomic, retain) UIImage *imgScare;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewBlood;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewShown;
@property (nonatomic, retain) IBOutlet UIButton *btnStartTimer;
@property (nonatomic, retain) IBOutlet UITextView *txtCaption;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *lblSlider;
@property (nonatomic, retain) IBOutlet UILabel *lblCount;

@end