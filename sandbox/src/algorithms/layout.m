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

#import "layout.h"
#import <graph.h>
#import <node.h>
#import <point.h>
#import <math.h>
#import <stdlib.h>

#define DEBUG

#ifdef DEBUG
#import <stdio.h>
#endif

@implementation Layout

/* algorithm for one run of the force-based layout:
 * c = electrostatic const (1/(4 PI E0))
 * k = spring constant
 * t = timestep
 * d = damping
 * g = graph to run the algorithm on
 */
+ forceLayout: (double) c: (double) k: (double) t: (double) d: (Graph *) g {
	List *nodelist = [g nodeList];
	List *edgelist = [g edgeList];
	int size = [nodelist size];
	int esize = [edgelist size];
	int width = [g width];
	int height = [g height];
	Node *cur_node, *oth_node;
	Edge *cur_edge;
	Point *netforce, *velocity, *result;
	int i = 0, j = 0;

	[Layout normalizeMass: nodelist];

	i = 0;
	while (i < size) {
		cur_node = [nodelist getItem: i];
		netforce = [cur_node netforce];
		velocity = [cur_node velocity];
		[[netforce x: 0] y: 0];

		if ([cur_node locked] == YES) {
			i++;
			continue;
		}
		
		/* charge repulsion */
/*		j = 0;
		while (j < size) {
			oth_node = [nodelist getItem: j];
			if (cur_node != oth_node) {
				result = [Layout coulrep: c: cur_node: oth_node];
				[[netforce x: [netforce x] + [result x]] 
						   y: [netforce y] + [result y]];
				[result free];
			}

			j++;
		}
*/

		j = 0;
		while (YES) {
			if (j >= size && j >= esize)
				break;

			if (j < size) {
				oth_node = [nodelist getItem: j];
				if (cur_node != oth_node) {
					result = [Layout coulrep: c: cur_node: oth_node];
					[[netforce x: [netforce x] + [result x]] 
							   y: [netforce y] + [result y]];
					[result free];
				}
			}

			if (j < esize) {
				cur_edge = [edgelist getItem: j];
				if (cur_node == [cur_edge pointA] ||
						cur_node == [cur_edge pointB]) {
					result = [Layout hookeatt: k: cur_node: cur_edge];
					[[netforce x: [netforce x] + [result x]]
							   y: [netforce y] + [result y]];
					[result free];
				}
			}

			j++;
		}

		/* spring attraction */
/*		j = 0;
		while (j < [edgelist size]) {
			cur_edge = [edgelist getItem: j];
			if (cur_node == [cur_edge pointA] ||
					cur_node == [cur_edge pointB]) {
				result = [Layout hookeatt: k: cur_node: cur_edge];
				[[netforce x: [netforce x] + [result x]]
						   y: [netforce y] + [result y]];
				[result free];
			}
			j++;
		}
*/
		/* node velocity */
		[[velocity x: ([velocity x] + (t * [netforce x])) * d]
				   y: ([velocity y] + (t * [netforce y])) * d];

		/* node position */
		[[cur_node x: [cur_node x] + (t * [velocity x])] 
			   y: [cur_node y] + (t * [velocity y])];

		if ([g wall] == YES) {
			if ([cur_node x] < [cur_node width])
				[cur_node x: [cur_node width]];
			if ([cur_node y] < [cur_node height])
				[cur_node y: [cur_node height]];
			if ([cur_node x] > width - [cur_node width])
				[cur_node x: width - [cur_node width]];
			if ([cur_node y] > height - [cur_node height])
				[cur_node y: height - [cur_node height]];
		}

		i++;
	}

	return self;
}

/* hooke attraction vector components for x and y directions */
+ (Point *) hookeatt: (double) k: (Node *) n: (Edge *) e {
	Point *a;
	Point *b;
	if (n == [e pointA]) {
		a = [e pointA];
		b = [e pointB];
	}
	else {
		b = [e pointA];
		a = [e pointB];
	}

	double denom = sqrt(pow([a x] - [b x], 2) + pow([a y] - [b y], 2));
	double forcex = (-k * ([a x] - [b x])) / denom;
	double forcey = (-k * ([a y] - [b y])) / denom;

	return [[[[Point alloc] init] x: forcex] y: forcey];

/*	double force = [Layout hooke_scalar: k: e];
	double angle;
*/
	/* used to get the direction of the force, switches 
	 * between current and origin nodes and from/to
	 */
/*	if (n == [e pointA])
		angle = [Layout theta: [e pointB]: [e pointA]];
	else if (n == [e pointB])
		angle = [Layout theta: [e pointA]: [e pointB]];

	return [[[[Point alloc] init] x: force * cos(angle)] y: force * sin(angle)];
*/
}

/* scalar value of the attraction force
 * NOTE: assumes the spring's natural energy position = 0 
 */
/*
+ (double) hooke_scalar: (double) k: (Edge *) e {
	return k * [Layout distance: [e pointA]: [e pointB]];
}
*/

/* coulomb repulsion vector components in x and y directions */
+ (Point *) coulrep: (double) c: (Node *) n1: (Node *) n2 {

	double masses = n1->mass * n2->mass;
	double denom = pow((pow([n1 x] - [n2 x], 2) + pow([n1 y] - [n2 y], 2)), (3 / 2));
	double forcex = masses * ((([n1 x] - [n2 x]) * c) / denom);
	double forcey = masses * ((([n1 y] - [n2 y]) * c) / denom);

	return [[[[Point alloc] init] x: forcex] y: forcey];

/*	double force = [Layout coul_scalar: c: n1: n2];
	double angle = [Layout theta: n1: n2];
	return [[[[Point alloc] init] x: force * cos(angle)] y: force * sin(angle)];
*/
}

/* the scalar value of the repulsion force */
/*
+ (double) coul_scalar: (double) c: (Node *) n1: (Node *) n2 {
	int charges = n1->mass * n2->mass;
	int distance = [Layout distance: n1: n2];
	if (distance == 0)	*/	/* if distance is 0 then the force is infinite */
/*		return 0.5;
	return c * (charges / (distance * distance));
}
*/

/* theta = invtan (b / a) */
/* + (double) theta: (Point *) cur: (Point *) origin {
	int b = [cur y] - [origin y];
	int a = [cur x] - [origin x];
	if (a == 0) {	*/	/* infinity */
/*		if (b >= 0)
			return 90.0;
		else	*/	/* negative infinity */
/*			return 270.0;
	}		*/			/* every other number in between */
/*	return atan(b / a);
}
*/

/* distance between two points */
/* + (int) distance: (Point *) n1: (Point *) n2 {
	int dx = [n1 x] - [n2 x];
	int dy = [n1 y] - [n2 y];
	return sqrt((dx * dx) + (dy * dy));
}
*/

/* choose the smallest mass as the base for multiples */
+ (void) normalizeMass: (List *) nodeList {
	int size = [nodeList size];
	if (size == 0) return;
	int i = 0;
	Node *node = [nodeList getItem: 0];
	int min = node->mass;

	i = 0;
	while (i < size) {
		node = [nodeList getItem: i];
		if (node->mass < min)
			min = node->mass;
		i++;
	}

	i = 0;
	while (i < size) {
		node = [nodeList getItem: i];
		node->mass = node->mass / min;
		i++;
	}
}

@end

