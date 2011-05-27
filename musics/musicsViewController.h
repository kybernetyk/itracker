//
//  musicsViewController.h
//  musics
//
//  Created by jrk on 26/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface musicsViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
	int pattern;
	
	int samples[5];
	CADisplayLink *disp_link;
	
	UIView *arrow;
}

- (IBAction) playpause: (id) sender;

@end
