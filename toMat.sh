#!/bin/bash

files=`ls -1 *.dat`

for f in $files
do
	wfdb2mat -r "${f%.*}"
done

