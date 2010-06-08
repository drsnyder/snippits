#include <searchlib.h>
#include <assert.h>

/* int lookup(char *name, Nameval tab[], int ntab) { */
/*     int low, high, mid, cmp; */
/*  */
/* } */

int main(void) {
    int ret = 0;
    DictList list;

    ret = load("/usr/share/dict/web2", &list);
    assert(ret > 0 && "sucessfully loaded dictionary file");

    return 0;
}
