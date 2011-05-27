//
//  musicsViewController.h
//  musics
//
//  Created by jrk on 26/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface musicsViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
	int track;
	
	int samples[5];
}

- (IBAction) playpause: (id) sender;

@end
