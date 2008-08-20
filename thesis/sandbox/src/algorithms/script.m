
#import "script.h"
#import <node.h>
#import <point.h>
#import <stdlib.h>
#import <string.h>
#define DEBUG

#ifdef DEBUG
#import <stdio.h>
#endif

@implementation Script

- init {
	self = [super init];
	return self;
}

-free {
	return [super free];
}

+ (void) exec_file: (char *) URL: (Graph *) graph {
	char *filedata;
	if (g_file_get_contents (URL, &filedata, NULL, NULL) == TRUE)
	{
		[self exec_commands: filedata: graph];
	}
	else
	{
		printf ("Error opening file...\n");
	}

}

+ (void) exec_commands: (char *) commands: (Graph *) graph {
	
	char *commands_copy = malloc (sizeof (char) * strlen (commands) + 2);
	strcpy (commands_copy, commands);
	strcat (commands_copy, "\0");
	char *result = strtok( commands_copy, "\n" );
	GList *commands_list = g_list_alloc ();
	while ( result )
	{
		commands_list = g_list_append (commands_list, result);
		result = strtok (NULL, "\n");
	}
	commands_list = g_list_next (commands_list);
	while (commands_list)
	{
		printf ("%d\n", commands_list->data);
		[self exec_command: ((char *) commands_list->data): graph];
		commands_list = g_list_next (commands_list);
	}

	g_list_free (commands_list);
	free (commands_copy);
}

+ (void) exec_command: (char *) command: (Graph *) graph {
	printf ("Script running\n");
	char *tmp = malloc (sizeof (char) * strlen (command) + 2);
	
	strcpy (tmp, command);
	strcat (tmp, "\0");

	char *temp = strtok (tmp, " ");
	if ( strcmp ( temp, "new" ) == 0)
	{
		char *tmp_id = strtok (NULL, " ");
		printf ("%s\n", tmp_id);
		char *type = strtok (NULL, " ");
		printf ("%s\n", type);
		char *xpos = strtok (NULL, " ");
		printf ("%s\n", xpos);
		char *ypos = strtok (NULL, " ");
		printf ("%s\n", ypos);
		//drawhere
		Node *new_node = [[Node alloc] init];
		[new_node setnodeid: atoi(tmp_id)];
		[new_node x: atoi(xpos)];
		[new_node y: atoi(ypos)];
		
			    //setnodeid: tmp_id];
		if (strcmp (type, "rectangle") == 0)
		{
			[new_node type: RECTANGLE];
			[new_node width: 10];
			[new_node height: 10];
			//[new_node setnodeid: tmp_id];
		}
		else if (strcmp (type, "ellipse") == 0)
		{
			[[[new_node type: ELLIPSE]
			       width: 10]
			      height: 10];
			//[new_node setnodeid: tmp_id];
		}
		else if (strcmp (type, "triangle") == 0)
		{
			[[[new_node type: TRIANGLE]
			       width: 10]
			      height: 10];
			//[new_node setnodeid: tmp_id];
		}
		else if (strcmp (type, "note") == 0)
		{
			[[[new_node type: NOTE]
			       width: 10]
			      height: 10];
			//[new_node setnodeid: tmp_id];
		}
		printf ("Script Done\n");
		printf ("X IS %d\n",new_node );
		[graph addNode: new_node];
		
	}
	
	else if ( strcmp ( temp, "edit" ) == 0)
	{
		char *tmp_id = strtok (NULL, " ");
		Node *x = [graph getNodeByID: atoi(tmp_id)];
		
		char *prop = strtok (NULL, " ");
		
		if (strcmp (prop, "lc") == 0)
		{
			//to be done according to marly
		}
		else if (strcmp (prop, "fc") == 0)
		{
			//to be done according to marly
		}
		else if (strcmp (prop, "position") == 0)
		{
			char *xpos = strtok (NULL, " ");
			char *ypos = strtok (NULL, " ");
			[[x x:atoi(xpos)]
				y:atoi(ypos)];
		}
		else if (strcmp (prop, "size") == 0)
		{
			char *width = strtok (NULL, " ");
			char *height = strtok (NULL, " ");
			[[x width:atoi(width)]
				height:atoi(height)];
		}
		else if (strcmp (prop, "line") == 0)
		{
			//to be done according to marly
		}
	}
	else if ( strcmp ( temp, "connect" ) == 0)
	{
		
		char *add = strtok (NULL, " ");
		char *n1 = strtok (NULL, " ");
		char *n2 = strtok (NULL, " ");
		
		Node *nd1 = [graph getNodeByID: atoi(n1)];
		Node *nd2 = [graph getNodeByID: atoi(n2)];
		if (strcmp (add, "add")==0)
		{
			printf ("Adding Connection\n");
			Edge *e = [[[[Edge alloc] init] pointA: nd1] pointB: nd2];
			[graph addEdge: e];
		}
		else if (strcmp (add, "remove")==0)
		{
		}
	}
	else if ( strcmp ( temp, "ellipse" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		char *temp2 = strtok (NULL, " ");
		char *temp3 = strtok (NULL, " ");
		char *temp4 = strtok (NULL, " "); 
		//drawhere
		Node *x = [[[[[[[Node alloc] init] 
				x: atoi(temp1)]
			       	y: atoi(temp2)]
			    width: atoi(temp3)]
			   height: atoi(temp4)]
			     type: ELLIPSE];

		[graph addNode: x];
	}
	else if ( strcmp ( temp, "triangle" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		char *temp2 = strtok (NULL, " ");
		char *temp3 = strtok (NULL, " ");
		char *temp4 = strtok (NULL, " ");
		//drawhere
		Node *x = [[[[[[[Node alloc] init] 
				x: atoi(temp1)]
			       	y: atoi(temp2)]
			    width: atoi(temp3)]
			   height: atoi(temp4)]
			     type: TRIANGLE];

		[graph addNode: x];
	}
	else if ( strcmp ( temp, "note" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		char *temp2 = strtok (NULL, " ");
		char *temp3 = strtok (NULL, " ");
		char *temp4 = strtok (NULL, " ");
		char *temp5 = strtok (NULL, " ");
		//drawhere
		Node *x = [[[[[[[[Node alloc] init] 
				x: atoi(temp1)]
			       	y: atoi(temp2)]
			    width: atoi(temp3)]
			   height: atoi(temp4)]
			     type: NOTE]
			  comment: temp5];
		
		[graph addNode: x];
	}
	else if ( strcmp ( temp, "file" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		printf ("URL: %s\n", temp1);
		//drawhere
		[self exec_file: temp1: graph];
	}
	else if ( strcmp ( temp, "layout" ) == 0)
	{
		//drawhere
		
	}
	
	free (tmp);
	printf ("Script Done Totaly\n\n");
}
@end

