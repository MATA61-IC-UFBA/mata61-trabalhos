#!/bin/bash
# no parameters
# add your Flex code to scr/compl.l
# do NOT change src/main.c

T1=$(pwd)

# run inside src
cd src

flex compl.l

cc -o compl lex.yy.c main.c

if [ -e "$T1/src/compl" ] ; then
# change compl to exec and move it to T1
	chmod +x compl
	mv compl "$T1"
fi

# clean
rm lex.yy.c

# back to T1
cd "$T1"

