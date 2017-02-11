//
//  Sound.m
//  HauntedPhone
//
//  Created by RoB on 2/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Sound.h"

@implementation Sound

@synthesize audioPlayer, sndError, url, name;

-(void)playSound
{
	url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"wav"]];
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&sndError];
	audioPlayer.delegate = self;
	
	[audioPlayer play];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	[self dealloc];
}

-(void)dealloc
{
	[super dealloc];
	[audioPlayer release];
}

@end
