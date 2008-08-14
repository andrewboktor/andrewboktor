#import "widget.h"

@interface TextView: Widget {
}

- init;
- free;

- (void) setBuffer: (GtkTextBuffer *) buff;

- gtk_event: (Callback) cb: (gpointer) data;
/*
- (const char *) label;
- label: (const char *) lab;
- stock: (BOOL) set;
- onClicked: (Callback) cb: (gpointer) data;
*/
@end

