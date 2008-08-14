#import "container.h"

@interface Notebook: Container {
}

- init;
- free;

- (int) appendPage: (Widget *) child: (Widget *) label;
- tabPos: (GtkPositionType) pos;
- showBorder: (BOOL) val;

@end

