#include <unistd.h>
#include <util.h>

extern char *optarg;
extern int optind;
extern int optopt;
extern int opterr;
extern int optreset;

// int getopt(int argc, char * const argv[], const char *optstring);

void usage(void) {

    exit(1);
}

int main(int argc, char* argv) {
    int i, min_len = MINLEN;
    FILE *fin;

    setprogname("strings"); 
    while ((ch = getopt(argc, argv, "hm:")) != -1) {
        switch (ch) {
            case 'h':
                usage();
                break;
            case 'm':
                min_len = atoi(optarg);
            default:
                usage();
        }
    } 
    argc -= optind;
    argv += optind;

    fprintf(stderr, "using min_len %d", min_len);


}
