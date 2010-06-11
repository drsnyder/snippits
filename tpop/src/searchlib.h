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

int addword(DictWord *newword, DictList *list);
void swap(DictWord * words, int a, int b);
void reverse(DictList list);
int load(char *path, DictList *list, int max);
void sort(DictList *list);
void display(DictList list);