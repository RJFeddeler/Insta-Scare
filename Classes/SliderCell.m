//
//  SliderCell.m
//  HauntedPhone
//
//  Created by RoB on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SliderCell.h"

@implementation SliderCell

@synthesize lblCaption, slider, lblValue;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
