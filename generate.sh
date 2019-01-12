#!/bin/sh

for file in `ls sequence/*.stl`
do
  file=`basename $file`
  index=${file:6:2}
  echo $index
  cp marche00.scad marche$index.scad
  ex marche$index.scad <<EOF
%s/"01"/"$index"/
w
q!
EOF
done

