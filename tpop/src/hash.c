#include <hash.h>

unsigned int hash(char * str, int nhash) {
    unsigned int h = 0;
    unsigned char *p = NULL;

    for (p = (unsigned char *)str; *p != '\0'; p++) {
        h = MULTIPLIER * h + *p;
    }

    return h % nhash;
}


DictNode * lookup(char * name, DictNode ** table, int create, int nhash) {
    int h;
    DictNode * dnp;

    h = hash(name, nhash);
    /* fprintf(stderr, "lookup> hash %d for name %s\n", h, name);  */
    dnp = dict_node_find(table[h], name);

    if ((dnp == NULL) && create) {
        dnp = new_dict_node(name);
        table[h] = dict_node_addfront(table[h], dnp);
    }

    return dnp;
}

