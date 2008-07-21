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

#import "nodes.h"
#import <graph.h>
#import <node.h>

@implementation Nodes

+ nodeRandomProperties: (Node *) node {
	GRand *pRand = g_rand_new();
	[[[[node type: g_rand_int_range(pRand, 0, 6)] 
	      lineStyle: g_rand_int_range(pRand, 0, 2)] 
	      lineColor: g_rand_int_range(pRand, 0, 4)] 
	      fillColor: g_rand_int_range(pRand, 0, 4)];
	g_rand_free(pRand);
	return self;
}

+ nodesRandom: (Graph *) graph {
	List *list = [graph nodeList];
	Node *v;
	GRand *pRand = g_rand_new();
	int i = 0;
	int width = [graph width];
	int height = [graph height];

	while (i < [list size]) {
		v = [list getItem: i];
		[[v x: g_rand_int_range(pRand, 
				([v width] / 2), width - ([v width] / 2))] 
			y: g_rand_int_range(pRand, 
				([v height] / 2), height - ([v width] / 2))];
		[Nodes nodeRandomProperties: v];
		i++;
	}
	g_rand_free(pRand);
	return self;
}

+ edgesCircular: (Graph *) graph {
	int i = 0;
	List *list = [graph nodeList];

	while (i < [list size]) {
		if (i == [list size] - 1)
			[graph addEdge: [[[[Edge alloc] init] 
					pointA: [list getItem: i]] 
					pointB: [list getItem: 0]]];
		else
			[graph addEdge: [[[[Edge alloc] init] 
					pointA: [list getItem: i]] 
					pointB: [list getItem: i + 1]]];

		i++;
	}
	return self;
}

+ edgesCentered: (Graph *) graph {
	int i = 1;
	List *list = [graph nodeList];

	while (i < [list size]) {
		[graph addEdge: [[[[Edge alloc] init]
				pointA: [list getItem: 0]]
				pointB: [list getItem: i]]];
		i++;
	}
	return self;
}

+ edgesInterconnected: (Graph *) graph {
	List *list = [graph nodeList];
	int i = 0, j = 0;
	int list_size = [list size];

	while (i < list_size) {
		j = i;
		while (j < list_size) {
			[graph addEdge: [[[[Edge alloc] init]
					pointA: [list getItem: i]]
					pointB: [list getItem: j]]];
			j++;
		}
		i++;
	}
	return self;
}

+ edgesBinaryTree: (Graph *) graph {
	List *list = [graph nodeList];
	int i = 0, cur_index = 0;
	int list_size = [list size];

	while (i < list_size) {
		cur_index = (2 * i);
		if (cur_index + 1 > list_size - 1)
			break;
		else
			[graph addEdge: [[[[Edge alloc] init]
					 pointA: [list getItem: i]]
					 pointB: [list getItem: cur_index + 1]]];

		if (cur_index + 2 > list_size - 1)
			break;
		else
			[graph addEdge: [[[[Edge alloc] init]
					pointA: [list getItem: i]]
					pointB: [list getItem: cur_index + 2]]];
		i++;
	}
	return self;
}

@end

