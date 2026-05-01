install:
	sudo apt-get install -f flex
	sudo apt-get install -f bison

compile:
	bison --defines=token.h --output=t2.c t2.y
	flex t2.l
	cc -o compl t2.c lex.yy.c main.c

test:
	./run_tests.sh

all:
	make install
	make compile
	make test

clean:
	rm lex.yy.c
	rm t2.c
	rm token.h
	rm compl

