#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct VTree VTree;
struct VTree {
    void     * object;
    VTree * left;  // lesser
    VTree * right; // greater
};


struct STreeArray {
    int length;
    int current;
    int * elems;
};
typedef struct STreeArray StreeArray;

VTree *vtinsert(VTree *treep, VTree * newp, int (*compare)(void *, void *));
VTree *vtnewnode(void * object);

void vtapplyinorder(VTree *treep, void (*fn)(void *, void *), void *arg);
void vtapplypostorder(VTree *treep, void (*fn)(void *, void *), void *arg);

VTree * vtlookup(VTree *treep, void *o, int (*compare)(void *, void *));
VTree * vtnrlookup(VTree *treep, void *o, int (*compare)(void *, void *));

