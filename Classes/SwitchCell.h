//
//  SwitchCell.h
//  HauntedPhone
//
//  Created by RoB on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
{
	UISwitch *mySwitch;
	UILabel *caption;
}

@property (nonatomic, retain) IBOutlet UISwitch *mySwitch;
@property (nonatomic, retain) IBOutlet UILabel *caption;

@end
