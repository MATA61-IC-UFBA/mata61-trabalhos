%option noyywrap yylineno nodefault
%{
#include "blite.tab.h"
%}

%%

"//".*                      { /* no action */ }

void            { return VOID; }

[0-9]+           { return NUMBER; }

"+"		 { return yytext[0]; }

"<="       	 { return LTE; }

"("   		 { return yytext[0]; }

[ \t\r\n]        { /* no action */ }
.                { return ERROR; }

%%

