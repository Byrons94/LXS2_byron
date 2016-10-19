#!/bin/bash

#-------------------------------region variables----------------------------------------------
#direcctorios que vamos a necesitar
DATA=./hojasDatos
XML_FILES=$DATA/datos_xml


#directorios necesarios para ordenar los archivos
CSV_DATA=$DATA/datos_csv
GRAF_DATA=$DATA/datos_graf
LOG_DATA=$DATA/logs
FULL_DATA=$DATA/full_data


#directorio que apunta al archivo donde se guardan los datos procesados para graficar
DATA_GRAF=$FULL_DATA/full.dat


#parametros
#if  $1 != ""  #&& [ -v $2 ] && [ -v $3 ] #check validation
#then   
	EXPENSES_ID=$1
	MONTH_START=$2
	MONTH_END=$3
#else
#	echo "No se puede continuar sin parametros.."
#	exit 1
#fi

#contador
COUNTER=0
#----------------------------------endregion-------------------------------------------------


#--------------------------------region functions-------------------------------------------
#resetea el contador a 0
counter_reset()
{
COUNTER=0
}


#se valida la existencia de los directorios, en caso de que no existan se crean
validate_directory()
{
if [ ! -d $CSV_DATA ] || [ ! -d $GRAF_DATA ] || [ ! -d $LOG_DATA ]  || [ ! -d $FULL_DATA ]  
then
	mkdir $CSV_DATA
	mkdir $GRAF_DATA
	mkdir $LOG_DATA
	mkdir $GRAF_IMA
	mkdir $FULL_DATA
	echo "Creado directorios.."
fi
}


#se recorren los archivos xlm para convertirlos csv
convert_xml_to_csv()
{
for i in `find $XLM_FILES -name '*.xls' | sort -t '\0' -n`
do	
	echo "Procesando el archivo $i"
	sudo xls2csv $i > $CSV_DATA/data-$COUNTER.csv 		
	let COUNTER=COUNTER+1

done 2> $LOG_DATA/error_conversion_xls_to_csv.log
counter_reset #llamado a funcion
}


#se  extraen los  datos necesarios de los archivos csv con y se guardan en formtato .dat
extract_csv_data()
{
LINEA=$1 #parametro del 3 al 10 donde estan los servicios que se deben graficar
for j in `find $CSV_DATA -name "*.csv" | sort -t '\0' -n`
do	
	echo "Dando formato al archivo $j para generar graficos"
	cat $j | awk -F "\",\"" 'NR == '$LINEA' {print $2 }' > $GRAF_DATA/graf-$COUNTER.dat
	let COUNTER=COUNTER+1

done 2>> $LOG_DATA/error_formating_data.log
counter_reset #llamado a funcion
}


#se verifica y elimina el archivo que posee los datos listos para graficar
delete_procesed_file()
{
if [ -a $DATA_GRAF ]
then
	rm $DATA_GRAF 
	echo "Archivo full.bat eliminado"
fi 2>> $LOG_DATA/error_delete_full_data.log
}


#se crea el archivo .dat con los datos necesarios para graficar
format_data_to_graf()
{
for k in `find $GRAF_DATA -name "*.dat" | sort -t '\0' -n`
do
	cat  $k  >>  $FULL_DATA/full.dat
	echo "Procesando archivo $k"
done 2>> $LOG_DATA/error_join_data.log 
}


#se genera el grafico y se guarda como un archivo png
make_graf()
{
	gnuplot << EOF 2> $LOG_DATA/error_graf.log
	set terminal png
	set output 'graf.png'
	plot "$DATA_GRAF" with linespoints title "$1"
EOF
	echo "Graficado con exito"
}


#selecciona el nombre del grafico dependiendo del servicio a consultar
title_graf()
{
TITLE=''
	case $1 in
  	  3)
		 TITLE="Consumo_de_agua"
	  ;;
	  4)
		 TITLE="Consumo_de_elecricidad"
	  ;;
	  5)
		 TITLE="Consumo_de_teléfono"
	  ;;
	  6)
		 TITLE="Consumo_de_celular"
	  ;;
	  7)
		TITLE="Pago_del_internet"
	  ;;
	  8)
		TITLE="Pago_del_alquiler"
	  ;;
	  9)
		TITLE="Pago_por_el_aseo"
	  ;;
	  10)
		TITLE="Pago_de_televisión_por_cable"
	  ;; 
	  *)
		TITLE="No_definido"
	esac	
}
#-------------------------------end region--------------------------------------------------



#------------------------------region functions calls--------------------------------------
#llamados a las funciones en orden

validate_directory

convert_xml_to_csv
extract_csv_data $EXPENSES_ID

delete_procesed_file
format_data_to_graf

title_graf $EXPENSES_ID
make_graf $TITLE

display "graf.png"
rm -f "graf.png"
#------------------------------end region--------------------------------------------------
