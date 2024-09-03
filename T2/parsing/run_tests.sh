#!/bin/bash
# no parameter
# requires dirs: tests/inputs, tests/oracle, tests/outputs
# requires program "compl" -- your lexer.

T1=$(pwd)
tests="$T1/tests"
inputs=/inputs/
outputs=/outputs/
oracle=/oracle/


# The function total_files reports a total number of files for a given directory. 
function total_files {
        find $1 -type f | wc -l
}

echo "T2 - Parte A - 2024.1"
echo

## Build your compL parser using make compile.
if [ -e "$T1/compl" ] ; then
	echo "- Using compl."
# Then copy the executable file to the tests folder.
	cp "$T1/compl" $tests
	echo
else
	echo "- Errors in compiling compl ..."
	exit 2
fi

# Get the tests in folder inputs
cd "$tests$inputs"
mytests=$(ls)
cd "$tests"

if [ -d "$tests$outputs" ] ; then
   echo "- Directory $tests$outputs exists."
   echo
else
   mkdir $tests$outputs
fi

echo "- Running tests ..."
echo
echo "Number of test cases: `total_files "$tests$inputs"`"
echo

# SEM ORACULO

for t in $mytests; do
    name="$(basename $t .in).out"
    echo "Running $t ..."
    ./compl "$tests$inputs$t"  "$tests$outputs$name"
#   n1=`diff -bB -iw "$tests$outputs$name" "$tests$oracle$name" | grep "^>" | wc -l`
#   n2=`diff -bB -iw "$tests$outputs$name" "$tests$oracle$name" | grep "^<" | wc -l`
#   if [[ $n1 -eq 0 ]] && [[ $n2 -eq 0 ]] ; then
#       echo -n "."
#   else
#       echo -n "F"
#   fi
done

echo
echo
echo "Done"

rm "$tests/compl"
cd "$T1"

