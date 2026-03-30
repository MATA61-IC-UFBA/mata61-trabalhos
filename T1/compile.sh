#!/bin/bash
# no parameters
# add your Flex code to compl.l
# do NOT change main.c

T1=$(pwd)

flex compl.l

cc -o compl lex.yy.c main.c

if [ -e "$T1/compl" ] ; then
	chmod +x compl
fi

# clean
rm lex.yy.c

