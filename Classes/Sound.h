//
//  Sound.h
//  HauntedPhone
//
//  Created by RoB on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Sound : NSObject <AVAudioPlayerDelegate>
{
	AVAudioPlayer *audioPlayer;
	NSError *sndError;
	NSURL *url;
	NSString *name;
}

-(void)playSound;

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) NSError *sndError;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *name;

@end
