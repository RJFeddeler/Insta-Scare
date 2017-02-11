//
//  SettingsViewController.h
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "Constants.h"
#import "SwitchCell.h"
#import "PreviewButtonCell.h"
#import "SliderCell.h"

@interface SettingsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
	NSUserDefaults *defaults;
	
	NSArray *mySettingsArray;
	NSDictionary *currentDict;
	
	UITableView *myTableView;
	NSDictionary *pressedCellDict;
	NSString *curCellType;
	
	UIWindow *window;
	UIImageView *imgPreview;
	UIButton *btnClosePreview;
	UIButton *btnDetailDisclosure;
}

-(void)setSettingsArray:(NSArray *)array;
-(void)previewSound:(NSString *)sound;
-(void)pressedDetailPicture:(id)sender;
-(void)pressedDetailSafePicture:(id)sender;
-(void)pressedDetailScareSound:(id)sender;
-(void)changedCreepySoundSwitch:(id)sender;
-(void)changedMotionTouchSlider:(id)sender;
-(void)changedMessageAlertSlider:(id)sender;
-(void)changedFrightNightSlider:(id)sender;
-(IBAction)closePicturePreview;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, retain) NSArray *mySettingsArray;
@property (nonatomic, retain) NSDictionary *currentDict;

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSDictionary *pressedCellDict;
@property (nonatomic, retain) NSString *curCellType;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIImageView *imgPreview;
@property (nonatomic, retain) IBOutlet UIButton *btnClosePreview;
@property (nonatomic, retain) UIButton *btnDetailDisclosure;

@end
