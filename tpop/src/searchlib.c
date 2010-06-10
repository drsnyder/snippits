#include <searchlib.h>
#include <tpop.h>

enum { DLINIT = 1, DLGROW = 2 };

int addword(DictWord *newword, DictList *list) {

    DictWord *newwords;
    if (list->nval == 0) {
        list->words = (DictWord *) malloc(DLINIT * sizeof(DictWord));
        if (list->words == NULL)
            return -1;
        list->max = DLINIT;
        list->nval = 0;
    } else if (list->nval >= list->max) {
        newwords = (DictWord *)realloc(list->words, (DLGROW * list->max) * sizeof(DictWord));
        if (newwords == NULL)
            return -1;
        list->max *= DLGROW;
        list->words = newwords;
    }
    list->words[list->nval] = *newword;
    return list->nval++;
}


void swap(DictWord * words, int a, int b) {
    DictWord tmp;

    tmp = words[a];
    words[a] = words[b];
    words[b] = tmp;
}

int load(char *path, DictList *list, int max) {
    char line[256];
    char * nlc;
    int count = 0;
    FILE * fd = NULL;
    DictWord * toadd = NULL;


    fd = fopen(path, "r");
    if (fd == NULL) {
        return 0;
    }

    while (fgets(line, 255, fd)) {
        count++;
        nlc = strchr(line, '\n');
        if (nlc != NULL)
            *nlc = '\0';

        toadd = (DictWord *)malloc(sizeof(DictWord));
        if (toadd == NULL)
            return -1;

        toadd->word = strdup(line);
        toadd->index = count;
        addword(toadd, list);
        /* printf("%-8d> %s\n", list->nval, line); */
        if (max > 0 && count >= max) {
            break;
        }

        if (feof(fd)) {
            break;
        }
    }

    return 1;
}

void reverse(DictList list) {
    int i = 0;
    for (i = 0; i < ( list.nval / 2 ); i++) {
        fprintf(stderr, "R> swapping %d <=> %d (total %d)\n", 
                i, list.nval - i, list.nval);
        swap(list.words, i, list.nval - i - 1);
    }
}

void sort(DictList *list) {

}

void display(DictList list) {
    int i = 0;
    printf(">>> List has %d items max is %d <<<\n", list.nval, list.max);
    for (i = 0; i < list.nval; i++) {
        printf("%-8d> %s\n", list.words[i].index, list.words[i].word);
    }
}
