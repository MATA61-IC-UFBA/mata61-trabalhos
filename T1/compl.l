%option noyywrap yylineno

%{
#include "token.h"
%}

%%

"//".*            { }

[ \t\r\n]+        { } 

"array"            { return ARRAYT; }
"boolean"          { return BOOLEANT; }
"else"             { return ELSET; }
"false"            { return FALSET; }
"function"         { return FUNCTIONT; }
"if"               { return IFT; }
"integer"          { return INTEGERT; }
"print"            { return PRINTT; }
"return"           { return RETURNT; }
"true"             { return TRUET; }
"void"             { return VOIDT; }
"while"            { return WHILET; }

"=="               { return EQT; }
">="               { return GTET; }
"<="               { return LTET; }
"!="               { return NEQT; }

[0-9]+             { return NUM; }

[a-zA-Z][a-zA-Z0-9]* { return ID; }

\"                 { return ERROR; }

":"                { return ':'; }
";"                { return ';'; }
","                { return ','; }
"("                { return '('; }
")"                { return ')'; }
"{"                { return '{'; }
"}"                { return '}'; }
"="                { return '='; }

.                  { return ERROR; }

%%
