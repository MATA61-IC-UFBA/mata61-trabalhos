# compL 

+ [Aspectos Sintáticos](#aspectos-sintáticos)

---

## Aspectos Sintáticos

Um programa _compL_ é uma sequência de declarações,
sendo que cada declaração pode ser 
uma declaração de função
ou declaração de variável com inicialização opcional.
As declarações de variáveis devem preceder as declarações de função, ou seja,
a partir da primeira declaração de função,  novas declarações de variáveis
não são permitidas.
As declarações de função não podem ser aninhadas.

### Declaração de variável 

- Uma declaração de variável consiste de 
um identificador, seguido por ':', pelo seu tipo e por ';'.
O tipo pode ser simples (integer ou boolean) ou estruturado (array). 
Não há variável 'void'
- A variável de tipo simples pode ser inicializada na declaração; 
nesse caso, o tipo declarado será seguido por '=', por um valor do tipo e por ';'.
- A definição do tipo estruturado "array" inicia-se pela 
palavra reservada ```array```,  seguida pelo seu 
tamanho (um valor do tipo integer entre colchetes) 
e pelo tipo base de seus elementos.
- A variável do tipo ```array``` pode ser inicializada na declaração.
Nesse caso, a declaração de tipo  será seguida por '=', 
por um sequência de valores de um tipo simples
(entre chaves e separados por vírgula) e por ';'.

#### Exemplos

```
x: boolean;
y: integer = 123;
z: boolean = false;
a: array [10] integer; 
b: array [3] boolean = {true,false,false};
```

### Declaração de função

A declaração de uma função em compL inclui sua assinatura (protótipo),
seguida por um bloco de comandos.
A declaração começa pelo nome da função,
seguido por ':', seguido pela palavra-chave ```function```, 
pelo tipo (ou _void_), 
por uma lista de parâmetros entre '(' e '), o símbolo '=' e
por um bloco de comandos ( _código entre {}_) -- ou corpo da função.

- A função pode ter tipo atômico simples ou _void_ (ver printarray).
- A lista de parâmetros pode ser vazia, ou conter um ou mais parâmetros separados por ','
<!--
- A passagem de parâmetros do tipo integer é boolean é por valor, 
e para arrays é por referência.
-->
- A declaração de um parâmetro de tipo simples é similar a declaração de variável simples,
porém parâmetros não podem ser inicializados na declaração da função.

```
square: function integer ( x: integer ) = {
    return x*x;
}

```

- Um _parâmetro do tipo _array_  não deve indicar a dimensão do array 
entre '[' e ']'. Um parâmetro adicional para receber a dimensão do array,
sempre um valor inteiro, deve seguir o parâmetro di tipo array. 

```
// printarray com while

printarray: function void ( a: array [] integer, 
                            size: integer ) = 
{
    i: integer = 0;
    while (i<size) {
        print a[i]; 
        i = i + 1;
    }
} 

```

O corpo de uma função é definido como um bloco.
Pode-se declarar variáveis locais com inicialização opcional,
seguidas por comandos da linguagem.

### Blocos

Um _bloco_ é um trecho de código entre chaves '{' e '}'
que define um novo _escopo_ (a ser discutido nos aspectos semânticos).
O trecho de código _compL_ pode incluir declarações de variáveis locais  
e obrigatoriamente ao menos um comando (ver função  _printarray_).
Declarações de variáveis devem preceder __todos__ os comandos do bloco.
Pode-se declarar variáveis locais a um bloco mas não funções.
Não há ';' (ponto-e-vírgula) após o símbolo '}'.

### Comandos

Comandos em _compL_ incluem
comando de atribuição, return, print, if, if-else, while
e chamadas de função.
Comandos básicos são separados por ';'.
No caso de if, if-else e while com blocos, 
não se deve colocar ';' após o '}' (ver _printarray_ acima).

O comando _print_ não é considerado como chamada de função 
e recebe uma lista de expressões separadas por ','.

- Exemplo: ```print(temp, total);```

O comando _return_ inclui a palavra reservada ```return```
seguida por uma expressão _expr_ ou por ';'. 

- Exemplo: ```return ;```

### Expressões

_compL_ possui expressões aritméticas e relacionais, por exemplo,
```x + 10``` (retorna valor tipo inteiro) 
e ```x > 10``` (retorna valor do tipo booleano).

Vários operadores são semelhantes aos da  linguagem C, 
com o mesmo significado, associatividade e nível de precedência.
Atribuição é tratada como comando e não como expressão, ou seja,
```a = b = c``` é sintaticamente incorreta.

São operadores de _compL_, da maior para a menor precedência:

```
[] f()           // array, chamada de função
- !              // menos, not (operadores unários)
* /              // multiplicação, divisão
+ -              // adição, subtração
< <= > >= == !=  // comparação
```

Exemplo:

```b = a + 5 * c > 10``` corresponde a ```b = ((a + (5 * c)) > 10)```.

- Operadores "+, -, * e /" são associativos à esquerda, ou seja,
a expressão ```a + b + c``` é avaliada como ```(a + b) + c```;
- Operadores "<, <=, >, >=, == e !=" são _não-associativos_, ou seja,
```a > b > c``` é uma expressão sintaticamente incorreta.

Parênteses podem ser usados para contornar as regras de precedência
e associatividade de operadores.

Exemplo:

```b = (a + 5) * c > 10``` para realizar a soma antes da multiplicação.

__Dica__: ver as diretivas %nonassoc, %left, %right, %prec e 
como definir associatividade e precedência no _bison_.
---

### Créditos

Adaptado do material didático cedido pelo Prof. Vinicius Petrucci e 
do livro de D. Thain.

