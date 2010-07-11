
void iswap(int v[], int a, int b) {
    int tmp;
    tmp = v[a];
    v[a] = v[b];
    v[b] = tmp;
}

void quicksort(int v[], int n) {
    int i, last;

    if (n <= 1)
        return;

    iswap(v, 0, random() % n);

    last = 0;
    for (i = 1; i < n; i++) {
        if (v[i] < v[0]) {
            iswap(v, ++last, i);
        }
    }
    iswap(v, 0, last);              // restore pivot
    quicksort(v, last);            // front set
    quicksort(v+last+1, n-last-1); // back set
}

