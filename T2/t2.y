/* t2.y */

%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s, ...);
int yylex();
%}

/* your definitions */

%token ...


%%
program
: /* your definitions */
;


