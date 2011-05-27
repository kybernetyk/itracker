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
	scrollView.contentSize = CGSizeMake(self.view.frame.size.width, UI_ROWS * (BUTTON_HEIGHT + Y_PADDING));
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.75;
	scrollView.clipsToBounds = YES;

	int dasher = (g_pattern_mode == e_mode_eights) ? 2 : 1;
	int marker = (g_pattern_mode == e_mode_eights) ? 8 : 4;	

	for (int y = 0; y < UI_ROWS; y++) {
		for (int x = 0; x < UI_COLS; x++) {
			[self createButtonX: X_OFFSET+ x*(BUTTON_WIDTH+X_PADDING) y: y*(BUTTON_HEIGHT+Y_PADDING) tag: x + y * UI_COLS];				
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
	int row = [sender tag] / UI_COLS;
	int col = [sender tag] % UI_COLS;
	
	NSLog(@"col: %i, row: %i", col, row);
	
	struct pattern_element_t *p = ptrnbuf_elem_at(g_tracks[track], col, row, g_pattern_mode);
	
	p->sample_id = ( (b) ? samples[col] : 0);

	
	NSLog(@"sample: %i", p->sample_id);	

}

@end
