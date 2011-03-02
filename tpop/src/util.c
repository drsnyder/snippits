#include <util.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>

enum { BUFSIZE = 1024, MINLEN = 4 };


void eprintf(char *fmt,...) {
    va_list args;

    fflush(stdout);
    if (getprogname() != NULL)
        fprintf(stderr, "%s ", getprogname());

    va_start(args, fmt);
    vfprintf(stderr, fmt, args);
    va_end(args);

    if (fmt[0] != '\0' && fmt[strlen(fmt)-1] == ':')
        fprintf(stderr, " %s", strerror(errno));

    fprintf(stderr, "\n");
    exit(2);
}

void strings(char * name, int buf_size, int min_len, FILE *fin) {
    int c = 0, i = 0;
    char buf[BUFSIZE];

    /* do { */
    /*     for (i = 0; (c = getc(fin))) { */
    /*         if (isprint(c))  */
    /*             break; */
    /*         buf[i++] = c; */
    /*         if (i >= BUFSIZE) */
    /*             break; */
    /*     } */
    /*     if (i >= min_len) */
    /*         printf("%s:%.*s\n", name, i, buf); */
    /* } while (c != EOF); */
}
