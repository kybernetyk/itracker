//
//  ptrnbuf_
//  musics
//
//  Created by jrk on 27/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#pragma once

enum ptrnbuf_mode {
	e_mode_eights,
	e_mode_fourths
};

struct pattern_element_t {
	int sample_id;
};

struct pattern_buffer_t {
	struct pattern_element_t *buf;

	enum ptrnbuf_mode mode;
	int cols, rows;
};


extern struct pattern_buffer_t *ptrnbuf_new(enum ptrnbuf_mode mode, int cols, int rows);
extern void ptrnbuf_init(struct pattern_buffer_t *pbuf);
extern void ptrnbuf_free(struct pattern_buffer_t *pbuf);

//access mode is the mode the UI is in. if the UI shows fourths and wants to access row 1
//and our pattern buffer holds eights we will actually return row 2 (which is the start of the 2nd fourth note)
extern struct pattern_element_t *ptrnbuf_elem_at(struct pattern_buffer_t *pbuf, int col, int row, enum ptrnbuf_mode access_mode);