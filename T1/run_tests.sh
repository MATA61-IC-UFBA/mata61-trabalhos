#!/bin/bash
# T1
# no parameter
# Run inside your folder
# Use make compile

wdir=$(pwd)

# The folder "tests" has been previously copied to "submissions"
tests="$wdir/tests"

# The function total_files reports a total number of files for a given directory. 
function total_files {
        find $1 -type f | wc -l
}

if [ -e "$compl" ] ; then
   cp "compl" $tests
else
   echo "- Executable not found ..."
   exit 2
fi

# Get the input tests
cd "$tests"
mytests=$(ls *.in)

echo "running tests for T1 ..."
totalp=0
totalf=0
for t in $mytests; do
   name="$(basename $t .in).out"
   ora="$(basename $t .in).ora"
   echo "running $t ..."
   ./compl "$tests/$t" "$tests/$name"
   n1=`diff -bB -iw "$tests/$name" "$tests/$ora" | grep "^>" | wc -l`
   n2=`diff -bB -iw "$tests/$name" "$tests/$ora" | grep "^<" | wc -l`
   if [[ $n1 -eq 0 ]] && [[ $n2 -eq 0 ]] ; then
      echo "$t: PASS"
      ((totalp++))
   else
      echo "$t: FAIL"
      ((totalf++))
   fi
done
  
echo "---------------------"
echo "PASS: $totalp"
echo "FAIL: $totalf"
echo "---------------------"
echo
rm "$tests/compl" 
cd "$wdir"

done

