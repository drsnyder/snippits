#include <dictnodelist.h>
#include <tpop.h>

DictNode* new_dict_node(char * word) {
    DictNode *newnode = NULL;
    newnode = (DictNode*)malloc(sizeof(DictNode));
    newnode->word = strdup(word);
    newnode->next = NULL;
    return newnode;
}



DictNode* dict_node_addfront(DictNode *listp, DictNode *newp) {
    newp->next = listp;
    return newp;
}


void print_dict_node_list(DictNode *listp) {
    DictNode * lookat = NULL;
    int index = 0;
    for (lookat = listp; lookat != NULL; lookat = lookat->next) {
        fprintf(stdout, "[DictNode %d] %s\n", index++, lookat->word);
    }
}

DictNode* dict_node_reverse(DictNode *listp) {
    DictNode * lookat = NULL, * prev = NULL, * tmp = NULL;

    if (!listp->next) {
        return listp;
    }
    
    lookat = prev = listp;
    while (lookat != NULL) {
        tmp = lookat;
        lookat = lookat->next;
        tmp->next = prev;
        prev = tmp;
    }

    listp->next = NULL;
    return prev;
}


DictNode* dict_node_rreverse(DictNode *listp) {
    DictNode *next = NULL, *head = NULL;

    if (listp->next == NULL)
        return listp;

    next = listp->next;
    listp->next = NULL;
    head = dict_node_rreverse(next);
    next->next = listp;
    return head;
}



DictNode* dict_node_find(DictNode *listp, char * word) {
    int cmp = 0;

    if (listp == NULL)
        return NULL;

    for (; listp != NULL; listp = listp->next) {
        cmp = strcmp(listp->word, word);
        if (cmp == 0) {
            return listp;
        }
    }
        
    return NULL;
}


DictNode* dict_node_insert_after(DictNode *listp, char * word, DictNode * node) {
    DictNode* pos = NULL;
    pos = dict_node_find(listp, word);

    if (pos == NULL) {
        return NULL;
    }

    node->next = pos->next;
    pos->next = node;

    return listp;
}


DictNode* dict_node_insert_before(DictNode *listp, char * word, DictNode * node) {
    int cmp, i;
    DictNode * lookat = NULL;

    if (listp == NULL)
        return NULL;


    // case where word is found on the front
    cmp = strcmp(listp->word, word);
    if (cmp == 0) {
        node->next = listp;
        return node;
    }

    lookat = listp;
    for (; lookat->next != NULL; lookat = lookat->next) {
        cmp = strcmp(lookat->next->word, word);
        if (cmp == 0) {
            node->next = lookat->next;
            lookat->next = node;
            return listp;
        }
    }

    return NULL; // not found
}



void dict_node_apply(DictNode * listp, void (*fn)(DictNode *, void *), void * arg) {
    for (; listp != NULL; listp = listp->next) {
        (*fn)(listp, arg);
    }
}

void printdn(DictNode * p, void *arg) {
    char * fmt;
    fmt = (char *) arg;
    printf(fmt, p->value, p->word);
}

void dnlen(DictNode * p, void *arg) {
    int * len;
    len = (int *) arg;
    (*len)++;
}


