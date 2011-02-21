#include <heaplib.h>
#include <assert.h>
#include <stdlib.h>

#define DATASIZE 10000 

void load_random_data(int * data, int n) {
    int i;
    for (i = 0; i < n; i++) {
        data[i] = random();
    }
}

int main(void) {

    int data[DATASIZE];
    int i;
    
    HeapObject one, prev;
    Heap heap;

    srandomdev();

    load_random_data(data, DATASIZE);

    for (i = 0; i < DATASIZE; i++) {
        /* printf("inserting data[%d] = %d\n", i, data[i]); */
        heap_insert(&heap, i, NULL, data[i], HEAP_ASC);
    }

    /* printf("\n"); */
    /* print_heap(heap, data); */
    /* printf("\n"); */

    prev.rank = -1;
    for (i = 0; i < DATASIZE; i++) {
        one = top(&heap, HEAP_ASC);
        printf("Sorted heap object (index=%5d, rank=%10d) data=%d\n", 
                one.index, one.rank, data[one.index]);
        if (prev.rank >= 0) {
            printf("\t%d <= %d ? %d\n", prev.rank, one.rank, prev.rank <= one.rank);
            assert(prev.rank <= one.rank && "heap sorted");
        }
        prev = one;
    }


    return 0;
}
