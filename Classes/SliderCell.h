//
//  SliderCell.h
//  HauntedPhone
//
//  Created by RoB on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCell : UITableViewCell
{
	UILabel *lblCaption;
	UISlider *slider;
	UILabel *lblValue;
}

@property (nonatomic, retain) IBOutlet UILabel *lblCaption;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UILabel *lblValue;

@end
