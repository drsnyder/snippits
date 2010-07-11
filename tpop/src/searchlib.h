#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct DictWord DictWord;
struct DictWord {
    char * word;
    int    index;
};

typedef struct DictList DictList;
struct DictList {
    int nval;
    int max;
    DictWord *words;
};

void swap(DictWord * words, int a, int b);
void dlqsort(DictList list);
int dlsearch(DictList list, char * word);

void reverse(DictList list);

int load(char *path, DictList *list, int max);
int addword(DictWord *newword, DictList *list);
int delword(char * word, DictList *list);

void display(DictList list);
