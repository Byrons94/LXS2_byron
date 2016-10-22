#!/bin/bash

#se establece la ruta donde se encuentran los archivos .xls
DATA=./problema1/hojasDatos
OUT_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf
FULL_DATA=$DATA/full_datos
ERROR_DATA=$DATA/error_log

#validar la existencia de los directorios
if  [ ! -d $OUT_DATA ] || [ ! -d $ERROR_DATA ]
then
	mkdir $OUT_DATA
	mkdir $GRAF_DATA
	mkdir $FULL_DATA
	mkdir $ERROR_DATA
	echo  "Creando directorios"
fi

m=0
for i in `find $DATA -name '*.xls'`
do
	echo "Procesando archivo $i"
	sudo xls2csv $i > $OUT_DATA/data-$m.csv
	let m=m+1
done 2> $ERROR_DATA/error1.log
m=0

for e in `find $OUT_DATA -name "*.csv"`
do
	echo "Dando formato de datos para graficar el archivo $e"	
	cat $e | awk -F "\",\"" '{print $1 " " $2 " " $3 " " $4 " " $5}' | sed '1,$ s/"//g' | sed '1 s/date/$date/g' > $GRAF_DATA/graf-$m.dat
	
	let m=m+1
done 2> $ERROR_DATA/$error2.log


if [ -a $FULL_DATA/full.dat ]
then
	rm $FULL_DATA/full.dat
	echo "Archivo full.dat borrado"
 
fi 2> $ERROR_DATA/errorIf.log

for k in `find $GRAF_DATA -name "*.dat"`
do
	sed '1d' $k >> $FULL_DATA/full.dat
	echo "Procesando archivo $k"
done 2> $ERROR_DATA/error3.log 



FTM_BEGIN='20110206 0000'
FTM_END='20110206 0200'
FTM_X_SHOW='%H: %M'
DATA_DONE=$FULL_DATA/full.dat

graficar()
{
	gnuplot << EOF 2> $ERROR_DATA/error.log
	set xdata time
	set timefmt "%Y%m%d %H%M"
	#set xrange ["$FMT_BEGIN" : "$FMT_END"]
	set format x "$FTM_X_SHOW"
	set terminal png
	set output 'fig1.png'
	plot "$DATA_DONE" using 1:3 with lines title "sensor1", "$DATA_DONE" using 1:4 with linespoints title "sensor2" 

EOF
echo "Graficando exitosamente"
}

graficar

