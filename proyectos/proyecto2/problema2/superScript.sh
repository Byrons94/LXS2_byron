#!/bin/bash

#direcctorios que vamos a necesitar
DATA=./hojasDatos
XML_FILES=$DATA/datos_xml

CSV_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf
LOG_DATA=$DATA/logs
GRAF_IMA=$DATA/graf
FULL_DATA=$DATA/full_data

COUNTER=0

counter_reset()
{
COUNTER=0
}

#se valida la existencia de los directorios en caso de que no existan se crean
if ! -d $CSV_DATA || ! -d $GRAF_DATA || ! -d $LOG_DATA || ! -d $GRAF_IMA || ! -d $FULL_DATA
then
	mkdir $CSV_DATA
	mkdir $GRAF_DATA
	mkdir $LOG_DATA
	mkdir $GRAF_IMA
	mkdir $FULL_DATA
	echo "Creado directorios.."
fi


#se recorren los archivos xlm para convertirlos  cssv
for i in `find $XLM_FILES -name '*.xls' | sort -t '\0' -n`
do	
	echo "Procesando el archivo $i"
	sudo xls2csv $i > $CSV_DATA/data-$COUNTER.csv 		
	let COUNTER=COUNTER+1
done 2> $LOG_DATA/error_conversion_xls_to_csv.log
counter_reset #resetea el contador


LINEA=3 #esta linea se cambia por un parametro ya que el el valor a graficar
#se  extraen los  datos necesarios de los archivos csv con y se guardan en formtato .dat
for j in `find $CSV_DATA -name "*.csv" | sort -t '\0' -n`
do
	
	echo "Dando formato al archivo $j para generar graficos"
	cat $j | awk -F "\",\"" 'NR == '$LINEA' {print $2 }' > $GRAF_DATA/graf-$COUNTER.dat
	let COUNTER=COUNTER+1

done 2> $LOG_DATA/error_formating_data.log
counter_reset #resetea el contador


if [ -a $FULL_DATA/full.dat ]
then
	rm $FULL_DATA/full.dat 
	echo "Archivo full.bat eliminado"
fi 2> $LOG_DATA/error_delete_full_data.log


for k in `find $GRAF_DATA -name "*.dat" | sort -t '\0' -n`
do
	cat  $k >> $FULL_DATA/full.dat
	echo "Procesando archivo $k"
done 2>> $LOG_DATA/error_join_data.log 


graficar()
{
DATA_GRAF=$FULL_DATA/full.dat
	gnuplot << EOF 2> $LOG_DATA/error_graf.log
	set terminal png
	set output 'fig.png'
	plot "$DATA_GRAF"  with lines  title "Consumo de Agua"
EOF
echo "Graficado con exito"
}


graficar
