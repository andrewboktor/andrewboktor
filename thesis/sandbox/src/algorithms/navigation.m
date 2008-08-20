
#import "navigation.h"
//#import <graph.h>
#import <node.h>
#import <point.h>
#import <stdlib.h>

#define DEBUG

#ifdef DEBUG
#import <stdio.h>
#endif

@implementation Navigation

- init {
	self = [super init];
	return self;
}

-free {
	return [super free];
}

- (void) next_edge {
	if ([edgelist size]<=0) return;
	if (current_edge < 0)
		current_edge = 0;
	else 
	[[edgelist getItem: current_edge] unselect];
	current_edge++;
	current_edge = current_edge % [edgelist size];
	[[edgelist getItem: current_edge] select];
}


- (void) set_lists: (List *) nl: (List *) el {
	graph_nodelist = nl;
	graph_edgelist = el;
}

- (Edge *) get_current_edge {
	return [edgelist getItem: current_edge];
}

- (void) generate_edge_list {
	edgelist = [[List alloc] init];
	
	int i = 0;
	while (i<[graph_edgelist size])
	{
		if ([[graph_edgelist getItem: i] pointA] == current_node
			|| [[graph_edgelist getItem: i] pointB] == current_node)
				[edgelist add: [graph_edgelist getItem: i]];
		i++;
	}
}

- (void) set_current_edge: (int) n {
	current_edge = n;
}

- (void) next_node {
	[self unselect_all_nodes];
	[self unselect_all_edges];
	if (current_node == [[edgelist getItem: current_edge] pointA])
			[self set_current_node: 
		[((Node *) [[edgelist getItem: current_edge] pointB]) select]];
	else
		[self set_current_node:
	 [((Node *) [[edgelist getItem: current_edge] pointA]) select]];

}

- (void) set_current_node: (Node *) node {
	current_node = node;
	[self generate_edge_list];
	[self set_current_edge: 0];
}

- (int) get_node_index: (Node *) node {
	int i = 0;
	while (i<[graph_nodelist size])
	{
		if ( node == [graph_nodelist getItem: i])
			return i;
		i++;
	}
}

- (void) unselect_all_edges {
	int i = 0;
	while (i<[graph_edgelist size])
	{
		[[graph_edgelist getItem: i] unselect];
		i++;
	}
}

- (void) unselect_all_nodes {
	int i = 0;
	while (i<[graph_nodelist size])
	{
		[[graph_nodelist getItem: i] unselect];
		i++;
	}
}

- (int) abs: (int) x {
	if (x<0) return -x;
	else return x;
}

- (void) tab_next_node {
	int i=0;
	while (i<[graph_nodelist size])
	{
		if([graph_nodelist getItem: i] == current_node)
		{
			[current_node unselect];
			i++;
			i=i%[graph_nodelist size];
			[self set_current_node: [[graph_nodelist getItem: i] select]];
			return;
		}
		i++;
	}
	if([graph_nodelist size]>=1)
		[self set_current_node: [[graph_nodelist getItem: 0] select]]; 
}

- (void) node_to_right {
	List *temp = [[List alloc] init];
	int smallest = -1, smallest_i=-1, i=0;
	while (i<[graph_nodelist size])
	{
		if ([graph_nodelist getItem: i] != current_node)
		{
			if ([[graph_nodelist getItem: i] x] < [current_node x])
			{
				i++;
				continue;
			}
			int dist =  [self abs: [[graph_nodelist getItem: i] y] - [current_node y]];
			if (dist < smallest || smallest < 0)
			{
				smallest = dist;
				smallest_i = i;
			}
		}
		i++;
	}
	if (smallest_i < 0) return;
	[self unselect_all_nodes];
	current_node = [graph_nodelist getItem: smallest_i];
	[current_node select];
}

- (void) node_to_left {
	List *temp = [[List alloc] init];
	int smallest = -1, smallest_i=-1, i=0;
	while (i<[graph_nodelist size])
	{
		if ([graph_nodelist getItem: i] != current_node)
		{
			if ([[graph_nodelist getItem: i] x] > [current_node x])
			{
				i++;
				continue;
			}
			int dist =  [self abs: [[graph_nodelist getItem: i] y] - [current_node y]];
			if (dist < smallest || smallest < 0)
			{
				smallest = dist;
				smallest_i = i;
			}
		}
		i++;
	}
	if (smallest_i < 0) return;
	[self unselect_all_nodes];
	current_node = [graph_nodelist getItem: smallest_i];
	[current_node select];
}


- (void) node_to_up {
	List *temp = [[List alloc] init];
	int smallest = -1, smallest_i=-1, i=0;
	while (i<[graph_nodelist size])
	{
		if ([graph_nodelist getItem: i] != current_node)
		{
			if ([[graph_nodelist getItem: i] y] > [current_node y])
			{
				i++;
				continue;
			}
			int dist =  [self abs: [[graph_nodelist getItem: i] x] - [current_node x]];
			if (dist < smallest || smallest < 0)
			{
				smallest = dist;
				smallest_i = i;
			}
		}
		i++;
	}
	if (smallest_i < 0) return;
	[self unselect_all_nodes];
	current_node = [graph_nodelist getItem: smallest_i];
	[current_node select];
}


- (void) node_to_down {
	List *temp = [[List alloc] init];
	int smallest = -1, smallest_i=-1, i=0;
	while (i<[graph_nodelist size])
	{
		if ([graph_nodelist getItem: i] != current_node)
		{
			if ([[graph_nodelist getItem: i] y] < [current_node y])
			{
				i++;
				continue;
			}
			int dist =  [self abs: [[graph_nodelist getItem: i] x] - [current_node x]];
			if (dist < smallest || smallest < 0)
			{
				smallest = dist;
				smallest_i = i;
			}
		}
		i++;
	}
	if (smallest_i < 0) return;
	[self unselect_all_nodes];
	current_node = [graph_nodelist getItem: smallest_i];
	[current_node select];
}



@end

