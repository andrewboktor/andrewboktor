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

#import "window.h"
#import <gtk/gtk.h>

#define TC(w) GTK_WINDOW(w)

@implementation Window

- init {
	self = [super init];
	if (self) widget = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	return self;
}

- free {
	g_free(widget);
	return [super free];
}

- defaultSize: (int) width: (int) height {
	gtk_window_set_default_size(TC(widget), width, height);
	return self;
}

- maximize {
	gtk_window_maximize(TC(widget));
	return self;
}

@end

