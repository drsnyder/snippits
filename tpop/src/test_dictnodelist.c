#include <dictnodelist.h>
#include <assert.h>


void test_list_order(DictNode *listp, char *words[], int n) {
    int i = 0;
    if (listp == NULL) 
        assert(0 && "null list");
    
    for (i = 0; listp && i < n; i++) {
        fprintf(stderr, "test_list> testing word %s == %s: ", words[i], listp->word);
        assert((strcmp(words[i], listp->word) == 0) && "test failed"); 
        fprintf(stderr, "success \n"); 
        listp = listp->next;
    }
}

int main(void) {
    int length = 0;
    DictNode * list = NULL, * listp = NULL;
    char *words[] = {"dietrich", "damon", "alice", "alexis" };
    char *words_after[] = {"dietrich", "diydiy", "damon", "alice", "alexis" };
    char *words_before[] = {"dietrich", "diydiy", "damon", "nana", "alice", "alexis" };

    list = new_dict_node("alexis");
    list = dict_node_addfront(list, new_dict_node("alice"));
    list = dict_node_addfront(list, new_dict_node("damon"));
    list = dict_node_addfront(list, new_dict_node("dietrich"));
    print_dict_node_list(list);

    test_list_order(list, words, sizeof(words) / sizeof(char*));

    list = dict_node_reverse(list);
    print_dict_node_list(list);

    list = dict_node_rreverse(list);
    print_dict_node_list(list);

    test_list_order(list, words, sizeof(words) / sizeof(char*));

    listp = dict_node_find(list, "damon");
    assert(listp != NULL && "found 'damon'");
    assert((strcmp(listp->word, "damon") == 0) && "pos is in fact 'damon'");
    

    fprintf(stdout, "\n"); 
    listp = dict_node_insert_after(list, "dietrich", new_dict_node("diydiy"));
    assert((listp != NULL) && "insert succeded");
    test_list_order(list, words_after, sizeof(words_after) / sizeof(char*));
    print_dict_node_list(list);

    fprintf(stdout, "\n"); 
    listp = dict_node_insert_before(list, "alice", new_dict_node("nana"));
    assert((listp != NULL) && "insert succeded");
    test_list_order(listp, words_before, sizeof(words_before) / sizeof(char*));

    dict_node_apply(listp, printdn, "dn %s\n");
    dict_node_apply(listp, dnlen, &length);
    assert((length == 6) && "dnlen got the right count");

    return 0;
}
