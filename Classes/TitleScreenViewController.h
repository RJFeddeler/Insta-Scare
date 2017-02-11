//
//  TitleScreenViewController.h
//  HauntedPhone
//
//  Created by RoB on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleScreenViewController : UIViewController
{
	UIWindow *windowFS;
	UIImageView *logo;
}

@property (nonatomic, retain) IBOutlet UIWindow *windowFS;
@property (nonatomic, retain) IBOutlet UIImageView *logo;

@end
