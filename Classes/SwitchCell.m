//
//  SwitchCell.m
//  HauntedPhone
//
//  Created by RoB on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

@synthesize mySwitch, caption;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)dealloc
{
    [super dealloc];
}


@end
