//
//  ptrnbuf_
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#pragma once

struct element_t {
	int duration;		//actually duration is only a boolean value if play or not
	int effect;			//effects ... hum - will probably never use that :]
	//other shit
};

struct track_t {
	struct element_t *elements;
	int instrument_id;
};

struct pattern_t {
	struct track_t *tracks;

	int num_lpb; //lines per beat
	int num_tracks;
	int num_lines;
};


extern struct pattern_t *pattern_new(int lines_per_beat, int tracks, int lines);
extern void pattern_free(struct pattern_t *p);

//access mode is the mode the UI is in. if the UI shows fourths and wants to access row 1
//and our pattern buffer holds eights we will actually return row 2 (which is the start of the 2nd fourth note)
extern struct element_t *pattern_elem_at(struct pattern_t *p, int track, int line);