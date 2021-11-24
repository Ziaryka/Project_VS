#!/bin/bash

for file in *.pdbqt;
	do
	 name=${file%.*}
	 eval "obminimize -sd ${name}.pdbqt > ${name}_em.pdbqt"
	 #echo $name
	done
