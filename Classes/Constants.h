//
//  Constants.h
//  HauntedPhone
//
//  Created by RoB on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//-------------------------
//Settings.plist Constants
//-------------------------
//
//Root Constants
#define kMotionTouchSettings 0
#define kMessageAlertSettings 1
#define kFrightNightSettings 2
#define kScareSoundSettings 3
#define kScareImageSettings 4
#define kSafeImageSettings 5

//kMotionTouchSettings Constants
#define kMTS_GForceValue 0

//kMessageAlertSettings Constants
#define kMAS_TimeDelay 0

//kFrightNightSettings Constants
#define kFNS_MinInterval 0
#define kFNS_MaxInterval 1
#define kFNS_TotalDuration 2
#define kFNS_CreepySound00 3
#define kFNS_CreepySound01 4
#define kFNS_CreepySound02 5
#define kFNS_CreepySound03 6
#define kFNS_CreepySound04 7
#define kFNS_CreepySound05 8
#define kFNS_CreepySound06 9
#define kFNS_CreepySound07 10
#define kFNS_CreepySound08 11
#define kFNS_CreepySound09 12
#define kFNS_CreepySound10 13
#define kFNS_CreepySound11 14
#define kFNS_CreepySound12 15

//Picture Scare Constants
#define PIC_Scare_EvilGoblin 0
#define PIC_Scare_Exorcist 1
#define PIC_Scare_BloodyFace 2
#define PIC_Scare_DemonOfTheVoid 3
#define PIC_Scare_JackOLantern 4
#define PIC_Scare_CutUpGirl 5
#define PIC_Scare_HoodedDemon 6
#define PIC_Scare_EvilClown 7
#define PIC_Scare_Skull 8
#define PIC_Scare_FunnyBoy 9

//Sound Scare Constants
#define SND_Scare_ScreamFemale 0
#define SND_Scare_ScreamMale 1
#define SND_Scare_ElectricShock 2

//Sound Creepy Constants
#define SND_Creepy_Alien 0
#define SND_Creepy_CreakingDoor 1
#define SND_Creepy_Footsteps 2
#define SND_Creepy_Ghost 3
#define SND_Creepy_Goblin 4
#define SND_Creepy_GrimReaper 5
#define SND_Creepy_Insectoid 6
#define SND_Creepy_DoorBanging 7
#define SND_Creepy_Leprechaun 8
#define SND_Creepy_Minotaur 9
#define SND_Creepy_Monster 10
#define SND_Creepy_Sasquatch 11
#define SND_Creepy_Wolfman 12

@interface Constants : NSObject
{
}

@end
