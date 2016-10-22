#/bin/bash
#
welcome()
{
	clear
	echo "Bienvenido!"
 	echo "Este es un programa creado para graficar ejercicios en bash con gnuplot"
	echo "Creado por:           Byron Serrano"
	echo "Fecha creación:       15/10/2016"
	echo "Última modificación:  21/10/2016"
	echo " "
	echo " "
}

#menu del ejercicio 1
display_menu_problem_1()
{

while true ; do
	echo "***************************Ejercicio #1************************"
	echo "    1)       Generar solución."
	echo "    2)       Visualizar gráfico."
	echo "    0)       Volver al menú principal."
	echo "Seleccione una opción: "
	read -p "" action
	echo "***************************************************************"	

	case $action in 
	  "1" ) ./superScript.sh;;
	  "2" ) display fig1.png;;
	  "0" ) break;;
	  *   ) echo "$action No es una opción correcta, intente de nuevo!!!";;
	esac
	echo " "
done
}

#menu del ejercicio 2
display_menu_problem_2()
{
echo "Problema: Generar graficos en gnuplot a partir de archivos .xls,que determinan el uso de lo servicios básicos en una casa compartida por compañeros de universidad, por seis meses"
echo " "
while true ; do
	echo "***************************Ejercicio #2************************"
	echo "    1)       Agua"
	echo "    2)       Electricidad"
	echo "    3)       Teléfono"
	echo "    4)       Celular"
	echo "    5)       Internet"
	echo "    6)       Alquiler"
	echo "    7)       Aseo"
	echo "    8)       Cable"	
	echo "    9)       Visualizar gráfico "
	echo "    0)       Salir"
	echo "Seleccione una opción: "
	read -p "" action
	echo "***************************************************************"	
	
	option=$(($action+2))
	case $action in 
	  "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8") ./superScript2.sh $option 0 0;;
	  "9" ) display fig2.png;;
	  "0" ) break;;
	  *   ) echo "$action No es una opción correcta, intente de nuevo!!!";;
	esac
	echo " "	
done
}

display_main_menu()
{
while true; do
	echo -e " "
	echo -e "==========================================================="
	echo -e "                       MENU PRINCIPAL                      "
	echo -e "==========================================================="
	echo -e "1)     Abrir ejercicio #1"
	echo -e "2)     Abrir ejercicio #2"	
	echo -e "0)     Para salir"
	echo " "
	echo -e "Seleccione una opción"

	read -p "" action
	case $action in 
	  "1" ) display_menu_problem_1;;
	  "2" ) display_menu_problem_2;;
	  "0" ) exit;;
	  * ) echo "Selecciona una opcion correcta";;
	esac
done
}

welcome
display_main_menu

