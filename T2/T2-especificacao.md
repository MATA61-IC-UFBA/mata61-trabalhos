# compL 

+ [Aspectos Sintáticos](#aspectos-sintáticos)

---

## Aspectos Sintáticos

Um programa compL é uma sequência de declarações,
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
- A variável de tipo simples pode ser inicializada na declaração; nesse caso, o tipo declarado será seguido por '=', por um valor do tipo e por ';'.
- A definição do tipo estruturado "array" inicia-se pela 
palavra reservada ```array```,  seguida pelo seu 
tamanho (um valor do tipo integer entre colchetes) 
e pelo tipo base de seus elementos.
- A variável do tipo "array" pode ser inicializada na declaração; 
nesse caso, o tipo declarado será seguido por '=', 
por um sequência de valores (entre chaves e separados por vírgula) 
de um tipo simples, e por ';'.

#### Exemplos

```
x: boolean;
y: integer = 123;
z: boolean = false;
a: array [10] integer; 
b: array [3] boolean = {true,false,false};
```

### Declaração de função

O corpo de uma função é definido entre chaves '{' e '}'.
No corpo de uma função, pode-se declarar variáveis locais, 
incluindo do tipo array, com inicialização opcional e 
comandos.

Uma declaração de função em compL começa pelo seu nome,
seguido por ':', seguido pela palavra-chave ```function```, 
pelo tipo (ou _void_), 
por uma lista de parâmetros entre '(' e '), o símbolo '=' e
por um bloco ( _código entre {}_) -- o corpo da função.

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

- A declaração de um parâmetro do tipo array não deve indicar a dimensão do array 
entre '[' e ']': A dimensão, sempre um valor inteiro, deve ser representada como 
um parâmtro adiciomal (ver printarray).

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

### Blocos

Um bloco é um trecho de código entre chaves '{' e '}'
que define um novo _escopo_ (a ser discutido nos aspectos semânticos).
O trecho de código compL pode incluir declarações de variáveis locais  
e obrigatoriamente um ou mais comandos (ver função  _printarray_).
Declarações de variáveis devem preceder __todos__ os comandos do bloco.
Pode-se declarar variáveis locais a um bloco mas não funções.
Não há ';' (ponto-e-vírgula) após o símbolo '}'.

### Comandos

Comandos em _compL_ incluem
comando de atribuição, return, print, if, if-else, while
e chamadas de função.
Comandos básicos são separados por ';'.
No caso de if, if-else e while com blocos, 
não se deve colocar ';' após '}' (ver _printarray_ acima).

O comando _print_ não é considerado como chamada de função 
e recebe uma lista de expressões separadas por ','.

- Exemplo: ```print (temp, total);```

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

