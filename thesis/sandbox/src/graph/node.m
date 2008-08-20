/*
	This file is part of Sandbox.

	Copyright (C) 2008  Frederic-Gerald Morcos <fred.morcos@gmail.com>

	Sandbox is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	Sandbox is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License 
	along with Sandbox.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "node.h"
#import <cairo.h>
#import <math.h>
#import <stdlib.h>

@implementation Node

- init {
	self = [super init];
	if (self) {
		netforce = [[Point alloc] init];
		velocity = [[Point alloc] init];
		properties = malloc(sizeof(Properties));
	}
	return self;
}

- free {
	if (netforce) [netforce free];
	if (velocity) [velocity free];
	return [super free];
}

- (int) getnodeid {
	return node_id;
}

- setnodeid: (int) new_id {
	node_id = new_id;
	printf ("Set ID %d\n", node_id);
	return self;
}

- expose: (cairo_t *) context {
	if (locked)
		cairo_set_source_rgba(context, 1.0, 0.0, 0.0, 0.5);
	else
		cairo_set_source_rgba(context, 0.0, 0.0, 0.0, 0.5);

	switch (properties->type)
	{
		case RECTANGLE:
			cairo_rectangle	(context, 
					x - (width / 2), 
					y - (height / 2), 
					width, 
					height);
			break;

		case ELLIPSE:
			cairo_arc (context, 
					x,
					y,
					width / 2,
					0,
					2 * M_PI);
			break;
			
		case TRIANGLE:
			cairo_move_to (context, x-width/2, y+height/2);
			cairo_rel_line_to (context, width/2, -height);
			cairo_rel_line_to (context, width/2, height);
			cairo_close_path (context);
			break;
			
		case NOTE:
			width = 35;
			height = 13;
			cairo_move_to (context, x-13, y+4);
			cairo_text_path (context, "NOTE");
			break;

		default:
	    	//	printf ("Warning: Shape Type not defined"); 
			cairo_rectangle	(context, 
					x - (width / 2), 
					y - (height / 2), 
					width, 
					height);
			break;
	}
	
	
	if (selected) {
		cairo_set_line_width (context, 2);
		cairo_fill_preserve(context);
		cairo_set_source_rgb(context, 0.0, 1.0, 0.0);
		cairo_stroke(context);
	}
	else
	{
			cairo_fill(context);
	}
	return self;
}

- (int) width {
	return width;
}

- (int) height {
	return height;
}

- width: (int) val {
	width = val;
	mass = width * height;
	return self;
}

- height: (int) val {
	height = val;
	mass = width * height;
	return self;
}

- netforce: (Point *) val {
	netforce = val;
	return self;
}

- (Point *) netforce {
	return netforce;
}

- velocity: (Point *) val {
	velocity = val;
	return self;
}

- (Point *) velocity {
	return velocity;
}

- lock {
	locked = YES;
	return self;
}

- unlock {
	locked = NO;
	return self;
}

- (BOOL) locked {
	return locked;
}

- (BOOL) selected {
	return selected;
}

- select {
	selected = YES;
	return self;
}

- unselect {
	selected = NO;
	return self;
}

- (NodeType) type {
	return properties->type;
}

- type: (NodeType) val {
	properties->type = val;
	return self;
}

- (Style) lineStyle {
	return properties->lineStyle;
}

- lineStyle: (Style) val {
	properties->lineStyle = val;
	return self;
}

- (Color) lineColor {
	return properties->lineColor;
}

- lineColor: (Color) val {
	properties->lineColor = val;
	return self;
}

- (Color) fillColor {
	return properties->fillColor;
}

- fillColor: (Color) val {
	properties->fillColor = val;
	return self;
}

- (char *) comment {
	return properties->comment;
}

- comment: (char *) val {
	properties->comment = val;
	return self;
}

@end

