%{
#include <stdio.h>
#include <stdlib.h>
#include "decl.h"
#include "param_list.h"
#include "expr.h"
#include "type.h"
#include "stmt.h"

/* interface to lexer */

extern int yylineno; /* from lexer */
void yyerror(const char *);
int yylex();

struct decl *parser_result;

%}

%token VOID
%token PLUS
%token NUMBER

/* etc */

%%

program
: declarations
; 

declarations
: declaration 
| declarations declaration 
;

declaration
: func_declaration
| var_declaration
;

basic_type
: INTEGER
| BOOLEAN
;

void_type
: VOID
;

func_declaration
: ID ':'  FUNCTION basic_type '(' params ')' '='
block
| ID ':'  FUNCTION void_type '(' params ')' '='
block
;

params
: /* empty */
| param_list
;

param_list
: parameter
| param_list ',' parameter
;

/* var-declaration etc. */

block
: '{' local_declarations statements '}' 
| '{' statements '}' 
;

/* statements etc. */

statement
: expression_statement
: if_statement 
| /* etc */
| block
;

expression_statement
: expression ';'
;

/* assignment, relational expressions, etc */

additive_expression
: additive_expression '+' term 
: additive_expression '-' term 
| term
;

/* term  */

factor
: call
| '(' expression ')'
/* etc */
;

call
: ID '(' args ')'
;;

args
: /* empty */ 
| args_list
;

args_list
: args_list ',' expression
| expression
;

%%

void yyerror(const char *s) {
   fprintf(stderr, "%s\n", s);
}

