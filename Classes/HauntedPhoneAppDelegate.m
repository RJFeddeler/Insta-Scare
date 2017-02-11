//
//  HauntedPhoneAppDelegate.m
//  HauntedPhone
//
//  Created by RoB on 2/24/11.
//  Copyright www.RedSparrowTech.com, 2011. All rights reserved.
//

#import "HauntedPhoneAppDelegate.h"

@implementation HauntedPhoneAppDelegate

@synthesize titleCtrl, motionTouchScareCtrl, imScareCtrl, frightNightCtrl, settingsCtrl;
@synthesize window, rootController, defaults, settingsArray;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	defaults = [NSUserDefaults standardUserDefaults];
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *settingsPath = [bundle pathForResource:@"Settings" ofType:@"plist"];
	
	NSArray *array = [[NSArray alloc] initWithContentsOfFile:settingsPath];
	self.settingsArray = array;
	[array release];
	
	NSArray *sectionArray;
		
	sectionArray = [self.settingsArray objectAtIndex:kMotionTouchSettings];
	[motionTouchScareCtrl setSettingsArray:sectionArray];
	
	sectionArray = [self.settingsArray objectAtIndex:kMessageAlertSettings];
	[imScareCtrl setSettingsArray:sectionArray];
	
	sectionArray = [self.settingsArray objectAtIndex:kFrightNightSettings];
	[frightNightCtrl setSettingsArray:sectionArray];
	
	sectionArray = self.settingsArray;
	[settingsCtrl setSettingsArray:sectionArray];
	
	if ([defaults valueForKey:@"FirstRun"] == nil)
	{
		[self firstLaunch];
	}
	
	[rootController setDelegate:self];
	[window addSubview:rootController.view];
	[window makeKeyAndVisible];
	
	application.applicationIconBadgeNumber = 0;
	
	return YES;
}

-(void)firstLaunch
{
	NSArray *sectionArray;
	
	[defaults setBool:NO forKey:@"FirstRun"];
	
	//Motion & Touch Settings
	sectionArray = [self.settingsArray objectAtIndex:kMotionTouchSettings];
	[defaults setFloat:[[[sectionArray objectAtIndex:kMTS_GForceValue] objectForKey:@"SliderValue"] 
						floatValue] forKey:@"GForceValueKey"];
	
	//Message Alert Settings
	sectionArray = [self.settingsArray objectAtIndex:kMessageAlertSettings];
	[defaults setFloat:[[[sectionArray objectAtIndex:kMAS_TimeDelay] objectForKey:@"SliderValue"] 
						floatValue] forKey:@"MessageDelayKey"];
	[defaults setObject:[NSString stringWithFormat:@"You have an incoming message."] 
				 forKey:@"MessageKey"];
	
	//Fright Night Settings
	sectionArray = [self.settingsArray objectAtIndex:kFrightNightSettings];
	[defaults setFloat:[[[sectionArray objectAtIndex:kFNS_MinInterval] objectForKey:@"SliderValue"] 
						floatValue] forKey:@"MinIntervalKey"];
	[defaults setFloat:[[[sectionArray objectAtIndex:kFNS_MaxInterval] objectForKey:@"SliderValue"] 
						floatValue] forKey:@"MaxIntervalKey"];
	[defaults setFloat:[[[sectionArray objectAtIndex:kFNS_TotalDuration] objectForKey:@"SliderValue"] 
						floatValue] forKey:@"TotalDurationKey"];
	
	[defaults setBool:YES forKey:@"CreepySound00Key"];
	[defaults setBool:YES forKey:@"CreepySound01Key"];
	[defaults setBool:YES forKey:@"CreepySound02Key"];
	[defaults setBool:YES forKey:@"CreepySound03Key"];
	[defaults setBool:YES forKey:@"CreepySound04Key"];
	[defaults setBool:YES forKey:@"CreepySound05Key"];
	[defaults setBool:YES forKey:@"CreepySound06Key"];
	[defaults setBool:YES forKey:@"CreepySound07Key"];
	[defaults setBool:YES forKey:@"CreepySound08Key"];
	[defaults setBool:YES forKey:@"CreepySound09Key"];
	[defaults setBool:YES forKey:@"CreepySound10Key"];
	[defaults setBool:YES forKey:@"CreepySound11Key"];
	[defaults setBool:YES forKey:@"CreepySound12Key"];
	
	//Scare Sound Settings
	[defaults setInteger:0 forKey:@"ScareSoundKey"];
	
	//Scare Image Settings
	[defaults setInteger:0 forKey:@"ScareImageKey"];
	
	//Safe Image Settings
	[defaults setInteger:0 forKey:@"SafeImageKey"];
}

-(void)soundFinishedPlaying:(Sound *)sound
{
	[sound release];
}

-(void)applicationWillResignActive:(UIApplication *)application
{
	if (imScareCtrl.notifIM)
	{
		if ([[imScareCtrl.notifIM fireDate] timeIntervalSinceNow] > 0)
		{
			imScareCtrl.scareSet = YES;
		}
	}
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
}

-(void)applicationWillEnterForeground:(UIApplication *)application
{
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
	[motionTouchScareCtrl resetScare];
	
	if ([[imScareCtrl.notifIM fireDate] timeIntervalSinceNow] < 0)
		imScareCtrl.showedNotification = YES;
	else
		imScareCtrl.scareState = 0;
	
	if (imScareCtrl.scareState > 1)
		[imScareCtrl setupForReturnScare];
	else
		[imScareCtrl resetScare];
	
	if (frightNightCtrl.scareState > 1)
	{
		[frightNightCtrl setupForReturnScare];
	}
	else
		[frightNightCtrl resetScare];
}

-(void)applicationWillTerminate:(UIApplication *)application
{
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
}

-(void)dealloc
{
	[super dealloc];
}

-(void)application:(UIApplication *)app 
didReceiveLocalNotification:(UILocalNotification *)notif
{
	if (notif.alertAction == nil)
	{
		//Fright Night Local Notification
		Sound *snd = [[Sound alloc] init];
		snd.name = [notif.soundName substringToIndex:([notif.soundName length] - 4)];
		[snd playSound];
	}
	else if (imScareCtrl.scareState == 2)
	{
		//Message Alert Notification while in app
		if (!imScareCtrl.showedNotification && !imScareCtrl.scareSet)
		{
			Sound *snd = [[Sound alloc] init];
			snd.name = @"SndAlert";
			[snd playSound];
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Incoming Message" message:[imScareCtrl getMsg] delegate:imScareCtrl cancelButtonTitle:@"Close" otherButtonTitles:@"View", nil];
			[alert show];
			[alert release];
		}
	}
	
}

@end
