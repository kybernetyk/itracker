//
//  Player.m
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize isPlaying;
- (void) tick: (id) sender
{
	tick_count += [sender duration];
	
	if (tick_count >= threshold) {
		tick_count = 0.0;
		g_player_cur_line = cur_line;
		
		//
		// play here
		//
		
		NSLog(@"cur_line: %i", cur_line);
		cur_line ++;
		if (cur_line >= 64)
			cur_line = 0;
		
		
	}
}

- (void) play
{
	NSLog(@"starting play!");
	tick_count = 0.0;
	isPlaying = YES;
	g_player_cur_line = cur_line = 0;
	
	threshold = 60.0 / (CFTimeInterval)g_bpm;
	
	disp_link = [CADisplayLink displayLinkWithTarget: self selector: @selector(tick:)];
	[disp_link setFrameInterval: 1];
	[disp_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	
}

- (void) stop
{
	isPlaying = NO;
	[disp_link invalidate];
	disp_link = nil;
}

@end
