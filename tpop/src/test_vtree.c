#include <vtree.h>
#include <assert.h>

int * new_object(int val) {
    int * new = NULL;
    new = (int*)malloc(sizeof(int));
    (*new) = val;
    return new;
}

int int_compare(void * a, void * b) {
    int * va = (int*)a, * vb = (int*)b;
    
    if ((*va) > (*vb)) {
        return 1;
    } else if ((*va) < (*vb)) {
        return -1;
    } else {
        return 0;
    }
}

void inccounter(void * c, void * arg) {
    int * count = (int *)arg;
    (*count) = (*count) + 1;
}

void vt_int_print(void * o, void * arg) {
    int * value = (int *)o;
    char * fmt = (char *)arg;

    printf(fmt, (*value));
}

void vt_to_array(void * o, void * arg) {
    int * value = (int *)o;
    int i = 0;
    struct STreeArray * stap = (struct STreeArray *)arg;
    stap->elems[stap->current++] = (*value);
}


int main(void) {
    int * value;
    int i = 0;
    int count = 0;
    VTree * treep = NULL;
    VTree * treept = NULL;
    struct STreeArray * stap = NULL;

    for (i = 0; i < 10; i++) {
       value = new_object(random());
       printf("adding %d\n", *value);
       treep = vtinsert(treep, vtnewnode(value), int_compare);
       assert((treep != NULL) && "inserted object");
    }

    // sort
    vtapplyinorder(treep, vt_int_print, "n %d\n");

    // count
    vtapplyinorder(treep, inccounter, &count);
    assert((count == 10) && "count is 10");

    // sort to array
    stap = (struct STreeArray *)malloc(sizeof(struct STreeArray));
    stap->length = count;
    stap->current = 0;
    stap->elems = (int *)malloc(sizeof(int) * count);

    // sort
    vtapplyinorder(treep, vt_to_array, stap);
    for (i = 1; i < stap->length; i++) {
        assert(( stap->elems[i - 1] < stap->elems[i] ) && "not sorted");
    }

    // search
    treept = vtlookup(treep, &stap->elems[5], int_compare);
    assert(treept != NULL && "found something");
    value = (int*)treept->object;
    assert((*value == stap->elems[5]) && "found the element");

    printf("doing post order\n");
    vtapplypostorder(treep, vt_int_print, "n %d\n");

    return 0;
}
