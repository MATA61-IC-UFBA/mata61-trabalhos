/* main.c */

#include <stdio.h>
#include <stdlib.h>

extern int yyparse();

int main(int argc, char **argv) {

    extern FILE *yyin;
    extern FILE *yyout;

    if (argc > 2) {
        if(!(yyin = fopen(argv[1], "r"))) {
            fprintf(stderr,"Erro na abertura do arquivo de entrada %s\n",argv[1]);
            return (1);
        }
        if(!(yyout = fopen(argv[2], "w"))) {
            fprintf(stderr,"Erro na criacao do arquivo de saida %s\n",argv[2]);
            return (1);
        }
    }
    else {
        fprintf(stderr,"Erro no número de argumentos passados para o analisador\n");
        return (1);
    }

//    fprintf(stderr,"Finished compilation with compl parser.\n");

    if (!yyparse()) {
        fprintf(yyout,"no syntax errors\n");
    }
    else
        fprintf(yyout,"syntax error\n");
    fclose(yyout);
}


void yyerror(char *s, ...)
{
    fprintf(stdout,"%s\n", s);
}
