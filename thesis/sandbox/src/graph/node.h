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

#import "point.h"
#import "node-properties.h"
#import <cairo.h>

@interface Node : Point {
@public
	int mass;
@protected
	Point *netforce;
	Point *velocity;
	int width, height;
	BOOL locked, selected;
	Properties *properties;
	int node_id;
}

- init;
- free;

- (int) getnodeid;
- setnodeid: (int) new_id;
- expose: (cairo_t *) context;
- (int) width;
- (int) height;
- width: (int) val;
- height: (int) val;
- netforce: (Point *) val;
- (Point *) netforce;
- velocity: (Point *) val;
- (Point *) velocity;
- lock;
- unlock;
- (BOOL) locked;
- (BOOL) selected;
- select;
- unselect;
- (NodeType) type;
- type: (NodeType) val;
- (Style) lineStyle;
- lineStyle: (Style) val;
- (Color) lineColor;
- lineColor: (Color) val;
- (Color) fillColor;
- fillColor: (Color) val;
- (char *) comment;
- comment: (char *) val;

@end

