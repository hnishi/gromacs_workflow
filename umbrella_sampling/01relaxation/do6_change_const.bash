#!/bin/bash

mkdir -p posre_1000
cp posre_* posre_1000/

mkdir -p posre_10000

for i in $(ls ./posre_1000/);do echo ./posre_1000/$i; sed -e 's; 1000  1000  1000;10000 10000 10000;g' ./posre_1000/$i > ./posre_10000/$i ;done
cp posre_10000/* .     
