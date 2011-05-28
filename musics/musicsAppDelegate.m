//
//  musicsAppDelegate.m
//  musics
//
//  Created by jrk on 26/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicsAppDelegate.h"
#import "musicsViewController.h"

#import "musicbuffer.h"
#import "CocosDenshion.h"
#import "CDAudioManager.h"
#import "SimpleAudioEngine.h"

@implementation musicsAppDelegate

@synthesize window=_window;

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[SimpleAudioEngine sharedEngine];
	
	// Override point for customization after application launch.
	NSLog(@"creating buffers ...");
	
	
	g_ui_lines_per_beat = 4;
	g_ui_lines = g_ui_lines_per_beat * 16;	
	g_ui_tracks = 5;
	g_bpm = 90;
	
	g_patterns = malloc(3 * sizeof(struct pattern_t*));
	for (int i = 0; i < 3; i ++) {
		g_patterns[i] = pattern_new(4, g_ui_tracks, 64);
	}
	
	g_patterns[0]->tracks[0].instrument_id = 1;
	g_patterns[0]->tracks[1].instrument_id = 2;
	g_patterns[0]->tracks[2].instrument_id = 3;
	g_patterns[0]->tracks[3].instrument_id = 4;
	g_patterns[0]->tracks[4].instrument_id = 5;
	
	player = [[Player alloc] init];
	g_player = player;
	
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
	

    return YES;
}

- (void) playpause
{
	if ([player isPlaying])
		[player stop];
	else
		[player play];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

- (void)dealloc
{
	[_window release];
	[_viewController release];
    [super dealloc];
}

@end
