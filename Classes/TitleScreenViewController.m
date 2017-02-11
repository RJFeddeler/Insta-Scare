    //
//  TitleScreenViewController.m
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TitleScreenViewController.h"

@implementation TitleScreenViewController

@synthesize windowFS, logo;

-(void)viewDidLoad
{
    [super viewDidLoad];
	
	windowFS.hidden = NO;
	[self.view bringSubviewToFront:windowFS];
	
	[UIView animateWithDuration:2.0
						  delay:2.0
						options:0
					 animations:^{
						 logo.alpha = 0.0;
					 }
					 completion:^(BOOL finished){
						 [UIView animateWithDuration:1.0
										  animations:^{
											  windowFS.alpha = 0.0;
										  }
										  completion:^(BOOL finished){
											  windowFS.hidden = YES;
										  }
						  ];
					 }
	 ];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
	[super dealloc];
}

@end
