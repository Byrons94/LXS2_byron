#!/bin/bash

#este script respalda 3 archivos en caso de que existan
#y lo hace en una manera jerarquica.
if test -e $1 $1.bck
then
	cp $1 $1.bck
	echo "El archivo $1 fue correctamente respaldado.. "
elif test -e $2
	cp $2 $2.bck
	echo "El archivo $2 fue correctamente respaldaldo.. "
elif test -e $3
	cp $3 $3.bck
	echo "El archivo $3 fue correctamente respaldaldo.. "
else
	echo "No se puede respañdar ninguno de los archivos $@"
fi
