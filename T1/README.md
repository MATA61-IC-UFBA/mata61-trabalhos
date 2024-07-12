# Projeto e Implementação de um Compilador.


## Trabalho 1 (T1): Análise Léxica

Nesta parte do projeto, você irá implementar um analisador léxico
para a [linguagem de alto nível compL](../compL/MANUAL.md).

O analisador léxico do trabalho T1 deve receber como entrada
um programa fonte na linguagem compL e retornar um sequência _tokens_,
um a um, cada _token_ anotado com as seguintes informações:
- classe do _token_ (identificador, constante inteira, símbolo, etc)
- lexema do _token_ (cadeia de caracteres),
no caso de identificadores e constantes literais.

Se uma entrada incorreta for encontrada, o analisador léxico
deve retornar o token __ERROR__.
O analisador léxico deve reportar todos os erros léxicos presentes
no programa fonte analisado, ou seja, após identificar e reportar o erro,
a análise léxica deve prosseguir até o final do programa fonte.

## Classes de _tokens_

Em sua implementação do analisador léxico, considere as seguintes classes de _tokens_ da linguagem compL:

__ID__     Identificador

__NUM__    Literal decimal (inteiro)

__STR__    Literal string  (cadeia entre aspas duplas)

__CHAR__   Literal caractere  (caractere entre aspas simples)

__KEY__    Keyword (palavra-chave)

__SYM__    Símbolo especial simples

__SYMC__   Símbolo especial composto

__ERROR__  Erro léxico

## Entrada

O analisador léxico deverá ler um arquivo de entrada (com extensão _.in_),
contendo um programa fonte em compL.

```
// main.in
main: function integer () =
{
    a: integer;
    read(a);
    if (a <= 0)
       a = 1;
    print "saida: ", a;
}
```

## Saída 

O analisador léxico deve gerar um arquivo de saída (com extensão _.out_).
Para cada chamada do analisador léxico, a saída deve mostrar
uma tripla entre parênteses, sendo um _token_ por linha:

```(line_num,token_class,"lexeme") ``` (_lexeme_ entre aspas)

onde 
- ```line_num``` é o número da linha no arquivo de entrada
em que  _token_ aparece,
-  ```token_class``` é a classe do _token_ válido ou __ERROR__, no caso de erro léxico, e
- ```lexeme``` é o lexema disponibilizado pelo Flex (variável _yytext_),
reportado na saída entre aspas duplas (mesmo para literais string e char).

Para o programa fonte _main.in_ (acima),
a saída gerada em _main.out_ será:

```
(2,ID,"main")
(2,SYM,":")
(2,KEY,"function")
(2,KEY,"integer")
(2,SYM,"(")
(2,SYM,")")
(2,SYM,"=")
(3,SYM,"{")
(4,ID,"a")
(4,SYM,":")
(4,KEY,"integer")
(4,SYM,";")
(5,ID,"read")
(5,SYM,"(")
(5,ID,"a")
(5,SYM,")")
(5,SYM,";")
(6,KEY,"if")
(6,SYM,"(")
(6,ID,"a")
(6,SYMC,"<=")
(6,NUM,"0")
(6,SYM,")")
(7,ID,"a")
(7,SYM,"=")
(7,NUM,"1")
(7,SYM,";")
(8,KEY,"print")
(8,STR,""saida: "")
(8,SYM,",")
(8,ID,"a")
(8,SYM,";")
(9,SYM,"}")
```

## Como gerar o seu analisador léxico executável

Os arquivos na pasta T1/_src_ do repositório são
```compl.l```, ```token.h``` e ```main.c```.
Você só deve editar e modificar o arquivo _compl.l_
para especificar seus padrões regulares e ações para
a análise léxica de programas escritos em _compL_.

Na pasta ```src````:
```
$ flex compl.l    # gera o arquivo lex.yy.c
```
e, em seguida:

```
cc -o compl lex.yy.c main.c
```

O script ```compile.sh''' realiza estes dois passos e copia o executável
para fora da pasta ```src````. Bastar rodar:
```
./compile.sh
```
ou
```
make compile
```

## Como executar

O nome do analisador léxico (executável) deve ser _compl_.
O programa _compl_ deve ler a entrada a partir de um arquivo
(sugestão: usar extensão _.in_) 
e escrever a saída em outro arquivo 
(sugestão: usar mesmo nome de arquivo, mas com extensão _.out_).


```
$ ./compl exemplo.in exemplo.out
```

O arquivo de saída deve conter uma sequência de triplas.

## Como testar

Use o script ```run_tests.sh``` para testar seu analisador léxico.
Alguns testes são fornecidos, ou seja, programas em compL com extensão ```.in``` 
(ver pasta ```tests/inputs```), e o oráculo (ver pasta ```tests/oracle```).
A saída gerada por seu analisador léxico será colocada em ```tests/outputs```.

```
$ ./run_tests.sh  # comando para rodar os casos de testes em /tests
```

## Entrega

A entrega do T1 deve ser feita no repositório 
criado pelo GitHub Classroom, via Pull Request.

- O arquivo ```T1/src/compl.l``` deverá ser modificado para incluir sua solução. Apenas este arquivo será considerado na correção de T1.
- _Não_ modificar outros arquivos ou incluir arquivos novos na pasta _src_.

