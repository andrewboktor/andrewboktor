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

#import "list.h"
#import <glib.h>

@implementation List

- init {
	self = [super init];
	if (self) array = g_ptr_array_new();
	return self;
}

- free {
	[self clear];
	g_ptr_array_free(array, YES);
	return [super free];
}

- add: (id) item {
	g_ptr_array_add(array, item);
	return self;
}

- remove: (int) index {
	[[self getItem: index] free];
	g_ptr_array_remove_index_fast(array, index);
	return self;
}

- clear {
	while ([self size] > 0) 
		[self remove: 0];
	return self;
}

- (int) size {
	return array->len;
}

- getItem: (int) index {
	return g_ptr_array_index(array, index);
}

@end

