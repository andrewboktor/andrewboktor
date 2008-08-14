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

#import <objc/Object.h>
#import "graph.h"
#import "node.h"

@interface Layout: Object {
}

+ forceLayout: (double) c: (double) k: (double) t: (double) d: (Graph *) g;

+ (Point *) hookeatt: (double) k: (Node *) n: (Edge *) e;
// + (double) hooke_scalar: (double) k: (Edge *) e;
+ (Point *) coulrep: (double) c: (Node *) n1: (Node *) n2;
// + (double) coul_scalar: (double) c: (Node *) n1: (Node *) n2;
// + (double) theta: (Point *) cur: (Point *) origin;
// + (int) distance: (Point *) n1: (Point *) n2;
+ (void) normalizeMass: (List *) nodeList;

@end

