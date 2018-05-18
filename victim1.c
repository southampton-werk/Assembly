//  victim1.c
//  vcvars64
 
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include <fcntl.h>
 
typedef void (*FUNCPTR)(); 

unsigned char buf[256];
 
int main(int argc, char **argv)
{
    FUNCPTR func;
    int fd, len;
    char *filename;
    DWORD oldProtect;
     if (argc == 2) {
        filename = argv[1];
    } else {
        fprintf(stderr, "usage: runbin <filename>\n");
        return EXIT_FAILURE;
    }
 
    fd = _open(filename, _O_RDONLY | _O_BINARY);
    if (-1 == fd) {
        perror("Error opening file");
        return EXIT_FAILURE;
    }
 
    len = _filelength(fd);
    if (-1 == len) {
        perror("Error getting file size");
        return EXIT_FAILURE;
    }      
 
    if (len != _read(fd, buf, len)) {
        perror("error reading from file");
        return EXIT_FAILURE;
    }
	fprintf(stderr, buf);
    func = (FUNCPTR)buf;
    func();
    return EXIT_SUCCESS;
}