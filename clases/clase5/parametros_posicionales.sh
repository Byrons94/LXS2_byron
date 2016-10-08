#!/bin/bash


#La salida estandar de error estará redireccionada añl archivo archivo1.txt


if cp archivo1.txt archivo1.txt.bck 2> $0.err
then
	echo "El archivo1.txt fue correctamente respaldado"
fi
