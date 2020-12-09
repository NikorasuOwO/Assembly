
### PRIMER PROGRAMA EN ASSEMBLY: Hola Mundo ###


.data #Empieza el segmento de definición de variables

cadena: .asciiz "Hola_Mundo" #Definimos la cadena
.globl main


.text #Empieza el segmento de cálculo

main: #Subrutina main

la $a0, cadena #Metemos la dirección de la cadena en $a0, para que el sistema opere con ella
li $v0, 4 #Metemos "4" en v0, que le indicará al sistema que queremos imprimir.
syscall #Llamamos al sistema. Sistema, despierta! Quiero imprimir!

li $v0, 10 #Metemos "10" en v0, indicando que queremos salir.
syscall #Llamamos al sistema, Sistema despierta! Quiero salir!
