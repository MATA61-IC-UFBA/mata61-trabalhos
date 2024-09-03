# Projeto de um Compilador

## Parte b)

- Trabalho T2 parte b): Análise Sintática com Construção de AST. Construção de um analisador sintático bottom-up para compL que gera representação na forma de AST para programas válidos.
Usar pasta AST.


Nesta parte do projeto, você irá implementar um analisador sintático 
_bottom-up_ para a linguagem compL com construção da árvore sintática abstrata (AST - Abstract Syntax Tree) para 
programas compL corretos.
O trabalho T2 parte b) inclui a implementação de um analisador sintático, construído com a ferramenta _Bison_, 
funções auxiliares para a construção da AST durante o processo de análise, 
uma função de _printAST_ para gerar uma representação externa para AST 
e o programa principal (detalhes a seguir).

<img src="./figs/ast-parsetree.png" width="400">

O analisador sintático gerado pelo Bison, _yyparse()_, deve receber uma sequência de _tokens_ 
enviados pelo analisador léxico _yylex()_, 
e determinar se um programa compL segue ou não a especificação definida por sua gramática.
Em caso de sucesso, 
o analisador sintático deve gerar uma AST para o programa de entrada analisado 
e disponibilizar uma referência para a raiz da AST construída, para ser usada pela função _printAST_ (fornecida no material).
Em caso de erro sintático detectado, 
apenas a mensagem de erro padrão do Bison (em inglês) deverá ser reportada e a análise sintática deve ser interrompida.

O código de funções auxiliares para a criação e manipulação da AST e
para a geração de uma representação usando a notação de 
_labelled bracketing_ para a AST retornada 
(explicada mais adiante) é fornecido na pasta /src.

Antes de iniciar a implementação do T2 em equipe, 
recomendamos a leitura dos capítulos 5 e 6 do livro 
"Introduction to Compilers and Language Design" de Douglas Thain
e o capítulo 3 do livro Flex&Bison.
Apesar da sintaxe de compL ser um pouco diferente da usada no livro de Thain, 
os exemplos de código e o material são úteis.
Recomendamos fortemente que os exercícios E5, E6 e E7 sejam resolvidos antes de começar o trabalho T2 parte b).

## Analisador sintático em Bison com Construção de AST

### Preparação: Usar a gramática para compL validada na Parte a) do trabalho.

- Usar o programa Bison com a gramática (src/compl.y) validada de Parte a) do trabalho como ponto de partida.
- Usar o programa Flex com a especificação Flex para compL usada na Parte a) do trabalho.


### Passos da Parte b) 

O código do _compL.l_ deverá ser atualizado para alinhá-lo com ações semânticas do programa Bison.
A nova versão de compl.l deve calcular o valor das constantes literais, por exemplo, NUMBER (tipo integer) com valor atribuído a yylval.d
e copiar o lexema de ID.

* Atenção: Ler sobre a variável yylval, YYSTYPE e %union no livro Flex&Bison.

#### Construção da AST

Incluir ações semânticas nas regras de produção para construir a AST ao longo da análise sintática ascendente.
Usar as estruturadas de dados e funções definidas no módulo ast.h/ast.c

#### Geração de representação externa para a AST

Usar a função _printAST_ fornecida.

## Notação para a Árvore Sintática Abstrata (Abstract Syntax Tree - AST)

Há diversas formas para representar árvores sintáticas corretas geradas para um programa sintaticamente válido.
Em nosso projeto de compilador, é importante definir e usar um formato único para representar
a AST, que seja independente de qualquer linguagem específica, seja fonte ou objeto.

Em nosso compilador, 
o analisador sintático construirá uma AST para programas sem erros léxicos e sem erros sintáticos.
Para mostrar a AST criada, 
a função _main_ deve chamar a função _printAST_, tendo como argumento a raiz da AST,
para percorrer e gerar uma representação da AST
na notação de _labelled bracketing_.

## Notação para representar AST

A notação de _labelled bracketing_
define listas aninhadas de _prefix expressions_ (operadores antes dos operandos), 
usando colchetes para organizá-las. Ela será usada para representar ASTs.

Por exemplo, a expressão ``` 2 * 7 + 3``` mostrada acima,
é representada como ```[+ [* [2] [7]] [3]]``` na notação de _labelled bracketing_.

Cada número inteiro NUMBER, é representado como ```[NUMBER]```, por exemplo, ```[2] e [7]```,
e a operação de multiplicação entre dois números, como ```[* [2] [7]]```.

__Formato Geral__:
```
[operator [operand1] ... [operandN]]
```

Recursivamente, cada operando pode conter outra operação, por exemplo,
```
[op1 [op2 [a] [b]] [c]]
```
onde o operador ```op1``` possui os operandos ```[op2 [a] [b]]``` e ```[c]```,
e o operador ```op2``` tem como operandos ```[a]``` e ```[b]```.

Assim, a AST para a expressão ``` 2 * 7 + 3```
deve ser representada como ```[+ [* [2] [7]] [3]]``` na notação de _labelled bracketing_.


<!--
### Listas de nós que podem ser mostrados na AST

Tipos de nós que podem aparecem em uma AST e seus nomes correspondentes,
que deverão ser produzidos pelo seu analisador sintático:

```[program  ... ]```

* ```[var-declaration  ... ]```
   * [int]                ---> nome do tipo
   * [ID]                 ---> nome de variável

* ```[var-declaration  ... ]```  ---> com inicialização

   * [int]                ---> nome do tipo
   * [ID]                 ---> nome de variável
   * [valor]              ---> valor de um literal 

IMPORTANTE: o símbolo de barra invertida (backslash \) é usado para não interpretar [ ou ] como nós de colchetes, e sim para serem símbolos visíveis na AST.

* ```[fun-declaration  ... ]```

   * [type] / [void]       ---> o nome do tipo retornado ou uso de void
   * [ID]                 ---> nome de função
   * [params  ...  ]      ---> gerar apenas [params], se não houver parâmetros na função
      * [param  ... ]     ---> (opcional) informação sobre parâmetro
         * [int]           ---> o tipo int
         * [ID]                 ---> nome de variável
   * ```[compound-stmt  ... ]```     ---> (opções de filhos abaixo)

####  Comandos compostos

* ```[;]```                       ---> comando vazio

* ```[selection-stmt ... ]```     ---> ou comando IF
   * ver EXPRESSION             ---> definição recursiva de qualquer expressão válida
   * [compound-stmt  ...]       --> ramo "then" (true)
   * [compound-stmt  ... ]      --> (opcional) ramo "else" (false)

* ```[iteration-stmt  ... ]```  --> apenas "while"
   * ver EXPRESSION              --> definição recursiva de qualquer expressão válida
   * [compound-stmt ... ]        --> bloco de comandos do while (statements)

* ```[return-stmt ... ]```
      * ver EXPRESSION           --> definição recursiva de qualquer expressão válida

* ```[print-stmt ...]```         ---> ver lista de argumentos

* ```[for-stmt ...] ```

* ```expression```


#### Expressões

* ```[OP ... ]```              --> operadores de expressão binária
  ```OP pode ser: +, -, *, /, <, <=, >, >=, ==, !=, =```

* ```[var  ... ]```      ---> uso de variável
   * [ID]
   * [NUM]             ---> uso de valor (literal) do tipo integer

* ```[call  ... ]```      ---> chamada (call) de função
   * [ID]
   * [args ... ]         ---> argumentos de função

* ```[OP ... ]```        ---> expressão binária ou unária

-->

## Bison e Flex

O Bison deverá ser utilizado para geração do analisador sintático,
trabalhando em conjunto com o analisador léxico modificado.
- Os tokens são definidos no arquivo _compl.y_, usando a diretiva ```%token```.

```$ bison -d compl.y```
```$ flex compl.l```

Compilar e gerar o executável chamado de _compl_. 

- As funções para criação e manipulação da AST estão nos arquivos _ast.c_ e _ast.h_.
- A função _main_ deve chamar uma função _printAST_
para geração de saída no formato _labelled bracket_ a partir da raiz de uma AST.
A função _main_ está definida em um arquivo C chamado de _main.c_.

O arquivo _makefile_ contém instruções para compilar os arquivos 
e gerar o executável _compl_. Para limpar os arquivos temporários,
use o comando ```make clean```.

### Como executar o analisador sintático

A função _main_  chama a função _yyparse()_ que, em caso de sucesso,
coloca o endereço da raiz da AST na variável _parser_result_, 
e chama a função _printAST_  para gerar a representação da AST 
na notação _labelled bracket_.
Em caso de erro sintático identificado, 
o mesmo será reportado pela função default do código Bison
e a análise interrompida, sem geração de AST.

Os testes estão disponíveis na pasta /tests do repositório.

Há scripts para rodar os testes localmente, antes de subir para o GitHub

## Exemplo simples

### Entrada

```
min: integer;
color: integer;
main: function void () {
   min = 1;
   color = 0; // red
}
```

### Saída

```
[program
  [var-declaration [integer][min]]
  [var-declaration [integer][color]]
  [fun-declaration
    [void]
    [main]
    [params]
    [compound-stmt
       [= [var [min]] [1]]
       [= [var [color]] [0]]
     ]
   ]
]
```

### Ilustração de AST gerada com a ferramenta 
[RSyntaxTree](https://yohasebe.com/rsyntaxtree/)

![AST](./figs/ast_rsyntax.png)

### Correção Automática

A correção automática do trabalho será feita com o apoio de _scripts_.
Desse modo, a correção irá considerar apenas os arquivos colocados 
no repositório GitHub da equipe,
com os nomes de arquivos indicados na especificação do trabalho.

### Outras Referências

Uma consulta interessante é uma [especificação yacc para ANSI C](https://www.lysator.liu.se/c/ANSI-C-grammar-y.html)
feita no século passado (década de 80).

--------
Parte deste material foi traduzido pela Prof. Christina von Flach a partir do livro de Douglas Thain e notas de aula do Prof. Vinicius Petrucci.

<!-- https://ruslanspivak.com/lsbasi-part1/ -->
<!-- https://stackoverflow.com/questions/52563185/does-c-add-0-when-you-pass-a-literal-string-as-an-argument-in-a-function -->
