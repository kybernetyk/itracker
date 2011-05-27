//
//  musicbuffer.h
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#pragma once

struct music_element_t {
	int sample_id;
};

struct music_buffer_t {
	struct music_element_t buf[MUS_BUFSZ];
};


extern struct music_buffer_t *mbuf_new(void);
extern void mbuf_init(struct music_buffer_t *pbuf);
extern void mbuf_free(struct music_buffer_t *pbuf);

extern struct music_element_t *mbuf_elem_at(struct music_buffer_t *pbuf, int col, int row);