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

#import <gtk/gtk.h>
#import "widget.h"
#import "container.h"
#import "bin.h"
#import "window.h"
#import "button.h"
#import "box.h"
#import "vbox.h"
#import "hbox.h"
#import "drawingarea.h"
#import "entry.h"
#import "spinbutton.h"
#import "misc.h"
#import "label.h"
#import "separator.h"
#import "hseparator.h"
#import "vseparator.h"
#import "combobox.h"
#import "range.h"
#import "scale.h"
#import "hscale.h"
#import "vscale.h"
#import "togglebutton.h"
#import "progress.h"
#import "progressbar.h"
#import "notebook.h"
#import "textview.h"

@interface Gtk {
}

+ init: (int *) argc: (char ***) argv;
+ main;
+ mainQuit;
+ (BOOL) iterationDo: (BOOL) blocking;

@end

