//
//  Player.m
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "SimpleAudioEngine.h"


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
		int istrmnt = 0;
		struct element_t *e = NULL;
		for (int pattern = 0; pattern < 3; pattern ++) {
			for (int track = 0; track < g_patterns[pattern]->num_tracks; track++) {
				e = pattern_elem_at(g_patterns[pattern], track, cur_line);
				istrmnt = g_patterns[pattern]->tracks[track].instrument_id;
				
				if (e->duration) {
					NSString *iname = instruments[istrmnt];
					NSLog(@"playing: %@", iname);
					[[SimpleAudioEngine sharedEngine] playEffect: iname];					
				}
			}
		}

		
		NSLog(@"cur_line: %i", cur_line);
		cur_line ++;
		if (cur_line >= 64)
			cur_line = 0;
		
		
	}
}

- (void) loadInstrument: (NSString *) filename toIndex: (int) idx
{
	if ([filename length] == 0) {
		instruments[idx] = nil;
		return;
	}
	NSLog(@"loading: %@", filename);
	[[SimpleAudioEngine sharedEngine] preloadEffect: filename];
	
	instruments[idx] = [filename retain];
}

- (void) loadInstruments
{
	NSArray *insts = [NSArray arrayWithObjects: 
					  @"",
					  @"bd.wav",
					  @"sd.wav",
					  @"oh.wav",
					  @"hh.wav",
					  @"oh.wav",
					  nil];
	
	int i = 0;
	for (NSString *is in insts) {
		[self loadInstrument: is toIndex: i];
		i++;
	}
}
- (id) init 
{
	self = [super init];
	[self loadInstruments];
	return self;
}
- (void) play
{
	NSLog(@"starting play!");
	tick_count = 0.0;
	isPlaying = YES;
	g_player_cur_line = cur_line = 0;
	
	threshold = 60.0 / (CFTimeInterval)g_bpm / 4.0;
	
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


Player *g_player = nil;