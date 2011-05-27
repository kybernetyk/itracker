//
//  musicbuffer.m
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "musicbuffer.h"

struct music_buffer_t *mbuf_new(void) 
{
	struct music_buffer_t *p = malloc(sizeof(struct music_buffer_t));
	mbuf_init(p);
	return p;
}


void mbuf_init(struct music_buffer_t *pbuf)
{
	for (int i = 0; i < MUS_BUFSZ; i++) {
		pbuf->buf[i].sample_id = 0;
	}
}

void mbuf_free(struct music_buffer_t *pbuf)
{
	free(pbuf);
}

struct music_element_t *mbuf_elem_at(struct music_buffer_t *pbuf, int col, int row)
{
	return &pbuf->buf[col + row * COLS];	
}