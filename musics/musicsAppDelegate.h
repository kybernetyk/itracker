//
//  musicsAppDelegate.h
//  musics
//
//  Created by jrk on 26/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
@class musicsViewController;

@interface musicsAppDelegate : NSObject <UIApplicationDelegate> {
	Player *player;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet musicsViewController *viewController;

@end
