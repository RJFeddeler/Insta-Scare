//
//  PreviewButtonCell.h
//  HauntedPhone
//
//  Created by RoB on 3/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewButtonCell : UITableViewCell
{
	UILabel *caption;
	UIButton *btnPreview;
}

@property (nonatomic, retain) IBOutlet UILabel *caption;
@property (nonatomic, retain) IBOutlet UIButton *btnPreview;

@end
