#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>

#define MYPORT 9999    // the port users will be connecting to


#define BACKLOG 10     // how many pending connections queue will hold

int main (int argc, char *argv)
{
	int sockfd, new_fd;  // listen on sock_fd, new connection on new_fd
    struct sockaddr_in my_addr;    // my address information
    struct sockaddr_in their_addr; // connector's address information
    int sin_size;

    sockfd = socket(PF_INET, SOCK_STREAM, 0); // do some error checking!

    my_addr.sin_family = AF_INET;         // host byte order
    my_addr.sin_port = htons(MYPORT);     // short, network byte order
    my_addr.sin_addr.s_addr = INADDR_ANY; // auto-fill with my IP
    memset(my_addr.sin_zero, '\0', sizeof (my_addr.sin_zero));

    // don't forget your error checking for these calls:
    bind(sockfd, (struct sockaddr *)&my_addr, sizeof my_addr);

    listen(sockfd, BACKLOG);
	
	
    sin_size = sizeof their_addr;
    new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);

	
	void *buffer;
	recv(new_fd, buffer, 999, 0); 

	char *x = (char*)buffer;
	
	printf("%s", x);
}
