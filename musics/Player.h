//
//  Player.h
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface Player : NSObject {
	CADisplayLink *disp_link;
	BOOL isPlaying;
	CFTimeInterval tick_count;
	CFTimeInterval threshold;
	int cur_line;
	
	NSString *instruments[255];
}

@property (readwrite, assign) BOOL isPlaying;

- (void) tick: (id) sender;

- (void) play;
- (void) stop;

@end

extern Player *g_player;