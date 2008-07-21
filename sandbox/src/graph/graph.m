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

#import "graph.h"
#import "edge.h"
#import "node.h"
#import <list.h>

@implementation Graph

- init {
	self = [super init];
	if (self) {
		nodeList = [[List alloc] init];
		edgeList = [[List alloc] init];
#ifdef NAVIGATION_ENABLE
		navigation = [[Navigation alloc] init];
		[navigation set_lists: nodeList: edgeList];
#endif
	}
	return self;
}

- free {
	[nodeList free];
	[edgeList free];
	nodeList = NULL;
	edgeList = NULL;
	return [super free];
}

#ifdef NAVIGATION_ENABLE
- (Navigation *) get_navigation {
	printf ("Get Navigation\n");
	return navigation;
}
#endif
- expose: (cairo_t *) context {
	int i = 0;
	while (i < [nodeList size]) {
		[[nodeList getItem: i] expose: context];
		i++;
	}

	i = 0;
	while (i < [edgeList size]) {
		[[edgeList getItem: i] expose: context];
		i++;
	}

	if (wall == YES) {
		cairo_set_source_rgb(context, 0.5, 0.0, 0.0);
		cairo_set_line_width(context, 15.0);
		cairo_rectangle(context, 0, 0, width, height);
		cairo_stroke(context);
	}
	return self;
}

- (List *) nodeList {
	return nodeList;
}

- (List *) edgeList {
	return edgeList;
}

- (int) width {
	return width;
}

- (int) height {
	return height;
}

- width: (int) w {
	width = w;
	return self;
}

- height: (int) h {
	height = h;
	return self;
}

- addNode: (Node *) node {
	[nodeList add: node];
	return self;
}

- addEdge: (Edge *) edge {
	[edgeList add: edge];
	return self;
}

- (Node *) getNodeByPos: (int) x: (int) y {
	int i = 0;
	Node *n;

	while (i < [nodeList size]) {
		n = [nodeList getItem: i];
		if (x >= ([n x] - ([n width] / 2)) &&
				x <= ([n x] + ([n width] / 2)) &&
				y >= ([n y] - ([n height] / 2)) &&
				y <= ([n y] + ([n width] / 2)))
			return n;
		i++;
	}
	return NULL;
}

- (BOOL) wall {
	return wall;
}

- wall: (BOOL) val {
	wall = val;
	return self;
}

@end

