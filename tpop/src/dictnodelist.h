#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct DictNode DictNode;
struct DictNode {
    char     * word;
    DictNode * next;
};


DictNode* new_dict_node(char * word);
void print_dict_node_list(DictNode *listp);
DictNode* dict_node_addfront(DictNode *listp, DictNode *newp);

DictNode* dict_node_reverse(DictNode *listp);
DictNode* dict_node_rreverse(DictNode *listp);

// DictNode* dict_node_copy(DictNode *listp);
// DictNode* dict_node_merge(DictNode *a, DictNode *b);
// DictNode* dict_node_split(DictNode *listp, int pos);
DictNode* dict_node_find(DictNode *listp, char * word);
DictNode* dict_node_insert_before(DictNode *listp, char * word, DictNode * node);
DictNode* dict_node_insert_after(DictNode *listp, char * word, DictNode * node);

void dict_node_apply(DictNode * listp, void (*fn)(DictNode *, void *), void * arg);
void printdn(DictNode * p, void *arg);
void dnlen(DictNode * p, void *arg);

