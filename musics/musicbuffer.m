//
//  musicbuffer.m
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicbuffer.h"

struct music_buffer_t *mbuf_new(enum mbuf_mode mode, int cols, int rows)
{
	struct music_buffer_t *p = malloc(sizeof(struct music_buffer_t));
	
	p->buf = malloc(sizeof(struct music_element_t)*cols*rows);
	p->mode = mode;
	p->cols = cols;
	p->rows = rows;
	mbuf_init(p);
	return p;
}


void mbuf_init(struct music_buffer_t *pbuf)
{
	for (int i = 0; i < pbuf->cols * pbuf->rows; i++) {
		pbuf->buf[i].sample_id = 0;
	}
}

void mbuf_free(struct music_buffer_t *pbuf)
{
	free(pbuf->buf);
	free(pbuf);
}

struct music_element_t *mbuf_elem_at(struct music_buffer_t *pbuf, int col, int row)
{
	if (col >= pbuf->cols || row >= pbuf->rows || 
		col < 0 || row < 0) {
		abort();
	}
	return &pbuf->buf[col + row * COLS];	
}