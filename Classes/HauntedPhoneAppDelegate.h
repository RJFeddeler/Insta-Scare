//
//  HauntedPhoneAppDelegate.h
//  HauntedPhone
//
//  Created by RoB on 2/24/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Sound.h"
#import "TitleScreenViewController.h"
#import "MotionTouchScareViewController.h"
#import "IMScareViewController.h"
#import "FrightNightViewController.h"
#import "SettingsViewController.h"
#import "Constants.h"

@interface HauntedPhoneAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
	TitleScreenViewController *titleCtrl;
	MotionTouchScareViewController *motionTouchScareCtrl;
	IMScareViewController *imScareCtrl;
	FrightNightViewController *frightNightCtrl;
	SettingsViewController *settingsCtrl;
	
	UIWindow *window;
	UITabBarController *rootController;
	
	NSUserDefaults *defaults;
	NSArray *settingsArray;
}

-(void)firstLaunch;

@property (nonatomic, retain) IBOutlet TitleScreenViewController *titleCtrl;
@property (nonatomic, retain) IBOutlet MotionTouchScareViewController *motionTouchScareCtrl;
@property (nonatomic, retain) IBOutlet IMScareViewController *imScareCtrl;
@property (nonatomic, retain) IBOutlet FrightNightViewController *frightNightCtrl;
@property (nonatomic, retain) IBOutlet SettingsViewController *settingsCtrl;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@property (nonatomic, retain) NSUserDefaults *defaults;
@property (nonatomic, retain) NSArray *settingsArray;

@end

