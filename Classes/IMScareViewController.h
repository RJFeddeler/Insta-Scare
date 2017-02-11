//
//  IMScareViewController.h
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "Constants.h"

@interface IMScareViewController : UIViewController <UIAlertViewDelegate>
{
	NSInteger scareState;
	BOOL showingSafe;
	BOOL showingScare;
	BOOL showedNotification;
	BOOL scareSet;
	
	NSUserDefaults *defaults;
	NSArray *mySettingsArray;
	UILocalNotification *notifIM;
	NSDate *theDate;
	
	UIWindow *windowFS;
	UIImageView *imgViewBlood;
	UIImageView *imgViewShown;
	UITextView *txtCaption;
	UITextField *txtMessage;
	UILabel *lblSlider;
	UISlider *slider;
	UIButton *btnStartTimer;
}

-(IBAction)hideKeyboard;
-(IBAction)startIMScare;
-(IBAction)windowPressed;
-(IBAction)movedSlider;
-(NSString *)getMsg;
-(void)resetScare;
-(void)setNotification:(float)timeDelay;
-(void)setupForReturnScare;
-(void)setupForReturnSafe;
-(void)setSettingsArray:(NSArray *)array;

@property NSInteger scareState;
@property BOOL showingSafe;
@property BOOL showingScare;
@property BOOL showedNotification;
@property BOOL scareSet;

@property (nonatomic, retain) NSUserDefaults *defaults;
@property (nonatomic, retain) NSArray *mySettingsArray;
@property (nonatomic, retain) UILocalNotification *notifIM;
@property (nonatomic, retain) NSDate *theDate;

@property (nonatomic, retain) IBOutlet UIWindow *windowFS;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewBlood;
@property (nonatomic, retain) IBOutlet UIImageView *imgViewShown;
@property (nonatomic, retain) IBOutlet UITextView *txtCaption;
@property (nonatomic, retain) IBOutlet UITextField *txtMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblSlider;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UIButton *btnStartTimer;

@end
