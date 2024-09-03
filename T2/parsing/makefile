install:
	sudo apt-get install -f flex
	sudo apt-get install -f bison

compile:
	bison -d compl.y
	flex compl.l
	cc -o compl compl.tab.c lex.yy.c main.c

test:
	./run_tests.sh

all:
	make install
	make compile
	make test

clean:
	rm lex.yy.c
	rm compl.tab.h
	rm compl.tab.c


