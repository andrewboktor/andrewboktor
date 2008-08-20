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

#import "edge.h"
#import "point.h"
#import <cairo.h>

@implementation Edge

- init {
	self = [super init];
	if (self) {
		pointA = [[Point alloc] init];
		pointB = [[Point alloc] init];
	}
	return self;
}

- free {
	return [super free];
}

- expose: (cairo_t *) context {
	if (selected)
	{
		cairo_set_source_rgba(context, 0.0, 1.0, 0.0, 1.0);
		cairo_set_line_width(context, 5);
		cairo_move_to(context, [pointA x], [pointA y]);
		cairo_line_to(context, [pointB x], [pointB y]);
		cairo_stroke(context);
	}

	cairo_set_source_rgba(context, 0.0, 0.0, 0.0, 0.5);
	cairo_set_line_width(context, 2);
	cairo_move_to(context, [pointA x], [pointA y]);
	cairo_line_to(context, [pointB x], [pointB y]);
	cairo_stroke(context);

	return self;
}

- (Point *) pointA {
	return pointA;
}

- (Point *) pointB {
	return pointB;
}

- pointA: (Point *) pa {
	pointA = pa;
	return self;
}

- pointB: (Point *) pb {
	pointB = pb;
	return self;
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
@end

