#include <stdio.h> 
#include <stdlib.h> 
#include "compl.tab.h"

/* parser */

int yyparse();


int main()
{
    if (yyparse()
	fprintf(stderr, "syntax error\n");

    exit(0);
}


