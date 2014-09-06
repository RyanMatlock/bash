#!/bin/bash
# this works, although I don't fully understand why
# so you call it like this:
# ./prepend.sh <path_to_work_on> <file_name_grep_regex> <string_to_prepend>
for f in $(ls $1 | grep $2)
do
    echo $3 > $1/tmpfile;
    cat $1/$f >> $1/tmpfile;
    mv -v $1/tmpfile $1/$f;
done < $1
