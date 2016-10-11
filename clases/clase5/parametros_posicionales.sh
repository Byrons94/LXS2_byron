#!/bin/bash

ERRORLOG="$0.err"
#La salida estandar de error estará redireccionada añl archivo archivo1.txt

if cp archivo1.txt archivo1.txt.bck 2> $ERRORLOG
then
	echo "El archivo1.txt fue correctamente respaldado"
	echo "Eliminando archivo original"

	if rm -f archivo1.txt
	then
		echo "El archivo original fue eliminado correctamente"
	else
		echo "No se pudo eliminar el archivo $ERRORLOG"
	fi
else
	echo "El archivo1.txt no pudo ser respaldado. verifique el log: $ERRORLOG"
fi
