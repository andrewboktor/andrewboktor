
#import <objc/Object.h>
#import "graph.h"
#import "node.h"
#import "list.h"
#import "edge.h"

@interface Script : Object {
@protected
	int current_edge;
	Node *current_node;
	List *graph_nodelist, *graph_edgelist;
	List *edgelist;
}

- init;
- free;

+ (void) exec_file: (char *) URL: (Graph *) graph;
+ (void) exec_commands: (char *) commands: (Graph *) graph;
+ (void) exec_command: (char *) command: (Graph *) graph;

@end

