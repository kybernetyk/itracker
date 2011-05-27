//
//  musicbuffer.m
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicbuffer.h"


struct pattern_t *pattern_new(int lines_per_beat, int tracks, int lines)
{
	struct pattern_t *p = malloc(sizeof(struct pattern_t));
	p->num_lpb = lines_per_beat;
	p->num_lines = lines;
	p->num_tracks = tracks;
	
	p->tracks = malloc(sizeof(struct track_t)*tracks);
	for (int i = 0; i < tracks; i ++) {
		p->tracks[i].elements = malloc(sizeof(struct element_t) * lines);
		for (int j = 0; j < lines; j++) {
			p->tracks[i].elements[j].duration = 0;
			p->tracks[i].elements[j].effect = 0;
		}
		p->tracks[i].instrument_id = 0;
	}
	
	return p;
}


void pattern_free(struct pattern_t *p)
{
	for (int i = 0; i < p->num_tracks; i++)
		free(p->tracks[i].elements);
	free(p->tracks);
	free(p);
}

struct element_t *pattern_elem_at(struct pattern_t *p, int track, int line)
{
	if (track >= p->num_tracks || line >= p->num_lines || 
		track < 0 || line < 0) {
		abort();
	}
	
	NSLog(@"accessing element @ %i,%i", track, line);
	struct element_t *e = &p->tracks[track].elements[line];
	return e;
}