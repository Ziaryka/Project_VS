#!/bin/bash
n=1
while IFS= read -r line; do
	#printf '%s\n' "$line"
	obabel -:"$line" -O lig_$n.mol2 -p 7.4 --gen3D
	n=$((n+1))
done < smiles_act
