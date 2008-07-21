#import "notebook.h"

#define TC(w) GTK_NOTEBOOK(w)

@implementation Notebook

- init {
	if (self = [super init]) widget = gtk_notebook_new();
	return self;
}

- free {
	g_free(widget);
	return [super free];
}

- (int) appendPage: (Widget *) child: (Widget *) label {
	return gtk_notebook_append_page(TC(widget), [child widget], [label widget]);
}

- tabPos: (GtkPositionType) pos {
	gtk_notebook_set_tab_pos(TC(widget), pos);
	return self;
}

- showBorder: (BOOL) val {
	gtk_notebook_set_show_border(TC(widget), val);
	return self;
}

@end

