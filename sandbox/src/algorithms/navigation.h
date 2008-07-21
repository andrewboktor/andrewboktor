
#import <objc/Object.h>
//#import "graph.h"
#import "node.h"
#import "list.h"
#import "edge.h"

@interface Navigation : Object {
@protected
	int current_edge;
	Node *current_node;
	List *graph_nodelist, *graph_edgelist;
	List *edgelist;
}

- init;
- free;

- (void) next_edge;

- (void) set_lists: (List *) nl: (List *) el;

- (Edge *) get_current_edge;

- (void) set_current_edge: (int) n;

- (void) generate_edge_list;

- (void) next_node;

- (void) set_current_node: (Node *) node;

- (int) get_node_index: (Node *) node;

- (void) unselect_all_edges;

- (void) unselect_all_nodes;
@end

