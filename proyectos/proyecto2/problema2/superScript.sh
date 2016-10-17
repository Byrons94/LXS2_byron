#!/bin/bash

#direcctorios que vamos a necesitar
DATA=./hojasDatos
XML_FILES=$DATA/datos_xml

CSV_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/graficos
LOG_DATA=$DATA/logs

COUNTER=0

counter_reset()
{
COUNTER=0
}

#se valida la existencia de los directorios en caso de que no existan se crean
if ! -d $CSV_DATA || ! -d $GRAF_DATA || ! -d $LOG_DATA 
then
	mkdir $CSV_DATA
	mkdir $GRAF_DATA
	mkdir $LOG_DATA
	echo "Creado directorios.."
fi

#se recorren los archivos xlm para convertirlos  cssv
for i in `find $XLM_FILES -name '*.xls'`
do	
	echo "Procesando el archivo $i"
	sudo xls2csv $i > $CSV_DATA/data-$COUNTER.csv 		
	let COUNTER=COUNTER+1
done 2> $LOG_DATA/error_conversion_xls_to_csv.log

counter_reset

#se comienza a extraer los datos de los archivos csv con formato para graficar
for j in `find $CSV_DATA -name "*.csv"`
do
	echo "Dando formato al archivo $j para generar graficos"
	#cat $e | awk -F "\",\"" ''
	cat $j | awk -F "\",\"" 'NR >= 3 && NR <= 10 { print $2 }' > $GRAF_DATA/graf-$COUNTER.dat
	let COUNTER=COUNTER+1

done 2> $LOG_DATA/error_formating_data.log

