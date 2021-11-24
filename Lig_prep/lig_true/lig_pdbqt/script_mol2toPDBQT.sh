#!/bin/bash

for file in *.mol2;
	do
	 eval "prepare_ligand4.py -l $file -v"
	done
