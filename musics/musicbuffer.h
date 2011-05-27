//
//  musicbuffer.h
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#pragma once

enum mbuf_mode {
	e_mode_eights,
	e_mode_fourths
};

struct music_element_t {
	int sample_id;
};

struct music_buffer_t {
	struct music_element_t *buf;

	enum mbuf_mode mode;
	int cols, rows;
};


extern struct music_buffer_t *mbuf_new(enum mbuf_mode mode, int cols, int rows);
extern void mbuf_init(struct music_buffer_t *pbuf);
extern void mbuf_free(struct music_buffer_t *pbuf);

extern struct music_element_t *mbuf_elem_at(struct music_buffer_t *pbuf, int col, int row);