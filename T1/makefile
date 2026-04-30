install:
	sudo apt-get install -f flex

compile:
	flex compl.l
	gcc -o compl lex.yy.c main.c
test:
	./run_tests.sh
clean:
	rm lex.yy.c
	rm compl
