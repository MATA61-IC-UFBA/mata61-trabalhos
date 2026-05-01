# Projeto e Implementação de um Compilador

- Parte 2 de 5
- Em dupla

## Trabalho 2 (T2): Análise Sintática

Construção de um analisador sintático bottom-up para a linguagem _compL_.

Nesta parte do projeto, você irá implementar um analisador sintático
para a linguagem de programação de alto nível [compL](./T2-especificacao.md).

O analisador sintático do trabalho T2 deve receber
uma sequência _tokens_ do analisador léxico, um a um, e retornar:

- "syntax error", em caso de erro sintático no programa de entrada, ou
- "no syntax errors".

## Atividades

- Copiar o analisador léxico feito em T1 (t1.l) para o arquivo t2.l e
fazer as alterações necessárias;
- Escrever programa Bison para a linguagem compL;
- Usar o programa principal fornecido em _main.c_ sem alterações.

### Entrada

Um arquivo de entrada (com extensão _.in_),
contendo um programa fonte em compL.

```
// main.in
main: function void () =
{
    a: integer;
    read(a);
    if (a <= 0)
       a = 1;
    print a;
}
```

### Saída

O analisador sintático deve gerar um arquivo de saída (com extensão _.out_) 
contendo:

- "syntax error", em caso de erro sintático no programa de entrada, ou
- "no syntax errors".


## Como gerar o analisador sintático executável

A pasta de trabalho é ```T2```. Usar apenas essa pasta.
Os arquivos na pasta T2 do repositório são
```t2.y``` e ```main.c```.

- Copiar o arquivo flex do trabalho T1 para a pasta T2 
e renomear para ```t2.l```;
- Modificar T2/t2.l para integração com bison, se necessário;
- Utilizar o arquivo T2/main.c (não modificar).

Você deve editar e modificar o arquivo ```t2.y```
para especificar os tokens e regras de produção
para _compL_.

- Rodar bison:

```
$ bison --defines=token.h --output=t2.c t2.y
```

- Rodar flex:

```
$ flex t2.l    # gera o arquivo lex.yy.c
```

e, em seguida, compilar e gerar executável:

```
cc -o compl lex.yy.c t2.c main.c
```

- ou:

```
make compile
```


## Entrega

- Arquivo t2.l (programa flex) 
- Arquivo t2.y (programa Bison sem ações semânticas).

