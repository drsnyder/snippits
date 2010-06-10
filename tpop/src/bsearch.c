#include <searchlib.h>


/* int lookup(char *name, Nameval tab[], int ntab) { */
/*     int low, high, mid, cmp; */
/*  */
/* } */

int main(void) {
    DictList list;

    load("/usr/share/dict/web2", &list, -1);
    display(list);

    return 0;
}
