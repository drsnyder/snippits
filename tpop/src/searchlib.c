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
        printf("DEBUG> grew list to %d\n", DLGROW * list->max);
        list->max *= DLGROW;
        list->words = newwords;
    }
    list->words[list->nval] = *newword;
    return list->nval++;
}

int load(char *path, DictList *list) {
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
        nlc = strchr(line, '\n');
        if (nlc != NULL)
            *nlc = '\0';

        printf("%-8d> %s\n", ++count, line);
        toadd = (DictWord *)malloc(sizeof(DictWord));
        if (toadd == NULL)
            return -1;

        toadd->word = strdup(line);
        toadd->index = count;
        addword(toadd, list);

        if (feof(fd)) {
            break;
        }
    }

    return 1;
}

void display(DictList list) {
    int i = 0;
    printf(">>> List has %d items max is %d <<<\n", list.nval, list.max);
    for (i = 0; i < list.nval; i++) {
        printf("%-8d> %s\n", list.words[i].index, list.words[i].word);
    }
}
