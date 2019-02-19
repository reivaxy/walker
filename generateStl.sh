#!/bin/sh

for file in `ls marche*.scad`
do
  file=`basename $file`
  index=${file:6:2}
  echo $index
  /c/Program\ Files/OpenSCAD/openscad.exe -o marche$index.stl $file
done

