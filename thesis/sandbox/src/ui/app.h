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

#import <gtk.h>
#import "general.h"
#import "textview.h"
#import <gtk/gtk.h>

@interface SBApp : Window {
@public
	Notebook *notebook;
	GeneralBox *generalbox;
	VBox *layoutbox;
	VBox *filebox;
	VBox *searchbox;
	
	VBox *drawarea_commandbox;


	HBox *commandbox;
	Label *commandlabel;
	TextView *commandtext;
	GtkTextBuffer *commandbuffer;


	Label *coulconstlabel;
	SpinButton *coulconstspin;
	HBox *coulbox;
	Label *springconstlabel;
	SpinButton *springconstspin;
	HBox *springbox;
	Label *timesteplabel;
	SpinButton *timestepspin;
	HBox *timebox;
	Label *dampinglabel;
	SpinButton *dampingspin;
	HBox *dampbox;
	Label *looplabel;
	SpinButton *loopspin;
	HBox *loopbox;
	HSeparator *algsep;

	ToggleButton *walltog;

	ProgressBar *execpb;
	Button *execute;
	Button *save;
	Button *quitbut;
	HBox *mainbox;

	Button *searchbutton;

	VSeparator *drawareasep;
	DrawingArea *drawarea;
}

- init;
- free;

@end

