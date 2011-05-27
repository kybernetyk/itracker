//
//  musicsViewController.m
//  musics
//
//  Created by jrk on 26/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicsViewController.h"
#import "musicbuffer.h"

@implementation musicsViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
//	memset(samples, 0x00, COLS * sizeof(int));
	for (int i = 0; i < 5; i++)
		samples[i] = i+1;
    [super viewDidLoad];
	[self createButtons];
	
	arrow = [[UIView alloc] initWithFrame: CGRectMake(30, 0, 20, 10)];
	[arrow setBackgroundColor: [UIColor blueColor]];
	[scrollView addSubview: arrow];
	
	disp_link = [CADisplayLink displayLinkWithTarget: self selector: @selector(tick:)];
	[disp_link setFrameInterval: 1];
	[disp_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void) tick: (id) sender
{
	CGRect f = [arrow frame];
	f.origin.y = g_player_cur_line * (BUTTON_HEIGHT+Y_PADDING)+5;
	[arrow setFrame: f];
	
	CGPoint p = [scrollView contentOffset];
	if (fabs(f.origin.y - p.y) >= 280)
		[scrollView setContentOffset:CGPointMake(0, f.origin.y-20) animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - ui events
- (void) playpause: (id) sender
{
	[[[UIApplication sharedApplication] delegate] playpause];
}

#pragma mark - button creation
- (void) createButtonX: (int) x y: (int) y tag: (int) tag
{
	UIButton *b = [UIButton buttonWithType: UIButtonTypeCustom];
	CGRect f = CGRectMake(x, y, BUTTON_WIDTH, BUTTON_HEIGHT);
	[b setFrame: f];
	
//	[b setTitle: @"Tap" forState: UIControlStateNormal];
	[b setTag: tag];
	[b addTarget: self action: @selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[b setImage: [UIImage imageNamed: @"on.png"] forState: UIControlStateSelected];
	[b setImage: [UIImage imageNamed: @"off.png"] forState: UIControlStateNormal];
	[b.imageView setContentMode: UIViewContentModeScaleToFill];
	[scrollView addSubview: b];
}

- (void) createMarkerAtRow: (int) row
{
	UIView *v = [[UIView  alloc] initWithFrame: CGRectMake(0, row * (BUTTON_HEIGHT + Y_PADDING)-Y_PADDING/2-2, 320, 5)];
	[v setBackgroundColor: [UIColor greenColor]];
	[v autorelease];
	[scrollView addSubview: v];
}

- (void) createDasheAtRow: (int) row
{
	UIView *v = [[UIView  alloc] initWithFrame: CGRectMake(0, row * (BUTTON_HEIGHT + Y_PADDING)-Y_PADDING/2, 320, 1)];
	[v setBackgroundColor: [UIColor darkGrayColor]];
	[v autorelease];
	[scrollView addSubview: v];
}

- (void) createButtons 
{
	scrollView.contentSize = CGSizeMake(self.view.frame.size.width, g_ui_lines * (BUTTON_HEIGHT + Y_PADDING));
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.75;
	scrollView.clipsToBounds = YES;

	int dasher = g_ui_lines_per_beat;
	int marker = g_ui_lines_per_beat * 4;

	for (int y = 0; y < g_ui_lines; y++) {
		for (int x = 0; x < g_ui_tracks; x++) {
			[self createButtonX: X_OFFSET+ x*(BUTTON_WIDTH+X_PADDING) y: y*(BUTTON_HEIGHT+Y_PADDING) tag: x + y * g_ui_tracks];				
		}
		if (y % dasher == 0) {
			[self createDasheAtRow: y];
		}
		if (y % marker == 0) {
			[self createMarkerAtRow: y];
		}
		
	}
}

#pragma mark - button handler
- (void) buttonPressed: (id) sender
{
	NSLog(@"press on %i", [sender tag]);
	//[sender setOn: ![sender isOn]];
	//[sender setImage:[UIImage imageNamed: [sender isOn] ? @"on.png" :@"off.png"] forState:UIControlStateNormal];
	[sender setSelected: ![sender isSelected]];
	
	BOOL b = [sender isSelected];
	int line = [sender tag] / g_ui_tracks;
	int track = [sender tag] % g_ui_tracks;
	struct pattern_t *p = g_patterns[pattern];
	
	int lfakt = p->num_lpb / g_ui_lines_per_beat;
		
	NSLog(@"track: %i, line: %i", track, line);
	
	line *= lfakt;
//	extern struct pattern_element_t *ptrnbuf_elem_at(struct pattern_buffer_t *pbuf, int track, int line);
	struct element_t *e = pattern_elem_at(p, track, line);
	
	e->duration = ((b) ? 1 : 0);

	
	NSLog(@"sample: %i, dur: %i", p->tracks[track].instrument_id, e->duration);	

}

@end
