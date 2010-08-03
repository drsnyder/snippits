#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dictnodelist.h>

enum { MULTIPLIER = 37 };

unsigned int hash(char * str, int nhash); 
DictNode * lookup(char * name, DictNode ** table, int create, int nhash);
