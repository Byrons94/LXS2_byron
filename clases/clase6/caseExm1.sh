#!/bin/bash

#Ejemplo de case, determina si la distro soportada

shopt -s nocasematch

DISTRO=$1

case "$DISTRO" in 
	Ubutu)
		echo "Distribucion $DISTRO soportada"
	;;
	Centos)
		echo "Distribucion $DISTRO soportada"
	;;
	Fedora)	
		echo "Distribucion $DISTRO soportada"
	;;
	*)
		echo "Distribucion $DISTRO No esta soportada no sea baboso no lo intente por que no va a servir"

esac
