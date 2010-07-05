#include <quicksort.h>
#include <assert.h>

void fill_test_data(int v[], int n) {
    int i;

    srandomdev();
    for (i = 0; i < n; i++) {
        v[i] = random();
    }
}

int is_sorted(int v[], int n) {
    int i;
    for (i = 1; i < n; i++) {
        if (v[i - 1] > v[i]) {
            return 0;
        }
    }

    return 1;
}

enum { TEST_SIZE = 200000 };

int main(void) {
    int i, nums[TEST_SIZE];

    fill_test_data(nums, TEST_SIZE);

    fprintf(stderr, ">> 100 => %d\n", nums[99]);
    fprintf(stderr, ">> end => %d\n", nums[TEST_SIZE - 1]);

    assert(( is_sorted(nums, TEST_SIZE) == 0 ) && "test data is sorted");

    quicksort(nums, TEST_SIZE);
    assert(( is_sorted(nums, TEST_SIZE) == 1 ) && "test data is NOT sorted");

    for (i = 0; i < TEST_SIZE; i++) {
        if ((i % 100) == 0)
            fprintf(stderr, "nums[i] = %d\n", nums[i]);
    }

    return 0;
}
