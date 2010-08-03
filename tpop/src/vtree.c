#include <vtree.h>

VTree *vtnewnode(void * object) {
    VTree *newp = NULL;
    newp = (VTree *)malloc(sizeof(VTree));
    newp->object = object;
    newp->left = NULL;
    newp->right = NULL;
    return newp;
}

VTree *vtinsert(VTree *treep, VTree * newp, int (*compare)(void *, void *)) {
    int cmp = 0;
    
    if (treep == NULL)
        return newp;

    cmp = (*compare)(treep->object, newp->object);
    if (cmp == 0) {
        // nothing, they are equal
    } else if (cmp < 0) { // new is greater than 
        treep->right = vtinsert(treep->right, newp, compare);
    } else {              // new is less than
        treep->left = vtinsert(treep->left, newp, compare);
    }

    return treep;
}


void vtapplyinorder(VTree *treep, void (*fn)(void *, void *), void *arg) {

    if (treep == NULL)
        return;

    vtapplyinorder(treep->left, fn, arg);
    (*fn)(treep->object, arg);
    vtapplyinorder(treep->right, fn, arg);
}

void vtapplypostorder(VTree *treep, void (*fn)(void *, void *), void *arg) {
    if (treep == NULL)
        return;

    vtapplyinorder(treep->left, fn, arg);
    vtapplyinorder(treep->right, fn, arg);
    (*fn)(treep->object, arg);

}


VTree * vtlookup(VTree *treep, void *o, int (*compare)(void *, void *)) {
    int cmp = 0;
    int * va = (int*)o;

    if (treep == NULL)
        return NULL;

    fprintf(stderr, "vtlookup %d \n", *va); 
    cmp = (*compare)(treep->object, o);
    if (cmp == 0) {
        return treep;
    } else if (cmp < 0) { // new is greater than 
        return vtlookup(treep->right, o, compare);
    } else {              // new is less than
        return vtlookup(treep->left, o, compare);
    }

    return NULL;
}

VTree * vtnrlookup(VTree *treep, void * o, int (*compare)(void *, void *)) {
}
