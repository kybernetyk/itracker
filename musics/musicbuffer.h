//
//  ptrnbuf_
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#pragma once

//each element tells the player engine what to do
struct element_t {
	int duration;		//actually duration is only a boolean value if play or not
	int effect;			//effects ... hum - will probably never use that :]
	//other shit
};

//each track has an instrument assigned and contains notes (elements)
struct track_t {
	struct element_t *elements;
	int instrument_id;
};

//a pattern can have N tracks.
struct pattern_t {
	struct track_t *tracks;

	int num_lpb; //lines per beat
	int num_tracks;
	int num_lines;
};


extern struct pattern_t *pattern_new(int lines_per_beat, int tracks, int lines);
extern void pattern_free(struct pattern_t *p);

extern struct element_t *pattern_elem_at(struct pattern_t *p, int track, int line);