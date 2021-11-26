#!/usr/bin/perl


$nbligand = 200 ;
$actif = 100 ;
$pas = 1 ;
$max_index_lig = 1000;

for $i (1...$max_index_lig )
{
	if (-e "./lig_$i/out.pdbqt") {
		open (INI,"./lig_$i/out.pdbqt");
		@ini=<INI>;
		close (ini);
		$ene[$i] = substr($ini[1],25,7);
		# print("$i\n");
		# print("$ene[$i]\n");
	}
}


for $j (1...$max_index_lig)
{
	if (-e "./lig_$j/out.pdbqt") {
		if (($j > 500 ) )
		{
			$final[$j] = $ene[$j]."  1\n";
		}
		else
		{
			$final[$j] = $ene[$j]."\n";
		}
		#print("$final[$j]\n");
	}
}
@final = grep /\S/, @final;



#@class = sort @final ;
@class = sort { $b <=> $a} @final ;
#print (@class);


open (OU2,">enrichissement.dat");

$range = $nbligand*$pas/100 ;  
#$n = 100/$pas ;  
#print("$range\n");

for $n(1..100/$pas)   
{
	for $m(sprintf("%.0f", ($nbligand-($range*$n))) ... $nbligand)   
	{
		# print("$m\n");

		$bon = $bon + substr($class[$m],8,12);
		$perc_bon = $bon/$actif*100;
	}
	$test=sprintf("%.0f",($nbligand-($range*$n)));
	printf(OU2 "$n\t$perc_bon\n");
	$bon =0;
}

$moy = 0;
for $k(1..$nbligand)
{
$sum = ($sum + $ene[$k]);
$moy = $sum/$k;
#print("$ene[$k] \t $k \n");

}


for $l(($nbligand-$actif+1)...$nbligand)
{
$sum2 = ($sum2 + $ene[$l]);
$moy2 = $sum2/($actif);
#print("$moy2 \t $ene[$l] \t $l \n");
}


for $m(1..($nbligand-$actif+1))
{
$sum3 = ($sum3 + $ene[$m]);
$moy3 = $sum3/($nbligand-$actif+1);
#print("$moy3 \t $ene[$l] \t $m \n");
}


print("Moyenne de la banque :\t".sprintf("%.2f", $moy)." kcal/mol\n");
print("Moyenne des decoys :\t".sprintf("%.2f", $moy3)." kcal/mol\n");
print("Moyenne des actifs :\t".sprintf("%.2f", $moy2)." kcal/mol\n");


open (OU3,">resume.dat");
printf(OU3 "Moyenne de la banque :\t".sprintf("%.2f", $moy)." kcal/mol\n");
printf(OU3 "Moyenne des decoys :\t".sprintf("%.2f", $moy3)." kcal/mol\n");
printf(OU3 "Moyenne des actifs :\t".sprintf("%.2f", $moy2)." kcal/mol\n");

