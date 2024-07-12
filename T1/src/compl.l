%option noyywrap yylineno
%{

// noyywrap    - no need to deal with multiple input files
// yylineno    - variable to track line numbers 
//               that copies otherwise unmatched input to yyout.

#include "token.h"

%}

%%


. 				{ return ERROR; }


%%


