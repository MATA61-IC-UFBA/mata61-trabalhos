install:
	sudo apt-get install -f flex
	sudo apt-get install bison

compile:
	./compile_parser.sh

test:
	./t2_test.sh

all:
	make install
	make compile
	make test

clean: 
	rm blite.tab.*
	rm lex.yy.c

