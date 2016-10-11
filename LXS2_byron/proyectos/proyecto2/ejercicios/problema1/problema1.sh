#!/bin/bash

DATA=../../problemas/problema1/hojasDatos
mkdir $DATA/datos_csv

OUT_DATA=$DATA/arhivos_csv
m=0
for i in `find $DATA -name '*.xls' `
do
	echo "Presentando archivo $i"
	
	xls2csv $i > $OUT_DATA/data-$csv
	let m=m+1
done 2> error1.log
