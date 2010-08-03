#include <hash.h>
#include <assert.h>

enum { NHASH = 3571 };
void cswap(char * str, int a, int b) {
    char tmp;
    tmp = str[a];
    str[a] = str[b];
    str[b] = tmp;
}

void strsort(char * str, int len) {
    int last = 0, i = 0;

    if (len == 0)
        return;

    cswap(str, 0, random() % len);
    for (i = 1; i < len; i++) {
        if (str[i] < str[0]) {
            cswap(str, ++last, i);
        }
    }

    cswap(str, 0, last);
    strsort(str, last);
    strsort(str+last+1, len-last-1);
}




int main() {
    int h = 0, cmp = 0, ret = 0, i = 0;
    char * sorttest = NULL;
    DictNode * anags[NHASH];
    DictNode * th[17];
    DictNode * dp;
    
    sorttest = strdup("sorttest");

    h = hash("damon", 37);
    fprintf(stdout, "%s %u\n", __FUNCTION__, h); 
    h = hash("da", 17);
    fprintf(stdout, "%s %u\n", __FUNCTION__, h); 
    h = hash("x\"33", 17);
    fprintf(stdout, "%s %u\n", __FUNCTION__, h); 
    h = hash("x3\"3", 17);
    fprintf(stdout, "%s %u\n", __FUNCTION__, h); 

    dp = lookup("damon", th, 0, 17);
    assert((dp == NULL) && "lookup for 'damon' failed as expected");
    dp = lookup("damon", th, 1, 17);
    assert((dp != NULL) && "lookup for 'damon' succeeded as expected");
    assert((strcmp("damon", dp->word) == 0) && "'damon' was created");
    dp = lookup("damon", th, 0, 17);
    assert((dp != NULL) && "lookup for 'damon' succeeded as expected");



    strsort(sorttest, strlen(sorttest));
    assert(strcmp("eorssttt", sorttest) == 0 && "string was sorted");

    /* ret = load("/usr/share/dict/web2", &list, -1); */
    /* assert(ret > 0 && "sucessfully loaded dictionary file"); */

    /* for (i = 0; i < list.nval; i++) { */
    /* } */

    return 0;
}
