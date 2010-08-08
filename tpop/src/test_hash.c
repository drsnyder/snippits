#include <hash.h>
#include <searchlib.h>
#include <assert.h>
#include <ctype.h>

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

char * strtolower(char * str) {
    int i = 0;
    char * ret = strdup(str);
    for (i = 0; i < strlen(str); i++) {
        ret[i] = tolower(str[i]);
    }

    return ret;
}



int main() {
    int h = 0, cmp = 0, ret = 0, i = 0;
    char * sorttest = NULL;
    DictNode * anags[NHASH];
    DictNode * th[17];
    DictNode * dp;
    DictList list;

    for (i = 0; i < 17; i++) {
        th[i] = NULL;
    }
    
    for (i = 0; i < NHASH; i++) {
        anags[i] = NULL;
    }

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
    assert((dp == NULL) && "lookup for 'damon' succeeded and shouldn't have");
    dp = lookup("damon", th, 1, 17);
    assert((dp != NULL) && "lookup for 'damon' failed on create");
    assert((strcmp("damon", dp->word) == 0) && "'damon' was not created");
    dp = lookup("damon", th, 0, 17);
    fprintf(stderr, "checking last test %d\n", dp); 
    assert((dp != NULL) && "lookup for 'damon' failed");


    strsort(sorttest, strlen(sorttest));
    assert(strcmp("eorssttt", sorttest) == 0 && "string was sorted");

    ret = load("/usr/share/dict/web2", &list, -1);
    assert(ret > 0 && "sucessfully loaded dictionary file");

    for (i = 0; i < list.nval; i++) {
        sorttest = strtolower(list.words[i].word);
        strsort(sorttest, strlen(sorttest));
        /* fprintf(stderr, "looking up %s\n", sorttest);  */
        dp = lookup(sorttest, anags, 1, NHASH);
        dp->value++;
    }

    for (i = 0; i < NHASH; i++) {
        if (anags[i] != NULL) {
            dict_node_apply(anags[i], printdn, "%d %-15s\n");
        }
    }

    return 0;
}
