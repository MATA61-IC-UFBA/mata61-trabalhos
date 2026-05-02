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

A pasta de trabalho é `T2`. Usar apenas essa pasta.
Os principais arquivos na pasta T2 do repositório são
`t2.y`, `main.c` e `makefile`.

- Copiar o arquivo flex do trabalho T1 para a pasta T2
e renomear para ```t2.l```;
- Modificar `T2/t2.l` para integração com bison, se necessário;
- Escrever programa Bison `t2.y` para a linguagem compL seguindo a especificação de [compL](./T2-especificacao.md)
- Não modificar o arquivo `T2/main.c`;
- Não modificar o arquivo `T2/makefile`.

Você deve editar e modificar o arquivo `t2.y`
para especificar os tokens e regras de produção
para _compL_.

### Entrada

Um arquivo de entrada (com extensão `.in`),
contendo um programa fonte em _compL_.

Exemplo:

```
// main.in
main: function void () =
{
    a: integer;
    read(a);
    if (a <= 0)
       a = 1;
    print(a);
}
```

### Saída

O analisador sintático deve gerar um arquivo de saída (com extensão _.out_) 
contendo:

- "syntax error", em caso de erro sintático no programa de entrada, ou
- "no syntax errors".

## Como gerar `compl` executável localmente

A pasta de trabalho é `T2`. Usar apenas essa pasta.
Os principais arquivos na pasta T2 do repositório são
`t2.y`, `main.c` e `makefile`.

- Copiar o arquivo flex do trabalho T1 para a pasta T2 
e renomear para ```t2.l```;
- Modificar `T2/t2.l` para integração com bison, se necessário;
- Não modificar o arquivo `T2/main.c`;
- Não modificar o arquivo `T2/makefile`.
- 

Você deve editar e modificar o arquivo `t2.y`
para especificar os tokens e regras de produção
para _compL_.

Para rodar flex, bison e compilar:

```
make compile
```

## Como testar localmente

Para testar com todos os casos de teste definidos na pasta `tests` (extensão `.in`): 

```
make test
```

## Entrega

- Arquivo t2.l (programa flex) 
- Arquivo t2.y (programa Bison sem ações semânticas).

