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

#import "app.h"

@implementation SBApp

- init {
	if ((self = [super init])) {
		generalbox = [[GeneralBox alloc] init];
		
		drawarea_commandbox = [[[[VBox alloc] init] homogeneous: NO] spacing: 2];
		commandbox = [[[[HBox alloc] init] homogeneous: NO] spacing: 5];
		commandlabel = [[[Label alloc] init] text: "Command:"];
		commandtext = [[TextView alloc] init];

		coulconstlabel = [[[Label alloc] init] text: "Electr Const:"];
		coulconstspin = [[[[SpinButton alloc] init] range: 0: 1000000] step: 1: 5];
		coulbox = [[[[HBox alloc] init] 
			packStart: coulconstlabel: NO: NO: 5] 
			packStart: coulconstspin: YES: YES: 0];
		springconstlabel = [[[Label alloc] init] text: "Spring Const:"];
		springconstspin = [[[[SpinButton alloc] init] range: 0: 1000000] step: 1: 5];
		springbox = [[[[HBox alloc] init]
			packStart: springconstlabel: NO: NO: 5] 
			packStart: springconstspin: YES: YES: 0];
		timesteplabel = [[[Label alloc] init] text: "Timestep:"];
		timestepspin = [[[[SpinButton alloc] init] range: 0: 1000] step: 1: 5];
		timebox = [[[[HBox alloc] init]
			packStart: timesteplabel: NO: NO: 5] 
			packStart: timestepspin: YES: YES: 0];
		dampinglabel = [[[Label alloc] init] text: "Damping:"];
		dampingspin = [[[[SpinButton alloc] init] range: 0: 10] step: 0: 5];
		dampbox = [[[[HBox alloc] init]
			packStart: dampinglabel: NO: NO: 5] 
			packStart: dampingspin: YES: YES: 0];
		looplabel = [[[Label alloc] init] text: "Iterate:"];
		loopspin = [[[[SpinButton alloc] init] range: 1: 1000000] step: 1: 5];
		loopbox = [[[[HBox alloc] init] 
			packStart: looplabel: NO: NO: 5] 
			packStart: loopspin: YES: YES: 0];
		algsep = [[HSeparator alloc] init];

		walltog = [[[ToggleButton alloc] init] label: "Wall"];

		execpb = [[ProgressBar alloc] init];
		execute = [[[[Button alloc] init] label: "gtk-execute"] stock: YES];
		save = [[[[Button alloc] init] label: "gtk-save"] stock: YES];
		quitbut = [[[[[Button alloc] init] label: "gtk-quit"] stock: YES] 
			onClicked: (GCallback) gtk_main_quit: NULL];

		searchbutton = [[[[Button alloc] init] label: "gtk-find"] stock: YES];

		drawareasep = [[VSeparator alloc] init];
		drawarea = [[[[DrawingArea alloc] init] 
			doubleBuffered: YES] redrawOnAllocate: YES];

		mainbox = [[[[HBox alloc] init] homogeneous: NO] spacing: 2];

		searchbox = [[[[VBox alloc] init] homogeneous: NO] spacing: 2];
		[searchbox
			packStart: searchbutton];

		filebox = [[[[VBox alloc] init] homogeneous: NO] spacing: 2];
		[[filebox packStart: save] packStart: quitbut];

		layoutbox = [[[[VBox alloc] init] homogeneous: NO] spacing: 2];
		[[[[[[[[[layoutbox 
			packStart: coulbox] packStart: springbox] packStart: timebox]
			packStart: dampbox] packStart: loopbox]
			packStart: algsep: NO: NO: 5]
			packStart: walltog] packStart: execpb] packStart: execute];

		notebook = [[Notebook alloc] init];
		[notebook appendPage: generalbox: [[[Label alloc] init] text: "General"]];
		[notebook appendPage: filebox: [[[Label alloc] init] text: "File"]];
		[notebook appendPage: layoutbox: [[[Label alloc] init] text: "Layout"]];
		[notebook appendPage: searchbox: [[[Label alloc] init] text: "Search"]];
		[[commandbox
			packStart: commandlabel: NO: NO: 5]
			packStart: commandtext: YES: YES: 5];

		[[drawarea_commandbox
			packStart: drawarea: YES: YES: 0]
			packStart: commandbox: NO: NO: 5];

		[[[mainbox 
			packStart: notebook] 
			packStart: drawareasep: NO: NO: 0]
			packStart: drawarea_commandbox: YES: YES: 0];

		[[[[[self borderWidth: 2] defaultSize: 800: 600] add: mainbox] showAll] 
				   onDestroy: (GCallback) gtk_main_quit: NULL];
	}
	return self;
}

- free {
	[generalbox free];
	[notebook free];
	g_free(commandbox);
	g_free(commandlabel);
	g_free(drawarea_commandbox);
	g_free(layoutbox);
	g_free(filebox);
	g_free(searchbox);
	g_free(coulconstlabel);
	g_free(coulconstspin);
	g_free(coulbox);
	g_free(springconstlabel);
	g_free(springconstspin);
	g_free(springbox);
	g_free(timesteplabel);
	g_free(timestepspin);
	g_free(timebox);
	g_free(dampinglabel);
	g_free(dampingspin);
	g_free(dampbox);
	g_free(looplabel);
	g_free(loopspin);
	g_free(loopbox);
	g_free(algsep);
	g_free(walltog);
	g_free(execpb);
	g_free(execute);
	g_free(save);
	g_free(quitbut);
	g_free(mainbox);
	g_free(searchbutton);
	g_free(drawarea);
	return [super free];
}

@end

