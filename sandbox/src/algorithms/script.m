
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
	printf ("Script Done\n");
	strcpy (tmp, command);
	strcat (tmp, "\0");

	char *temp = strtok (tmp, " ");
	if ( strcmp ( temp, "rectangle" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		char *temp2 = strtok (NULL, " ");
		char *temp3 = strtok (NULL, " ");
		char *temp4 = strtok (NULL, " ");
		printf ("All parameters\n");
		//drawhere
		Node *x = [[[[[[[Node alloc] init] 
				x: atoi(temp1)]
			       	y: atoi(temp2)]
			    width: atoi(temp3)]
			   height: atoi(temp4)]
			     type: RECTANGLE];

		[graph addNode: x];
	}
	else if ( strcmp ( temp, "circle" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		char *temp2 = strtok (NULL, " ");
		char *temp3 = strtok (NULL, " ");
		//drawhere
		Node *x = [[[[[[[Node alloc] init]
				x: atoi(temp1)]
				y: atoi(temp2)]
			    width: atoi(temp3)]
			   height: atoi(temp3)]
			     type: CIRCLE];
		[graph addNode: x];
	}
	else if ( strcmp ( temp, "square" ) == 0)
	{
		char *temp1 = strtok (NULL, " ");
		char *temp2 = strtok (NULL, " ");
		char *temp3 = strtok (NULL, " ");
		//drawhere
		Node *x = [[[[[[[Node alloc] init] 
				x: atoi(temp1)]
			       	y: atoi(temp2)]
			    width: atoi(temp3)]
			   height: atoi(temp3)]
			     type: SQUARE];

		[graph addNode: x];
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

	free (temp);
	printf ("Script Done\n\n");
}
@end

