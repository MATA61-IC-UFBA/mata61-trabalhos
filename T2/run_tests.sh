#!/bin/bash
# T2
# no parameter
# requires dirs: tests

T2=$(pwd)
tests="$T2/tests"

## You have already built t2 using make compile
## or had a compilation error.

echo -n "T2 - "

if [ -e "$T2/compl" ] ; then
	cp "$T2/compl" $tests
else
	echo "Executable parser not found."
	exit 2
fi

# Get the inputs
cd "$tests"
mytests=$(ls *.in)

echo "Running tests"
echo "---"
totalp=0
totalf=0

for t in $mytests; do
    name="$(basename $t .in).out"
    ora="$(basename $t .in).ora"
    echo -n "Running $t ..."
    ./compl "$tests/$t" "$tests/$name"
    n1=`diff -bB -iw "$tests/$name" "$tests/$ora" | grep "^>" | wc -l`
    n2=`diff -bB -iw "$tests/$name" "$tests/$ora" | grep "^<" | wc -l`
    if [[ $n1 -eq 0 ]] && [[ $n2 -eq 0 ]] ; then
        echo 
        ((totalp++))
    else
        echo "FAIL"
        ((totalf++))
    fi
done

echo "---"
echo "PASS: $totalp"
echo "FAIL: $totalf"
echo
echo "Done"

rm "$tests/compl"
cd "$T2"

