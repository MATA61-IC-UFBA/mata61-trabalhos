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

echo "T1 - 2024.1"
echo

## Build your compL lexer using the compile.sh script
if [ -e "$T1/compl" ] ; then
	echo "- Using compl."
	echo
else
	echo "- Compiling lexer ..."
	$($T1/compile.sh)
	echo "Done"
	echo
fi

#echo "- Compiling lexer ..."
#$($T1/compile.sh)
#echo "Done"
#echo

# Then copy the executable file to the tests folder.
if [ -e "$T1/compl" ] ; then
	cp "$T1/compl" $tests
else
	echo "- Errors in compiling lexer ..."
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

for t in $mytests; do
    name="$(basename $t .in).out"
#   echo "Running $t ..."
    ./compl "$tests$inputs$t"  "$tests$outputs$name"
    n1=`diff -bB -iw "$tests$outputs$name" "$tests$oracle$name" | grep "^>" | wc -l`
    n2=`diff -bB -iw "$tests$outputs$name" "$tests$oracle$name" | grep "^<" | wc -l`
    if [[ $n1 -eq 0 ]] && [[ $n2 -eq 0 ]] ; then
        echo -n "."
    else
        echo -n "F"
    fi
done

echo
echo
echo "Done"

rm "$tests/compl"
rm "$T1/compl"
cd "$T1"

