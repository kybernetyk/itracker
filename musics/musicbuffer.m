//
//  musicbuffer.m
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicbuffer.h"

struct pattern_buffer_t *ptrnbuf_new(enum ptrnbuf_mode mode, int cols, int rows)
{
	struct pattern_buffer_t *p = malloc(sizeof(struct pattern_buffer_t));
	
	p->buf = malloc(sizeof(struct pattern_element_t)*cols*rows);
	p->mode = mode;
	p->cols = cols;
	p->rows = rows;
	ptrnbuf_init(p);
	return p;
}


void ptrnbuf_init(struct pattern_buffer_t *pbuf)
{
	for (int i = 0; i < pbuf->cols * pbuf->rows; i++) {
		pbuf->buf[i].sample_id = 0;
	}
}

void ptrnbuf_free(struct pattern_buffer_t *pbuf)
{
	free(pbuf->buf);
	free(pbuf);
}

struct pattern_element_t *ptrnbuf_elem_at(struct pattern_buffer_t *pbuf, int col, int row, enum ptrnbuf_mode access_mode)
{
	if (access_mode == e_mode_fourths && pbuf->mode == e_mode_eights)
		row *= 2;
	if (access_mode == e_mode_eights && pbuf->mode == e_mode_fourths)
		row /= 2;
	
	if (col >= pbuf->cols || row >= pbuf->rows || 
		col < 0 || row < 0) {
		abort();
	}
	
	NSLog(@"accessing element @ %i,%i", col, row);
	
	return &pbuf->buf[col + row * pbuf->cols];	
}