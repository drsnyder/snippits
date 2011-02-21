#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum { HEAP_INIT = 2, HEAP_GROW = 2, HEAP_ASC = 1, HEAP_DESC = 2 };

typedef struct HeapObject HeapObject;
struct HeapObject {
    int    index;
    char * key;
    int    rank;
};

typedef struct Heap Heap;
struct Heap {
    int nval;
    int max;
    HeapObject *objects;
};

void swap(Heap * heap, int a, int b);
int take(Heap heap, int n);

HeapObject top(Heap * heap, int direction);

HeapObject * heap_get(Heap heap, int n);
HeapObject * value(Heap heap, int n);
HeapObject * leftchild(Heap heap, int n);
HeapObject * rightchild(Heap heap, int n);
HeapObject * parent(Heap heap, int n);

void siftup(Heap * heap, int direction);
void siftdown(Heap * heap, int direction);

int heap_insert(Heap * heap, int index, char * key, int rank, int direction);
void print_heap(Heap heap, int * data);

