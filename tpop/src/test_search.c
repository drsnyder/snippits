#include <searchlib.h>
#include <assert.h>

/* int lookup(char *name, Nameval tab[], int ntab) { */
/*     int low, high, mid, cmp; */
/*  */
/* } */

int reversed(DictList list) {
    int i = 0;
    int ret = 0;
    char * found_left = NULL;
    char * found_right = NULL;

    for (i = 1; i < list.nval; i++) {
        ret = strcasecmp(list.words[i - 1].word, list.words[i].word);
        found_left = strstr(list.words[i - 1].word, list.words[i].word);
        found_right = strstr(list.words[i].word, list.words[i - 1].word);


        if (ret < 0 && found_left != NULL && found_right != NULL) {
            fprintf(stderr, "ERROR, %d %s %s %s !> %s\n", ret, found_left, found_right, list.words[i - 1].word, list.words[i].word);
            return 0;
        }
    }

    return 1;
}

int main(void) {
    int ret = 0;
    DictList list;
    DictList listsmall;
    DictWord one;
    DictWord two;
    DictWord onep;
    DictWord twop;

    fprintf(stderr, ">>> testing load \n"); 
    ret = load("/usr/share/dict/web2", &list, -1);
    assert(ret > 0 && "sucessfully loaded dictionary file");

    fprintf(stderr, ">>> testing swap \n"); 
    one = list.words[1];
    two = list.words[2];
    swap(list.words, 1, 2);

    onep = list.words[2];
    twop = list.words[1];
    assert(( strcmp(one.word, onep.word) == 0 ) && "one not swapped");
    assert(( strcmp(two.word, twop.word) == 0 ) && "two not swapped");

    fprintf(stderr, ">>> testing reverse \n"); 
    reverse(list);
    assert(reversed(list) && "the list was not reversed");
    display(list);


    return 0;
}
