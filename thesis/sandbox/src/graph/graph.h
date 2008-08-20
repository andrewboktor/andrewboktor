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
#define NAVIGATION_ENABLE
#import <objc/Object.h>
#import "point.h"
#import "node.h"
#import "edge.h"
#import <list.h>
#import <glib.h>
#import <cairo.h>
#ifdef NAVIGATION_ENABLE
#import "navigation.h"
#endif


@interface Graph : Object {
@protected
	List *nodeList, *edgeList;
	int width, height;
	BOOL wall;
#ifdef NAVIGATION_ENABLE
	Navigation *navigation;
#endif
}

- init;
- free;


#ifdef NAVIGATION_ENABLE
- (Navigation *) get_navigation;
#endif
- (Node *) getNodeByID: (int) ID;
- expose: (cairo_t *) context;
- (List *) nodeList;
- (List *) edgeList;
- (int) width;
- (int) height;
- width: (int) w;
- height: (int) h;
- addNode: (Node *) node;
- addEdge: (Edge *) edge;
- (Node *) getNodeByPos: (int) x: (int) y;
- (BOOL) wall;
- wall: (BOOL) val;

@end

