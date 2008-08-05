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

#import <app.h>
#import <graph.h>
#import <layout.h>
#import <nodes.h>
#import "script.h"
#import <gdk/gdkkeysyms.h>

static gboolean area_expose(GtkWidget *, GdkEventExpose *, gpointer);
static void nodeapply_click(GtkButton *, gpointer);
static void edgeapply_click(GtkButton *, gpointer);
static void execute_click(GtkButton *, gpointer);
static void save_click(GtkButton *, gpointer);
static gboolean area_press(GtkWidget *, GdkEventButton *, gpointer);
static gboolean area_release(GtkWidget *, GdkEventButton *, gpointer);
static gboolean area_motion(GtkWidget *, GdkEventMotion *, gpointer);
static void scale_valuechanged(GtkRange *, gpointer);
static void wall_toggle(GtkToggleButton *, gpointer);
static gboolean area_config(GtkWidget *, GdkEventConfigure *, gpointer);
static void event_handler (GtkWindow *, GdkEvent *, gpointer);


SBApp *app = NULL;
Graph *graph = NULL;
Node *drag_node = NULL;
double scaling = 1.0;

int main(int argc, char* argv[])
{
	[Gtk init: &argc: &argv];

	app = [[SBApp alloc] init];
	[app->drawarea onExpose: (GCallback) area_expose: NULL];
	[app->drawarea onButtonPress: (GCallback) area_press: NULL];
	[app->drawarea onButtonRelease: (GCallback) area_release: NULL];
	[app->drawarea onMotionNotify: (GCallback) area_motion: NULL];
	[app->generalbox->edgeapply onClicked: (GCallback) edgeapply_click: NULL];
	[app->generalbox->nodeapply onClicked: (GCallback) nodeapply_click: NULL];
	[app->execute onClicked: (GCallback) execute_click: NULL];
	[app->generalbox->scale onValueChanged: (GCallback) scale_valuechanged: NULL];
	[app->walltog onToggled: (GCallback) wall_toggle: NULL];
	[app->drawarea onConfigure: (GCallback) area_config: NULL];
	[app->save onClicked: (GCallback) save_click: NULL];
	[app gtk_event: (GCallback) event_handler: NULL];
	graph = [[Graph alloc] init];
	(void)area_config(NULL, NULL, NULL);
	
	[Gtk main];
	[graph free];

	return 0;
}

static void event_handler (GtkWindow *window, GdkEvent *event, gpointer data) {
	static int navigating;

	if (event->type == GDK_KEY_PRESS)
	{
		
		printf ("Key Pressed\n");
		if (((GdkEventKey *) event)->keyval == 'z')
		{
			printf ("Script called\n");
			//[Script exec_commands: "rectangle 100 100 50 50\ncircle 200 200 30\nrectangle 300 300 30 50": graph];
			[Script exec_file: "/home/drew/Desktop/script": graph];
			[app->drawarea queueDraw];
		}
		if (((GdkEventKey *) event)->keyval == 'n' |((GdkEventKey *) event)->keyval == 'm') 
			if (navigating) navigating = 0;
			else navigating = ((GdkEventKey *) event)->keyval;
		

		if ([graph get_navigation] && navigating)
		{
			if (navigating == 'n')
			{	
				switch (((GdkEventKey *) event)->keyval)
				{
					case 's':
							[[graph get_navigation] next_edge];	
						break;
					case 'd':
						[[graph get_navigation] next_node];
						break;
				}
			}

			if (navigating == 'm')
			{
	
				switch (((GdkEventKey *) event)->keyval)
				{
					case GDK_Left:
						[[graph get_navigation] node_to_left];
						break;
					case GDK_Right:
						[[graph get_navigation] node_to_right];
						break;
					case GDK_Up:
						[[graph get_navigation] node_to_up];
						break;
					case GDK_Down:
						[[graph get_navigation] node_to_down];
						break;
				}

			}
			[app->drawarea queueDraw];
		}

		
	}

	else return;
}

static void execute_click(GtkButton *widget, gpointer data) {
	double electro_const = [app->coulconstspin valueInt] / 10.0;
	double spring_const = [app->springconstspin valueInt] / 10.0;
	double timestep = [app->timestepspin valueInt] / 100.0;
	double damping = [app->dampingspin valueDouble] / 10.0;
	int loop = [app->loopspin valueInt];

	g_print("Electrostatic Constant: %g\n", electro_const);
	g_print("Spring Constant: %g\n", spring_const);
	g_print("Timestep: %g\n", timestep);
	g_print("Damping: %g\n", damping);
	g_print("Loop %d times\n", loop);

	[app->execpb configure: 0.0: 0.0: loop];

#pragma omp parallel for
	for (; loop > 0; loop--) {
		[Layout forceLayout: 
				  electro_const: spring_const: 
					   timestep: damping: graph];
		if (!(loop % 200))
		{
			[app->execpb value: [app->execpb value] + 200];
			(void)area_expose([app->drawarea widget], NULL, NULL);
			while (g_main_context_iteration(NULL, FALSE));
		}

		loop--;
	}

	[app->drawarea queueDraw];
}

static gboolean area_expose(GtkWidget *widget, GdkEventExpose *event, gpointer data) {
	static cairo_t *context;
	context = gdk_cairo_create(widget->window);
	gdk_window_clear(widget->window);
	cairo_scale(context, scaling, scaling);
	
	/* clip around the draw area to make things faster */
/*	cairo_rectangle(context, 0.0, 0.0, 
			widget->allocation.width + widget->allocation.width * scaling, 
			widget->allocation.height + widget->allocation.height * scaling);
	cairo_clip(context);
*/
	[graph expose: context];
	cairo_destroy(context);

	return FALSE;
}

static void nodeapply_click(GtkButton *button, gpointer data) {
	int i = 0;
	[[graph nodeList] clear];
	while (i < [app->generalbox->nodespin valueInt]) {
		if (i % 2)
			[graph addNode: [[[[[Node alloc] init] width: 10] height: 10] comment: "just trying small"]];
		else
			[graph addNode: [[[[[Node alloc] init] width: 20] height: 20] comment: "just trying big"]];
		i++;
	}

	[Nodes nodesRandom: graph];

	edgeapply_click(NULL, NULL);

	[[graph get_navigation] set_lists: [graph nodeList]: [graph edgeList]];

	[app->drawarea queueDraw];
}

static void edgeapply_click(GtkButton *button, gpointer data) {
	[[graph edgeList] clear];
	const char *text = [app->generalbox->edgecombo activeText];
	if (g_strcmp0(text, "None") == 0)
		;
	if (g_strcmp0(text, "Circular") == 0)
		[Nodes edgesCircular: graph];
	else if (g_strcmp0(text, "Centered") == 0)
		[Nodes edgesCentered: graph];
	else if (g_strcmp0(text, "Interconnected") == 0)
		[Nodes edgesInterconnected: graph];
	else if (g_strcmp0(text, "Binary Tree") == 0)
		[Nodes edgesBinaryTree: graph];

	[[graph get_navigation] set_lists: [graph nodeList]: [graph edgeList]];

	[app->drawarea queueDraw];
}

static gboolean area_press(GtkWidget *widget, GdkEventButton *event, gpointer data) {
	Node *n = [graph getNodeByPos: event->x: event->y];
	if (event->button == 3)	{		/* right-click */
		if ([n locked] == YES)
			[n unlock];
		else
			[n lock];
	}
	else if (event->button == 1) {	/* dragging */
		drag_node = n;
		
		//if(n != NULL)
			//printf("Node Properties: %i, %i, %i, %i, %s\n", [n type], [n lineStyle], 
			//	[n lineColor], [n fillColor], [n comment]);
		
		if ([n selected])
			[n unselect];
		else
		{
			[n select];
			[[graph get_navigation] set_current_node: n];
		}
	}
	[app->drawarea queueDraw];
	return FALSE;
}

static gboolean area_release(GtkWidget *widget, GdkEventButton *event, gpointer data) {
	drag_node = NULL;
	return FALSE;
}

static gboolean area_motion(GtkWidget *widget, GdkEventMotion *event, gpointer data) {
	if (drag_node) {
		[[drag_node x: event->x] y: event->y];
		[app->drawarea queueDraw];
	}
	return FALSE;
}

static void scale_valuechanged(GtkRange *range, gpointer data) {
	scaling = [app->generalbox->scale value];
	[app->drawarea queueDraw];
}

static void wall_toggle(GtkToggleButton *toggle, gpointer data) {
	[graph wall: [app->walltog active]];
	[app->drawarea queueDraw];
}

static gboolean area_config(GtkWidget *widget, GdkEventConfigure *event, gpointer data) {
	[[graph width: [app->drawarea widget]->allocation.width]
			height: [app->drawarea widget]->allocation.height];
	[app->drawarea queueDraw];
	return FALSE;
}

static void save_click(GtkButton *button, gpointer data) {
	int w = [app->drawarea widget]->allocation.width;
	int h = [app->drawarea widget]->allocation.height;

	cairo_surface_t *surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, w, h);
	cairo_t *context = cairo_create(surface);
	cairo_set_source_rgb(context, 1.0, 1.0, 1.0);
	cairo_rectangle(context, 0, 0, w, h);
	cairo_fill(context);
	[graph expose: context];
	cairo_surface_write_to_png(surface, "graph.png");
	cairo_destroy(context);
	cairo_surface_destroy(surface);
}

