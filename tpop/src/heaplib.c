#include <heaplib.h>
#include <tpop.h>

int heap_insert(Heap * heap, int index, char * key, int rank, int direction) {

    int i = 0, parent = 0;
    HeapObject * newly_allocated, * to_insert;

    to_insert = (HeapObject *) malloc(sizeof(HeapObject));
    if (to_insert == NULL)
        return -1;

    to_insert->index = index;
    to_insert->key   = key;
    to_insert->rank  = rank;

    if (heap->nval == 0) {
        // the  heap is currently empty
        heap->objects = (HeapObject *) malloc(HEAP_INIT * sizeof(HeapObject));

        if (heap->objects == NULL)
            return -1;

        heap->max = HEAP_INIT;

        heap->nval = 0;        

    } else if ((heap->nval + 1) >= heap->max) {
        newly_allocated = (HeapObject *)realloc(heap->objects, (HEAP_GROW * heap->max) * sizeof(HeapObject));

        if (newly_allocated == NULL)
            return -1;

        heap->max *= HEAP_GROW;
        heap->objects = newly_allocated;
    }

    heap->nval++;

    // insert the object being added at the leaf
    heap->objects[heap->nval] = *to_insert;
    
    // reshuffle at the leaf
    for (i = heap->nval; i > 1; i = parent) {
        parent = i / 2;
        if (heap->objects[parent].rank > heap->objects[i].rank) {
            swap(heap, parent, i);
        } else {
            break;
        }

    }

    return heap->nval;

}

HeapObject top(Heap * heap, int direction) {
    HeapObject top;
    int child = 0, i = 0;

    top = heap->objects[1];

    heap->objects[1] = heap->objects[heap->nval];
    heap->nval--;

    for (i = 1; (child = 2 * i) <= heap->nval; i = child) {
        if ((child + 1) <= heap->nval && heap->objects[child + 1].rank < heap->objects[child].rank) 
            child++;

        if (heap->objects[child].rank < heap->objects[i].rank) {
            swap(heap, child, i);
        } else {
            break;
        }
    }

    return top;
}


void swap(Heap * heap, int a, int b) {

    HeapObject tmp;
    int i = 0;

    tmp = heap->objects[a];
    heap->objects[a] = heap->objects[b];
    heap->objects[b] = tmp;
}

void siftup(Heap * heap, int direction) {

    int i = heap->nval, parent = 0;

    while(1) {

        if (i == 1)
            break;

        parent = i / 2;

        if (heap->objects[parent].rank <= heap->objects[i].rank) 
            break;

        swap(heap, parent, i);

        i = parent;
    }

}

void siftdown(Heap * heap, int direction) {
    int i, child;

    i = 1;
    while (1) {
        child = 2 * i;

        if (child > heap->nval) 
            break;

        // child is the left child of nval
        if (child + 1 <= heap->nval)
            // child + 1 is the right child of nval
            if (heap->objects[child + 1].rank < heap->objects[child].rank) 
                child++;

        // child is the lesser child of i
        if (heap->objects[i].rank <= heap->objects[child].rank)
            break;

        swap(heap, child, i);

        i = child;
    }

}



HeapObject * value(Heap heap, int n) {
    if (n > heap.nval || n == 0)
        return NULL;

    return &heap.objects[n];
}

HeapObject * rightchild(Heap heap, int n) {
    int ri = 2 * n + 1;
    if (ri > heap.nval || ri == 0)
        return NULL;

    return &heap.objects[ri];
}

HeapObject * leftchild(Heap heap, int n) {
    int li = 2 * n;
    if (li > heap.nval || li == 0)
        return NULL;

    return &heap.objects[li];
}

HeapObject * heap_get(Heap heap, int i) {
    if (i > heap.nval || i == 0)
        return NULL;

    return &heap.objects[i];

}

void print_heap(Heap heap, int * data) {
    int i = 1;

    for (i = 1; i <= heap.nval; i++) {
        printf("Heap object at location %5d (index=%5d, rank=%10d) data=%d\n", i, heap.objects[i].index, heap.objects[i].rank, data[heap.objects[i].index]);
    }
}
