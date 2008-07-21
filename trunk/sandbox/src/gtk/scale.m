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

#import "scale.h"

#define TC(w) GTK_SCALE(w)

@implementation Scale

- drawValue: (BOOL) val {
	if (widget == NULL) return self;
	gtk_scale_set_draw_value(TC(widget), val);
	return self;
}

- valuePosition: (GtkPositionType) pos {
	if (widget == NULL) return self;
	gtk_scale_set_value_pos(TC(widget), pos);
	return self;
}

@end

