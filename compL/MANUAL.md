# compL 

+ [Aspectos Léxicos](#aspectos-léxicos)
+ Aspectos Sintáticos
+ Aspectos Semânticos

## Visão Geral

A linguagem compL é uma linguagem “pequena” usada para o ensino de compiladores em cursos de graduação. 
compL inclui expressões, fluxo de controle básico, funções recursivas e 
verificação de tipos. O código-objeto é compatível com C e, portanto, 
algumas bibliotecas C padrão podem ser usadas.
Entretanto, a sintaxe de declaração de tipos de compL é mais parecida com a da linguagem Pascal do que com a de C.

Descreveremos a linguagem através de exemplos, deixando para você ler com atenção, 
fazer perguntas no Discord e então construir incrementalmente as especificações formais necessárias 
para desenvolver os trabalhos do curso.

## Aspectos Léxicos

### 1. Caracteres de espacejamento (_whitespace_)

Os caracteres de espacejamento são _blank_ (' '), _newline_ ('\n'),  _tab_ ('\t') e _carriage return_ ('\r').

Os caracteres de espacejamento não têm papel significativo em programas compL e devem ser desconsiderados pelo analisador léxico.

- Exemplo 1: ```a=5;``` e  ```    a =  5;``` retornam tokens para ```a```, ```=```, ```5``` e ```;```, 
desconsiderando caracteres de espacejamento.

### 2. Comentários de uma linha

Apenas comentários de uma linha (_single-line comments_) são válidos. Comentários começam com ```//``` e se estendem até o final da linha.
Comentários devem ser desconsiderados pelo analisador sintático.

- Exemplo 2: ```a=5; // comentário no estilo C++```

### 3. Identificadores

Identificadores são usados como nomes de variáveis e funções. 
São compostos por letras maiúsculas e minúsculas, dígitos decimais e _underscores_.
Identificadores devem começar com uma letra e podem ter até 256 caracteres.
Caracteres maiúsculos e minúsculos em identificadores são diferenciados.

- Exemplo 3: ```i x9 x9_ my_str name4you  NomeCompleto```
- Exemplo 4: ```x9``` e ```X9``` são dois identificadores distintos.

### 4. Palavras-chave (_keywords_)

```
array  boolean  char else  false  for function  if
integer  print  return  string  true  void while
``` 

As palavras-chave, sempre escritas em letras minúsculas, são reservadas 
e não podem ser usadas como identificadores. 
 
- Exemplo 5: ```function``` é palavra reservada, porém  ```Function``` não é.

#### Uma observação sobre Tipos em L

Quatro palavras reservadas são usadas para representar tipos atômicos da linguagem:

```integer```, ```boolean ```, ```char``` e ```string```.
As palavras reservadas ```true``` e ```false``` são literais do tipo _boolean_.

A palavra reservada ```array``` é usada na declaração de arrays, único tipo estruturado da linguagem.

### 5. Símbolos especiais

#### Símbolos simples

```
  +  -  *  /  %  !  <  >  =  : ;  ,  (  )  [  ]  {  } \ 
```

#### Símbolos compostos

```
  <=  >=  ==  !=  &&  ||
```

### 6. Literais 

#### Tipo ```integer```

Uma constante inteira é uma sequência não-vazia de dígitos decimais.

#### Tipo ```boolean```

Há duas constantes válidas para o tipo ```boolean```: ```false``` e ```true```.

#### Tipo ```char```

Um valor do tipo ```char``` é um caractere entre aspas simples: ```'c'```

```\n``` (newline) e ```\0``` (null) podem aparecer entre aspas simples.
Para descrever o caractere ```'```, usar ```'\''```.
Um caractere não pode ser vazio, ou seja, ```''``` é um erro léxico.

Exemplos:
```
'a', 'b', '0', '+', '\n', '\0'
``` 

#### Tipo ```String```

Uma constante do tipo ```string``` é uma sequência de caracteres entre aspas duplas: ```"cadeia"``` 
Uma string pode conter os caracteres especiais ```\n``` (newline) e ```\0``` (null).
Uma string não pode continuar na próxima linha.
Uma string pode ser vazia: ```""```.

Exemplo:
```
print "execução finalizada.\n";
``` 


### Erros Léxicos

- símbolo inválido 

```?``` (caractere não é um símbolo válido)
```&``` (existe apenas o símbolo composto &&)

- caracter mal-formado: 
```''``` (nenhum caractere entre ' e ')

```'```  (apenas uma ')

- string mal-formada: 
```
"abc (final de linha)
def"
```

``` 
"abc (final de arquivo)
``` 


### Exemplos

```
x: integer;
y: integer = 123;
b: boolean = false;
c: char = 'c'; 
s: string = "Oi!\n";
```

```
x: integer = 65;
y: boolean = true;
if(x?0)  // símboloinválido
   print "x: ", x;
```

```
f: integer = 0;
if(f<100) ...  etc.
```

```
b: array [2] boolean = {true,false};
x: integer = 0;
s: string;
if(b[0]) x = x+1;     
s = "cadeia;      // cadeia mal-formada
print s;
```

```

main: function integer () = {
    i: integer = 10;
    while (i > 0) ... etc.  
}
```

```
c: char = 'a;    // caratere mal-formado
if (c=='a’) ... 
```

- Tanto um valor do tipo_char_ quanto uma cadeia do tipo _string_ podem conter _\n_ (valor ASCII 10) ou _\0_ (valor ASCII zero).

---

## Aspectos Sintáticos

TBD.

<!-- 
Um programa compL é uma sequência de declarações,
sendo que cada declaração pode ser declaração de função, declaração de protótipo de função ou declaração de variável global com inicialização opcional.

No corpo de uma função, pode-se declarar variáveis locais, incluindo do tipo array, com inicialização opcional.
As definições de função não podem ser aninhadas.

No corpo de uma função, comandos básicos incluem 
expressões aritméticas, comandos return, print, if, if-else, while, for
ou código entre chaves '{' e '}'.
Pode-se declarar variáveis locais a um bloco.


### Declaração de variável 

- Uma declaração de variável consiste de um identificador, seguido por ':', pelo seu tipo e por ';'.
O tipo pode ser simples (char, string, integer ou boolean) ou estruturado (array).
- A variável de tipo simples pode ser inicializada na declaração; nesse caso, o tipo declarado 
será seguido por '=', por um valor do tipo e por ';'.
- A definição do tipo estruturado "array" inicia-se pela palavra reservada ```array```, 
seguida pelo seu tamanho (um valor do tipo integer entre colchetes) 
e pelo tipo base de seus elementos.
- A variável do tipo "array" pode ser inicializada na declaração; nesse caso, o tipo declarado
será seguido por '=', por um sequência de valores (entre chaves e separados por vírgula) 
de um tipo simples, e por ';'.

#### Exemplos

```
x: boolean;
y: integer = 123;
z: boolean = false;
a: array [10] integer;  \\ elementos inicializados com 0
b: array [3] boolean = {true,false,false};
```

### Declaração de função

- Uma declaração de função em compL começa pelo seu nome,
seguido por ':', seguido pela palavra-chave ```function```, pelo tipo (atenção aqui), por uma lista de parâmetros entre '(' e '), o símbolo '=' e, por fim,
por _código dentro de grupos aninhados de {}_. 
- A função pode ter tipo atômico simples ou _void_ (ver printarray).
- A lista de parâmetros pode ser vazia, ou contem um ou mais parâmetros separados por ','
- A passagem de parâmetros do tipo integer, boolean ou char é por valor, e para arrays e strings, por referência.
- A declaração de um parâmetro de tipo simples é similar a declaração de variável simples.
- A declaração de um parâmetro do tipo array não deve indicar a dimensão do array (ver printarray).
- Parâmetros não podem ser inicializados na declaração da função

```
square: function integer ( x: integer ) = {
    return x*x;
}

```

```
printarray: function void
 ( a: array [] integer, size: integer ) = {
    i: integer = 0;
    while (i<size) {
        print a[i]; i = i + 1;
    }
} 

```

### Protótipo de função

O protótipo de uma função define a existência e o tipo da função, mas não inclui  código. Por exemplo, para chamar a  função C  _puts_ deve-se declarar seu protótipo:

```
puts: function void ( s: string );

main: function integer () = { 
  puts("oi mundo"); 
}
```

### Blocos

Um bloco é um trecho de código entre chaves '{' e '}' tratado como um comando composto.
O trecho de código compL pode incluir declarações de variáveis locais 
e um ou mais comandos (ver função  _printarray_).

### Comandos

Comandos básicos em compL incluem
expressões aritméticas, comandos return, print, if, if-else, while, for.
Comando composto é uma sequência de comandos básicos separados por ';'.

O comando _print_ não é considerado como chamada de função e recebe uma lista de expressões separadas por ','.

- Exemplo: ```print "The temperature is: ", temp, " degrees\n";```

### Expressões

compL possui vários operadores aritméticos encontrados na linguagem C, com o mesmo significado, associatividade e nível de precedência.
A seguir, listamos os operadores de compL, da maior para a menor precedência.


```
[] f()           // array, chamada de função
- !              // negação, not
* /  %            // multiplicação, divisão, resto
+ -              // adição, subtração
< <= > >= == !=  // comparação
&& ||            // e lógico, ou lógico
=                // atribuição

```
-->

--- 

## Aspectos Semânticos 

TBD.

<!--

B-Minor is strictly typed. This means that you may only assign a value to a variable (or function parameter) if the types match exactly. You can- not perform many of the fast-and-loose conversions found in C. For ex- ample, arithmetic operators can only apply to integers. Comparisons can be performed on arguments of any type, but only if they match. Logical operations can only be performed on booleans.


#### Tipos

- O tipo ```integer``` define constantes representadas como ``signed 64 bit```.
- O tipo ```boolean``` possui dois valores literais: _true_ e _false_.

- Arrays são estáticos, isto é, são criados com tamanho fixo e memória reservada; o tamanho não pode ser modificado depois.

- Se um array for declarado, sem valores atribuídos, assume-se que o mesmo foi inicializado com zeros.

``` a: array [5] integer; ```

- Na declaração de um array de tamanho N, pode-se inicializar o array com um conjunto de valores.

``` a: array [5] integer = {1,2,3,4,5}; ```

- Se um array for declarado, sem valores atribuídos, assume-se que o mesmo foi inicializado com zeros.

#### Função main


Um programa completo deve ter uma função chamada de ```main``` que retorna um valor inteiro. 
A lista de parâmetros de _main_ pode ser vazia ou usar ```argc``` 
e ```argv``` como em programas C. 

### Uma breve observação sobre Tipos em compL

- Um número do tipo _integer_ é um valor (_signed_) de 64 bits.
- Um elemento do tipo ```boolean``` pode assumir os valores literais _true_ ou _false_.
- Um valor do tipo ```char``` é um único caractere ASCII de 8 bits.
- Um valor do tipo ```string``` é uma cadeia constante entre aspas duplas, internamente terminada com nulo (\0). A cadeia não pode ser modificada. Diferentemente de C, uma _string_ não é um array de _char_ , é um tipo completamente separado.
- Tanto um valor _char_ quanto uma cadeia do tipo _string_ podem conter _\n_ (valor ASCII 10) e _\0_ para indicar nulo (valor ASCII zero). Uma barra invertida (_\_) seguida por qualquer outro caractere representa o próprio caractere. Tanto as strings quanto os identificadores podem ter até 256 caracteres.

- Arrays são de tamanho fixo.
```a: array [5] integer;```

Ou o array pode receber valores específicos:
```a: array [5] integer = {1,2,3,4,5};```

-->


-----

### Créditos

Adaptado do material didático cedido pelo Prof. Vinicius Petrucci e 
do livro de D. Thain.

<!--you must copy yytext before the lexer is called again if you need to preserve the token's string representation. -->
