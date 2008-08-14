#import "textview.h"

#define TC(w) GTK_TEXT_VIEW(w)

@implementation TextView

- init {
	if (self = [super init]) widget = gtk_text_view_new();
	return self;
}

- free {
	g_free(widget);
	return [super free];
}

- (void) setBuffer: (GtkTextBuffer *) buff {
	gtk_text_view_set_buffer (TC(widget), buff);
}

- gtk_event: (Callback) cb: (gpointer) data {
	g_signal_connect (G_OBJECT(widget), "key-press-event", G_CALLBACK(cb), data);
	return self;
}
/*
- (const char *) label {
	return gtk_button_get_label(TC(widget));
}

- label: (const char *) lab {
	gtk_button_set_label(TC(widget), lab);
	return self;
}

- stock: (BOOL) set {
	gtk_button_set_use_stock(TC(widget), set);
	return self;
}

- onClicked: (Callback) cb: (gpointer) data {
	g_signal_connect(G_OBJECT(widget), "clicked", G_CALLBACK(cb), data);
	return self;
}
*/
@end

