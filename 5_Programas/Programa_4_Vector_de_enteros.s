#Programa #4 - Vector de enteros

#Diseñe un programa que declare e inicialice en memoria un vector con 20 números enteros
#(se pueden elegir los valores que se quiera).
#A continuación imprime los elementos del vector y calcula los siguientes valores: mínimo,
#máximo y suma; finalmente, también imprime la media aritmética pero se calcula utilizando
#aritmética real a fin de no perder precisió



.data 0x10000000


nombre:  .asciiz "Programa #4 - Cálculos sobre un vector de enteros\n " #El nombre de nuestro programa
vecMsg: .asciiz "\nVector"
minMsg: .asciiz "\nMínimo: "
maximoMsg: .asciiz "\nMáximo: "
sumaMsg: .asciiz "\nSuma: "
mediaMsg: .asciiz "\nMedia: "
finMsg:  .asciiz "\n\n * * * * Fin del programa * * * * "
espacio: .asciiz " "

# elementos del vector: -1 13 5 -5 9 4 -3 9 4 -7 24 2 15 6 -8 17 1 35 11 -2
vector: .word -1, 13, 5, -5, 9, 4, -3, 9, 4, -7, 24, 2, 15, 6, -8, 17, 1, 35, 11, -2 # Vector
longitud: .word 20 # Longitud del vector

# Segmento de código
		.globl main
		.text 0x00400000

		.ent main

main: # Método main

  la $s0, vector #Asignamos a t0 la dirección de memoria de vector, por tanto también de su primer elemento.
  lw $s1, longitud # Asignamos a s1 la longitud del Vector
  add $t1, $s0, $zero # Asignamos la dirección de vector a t1.
  # t1 es el incremento en la dirección, que nos permitirá acceder a los elementos; aumentará de 4 en 4.
  add $t2, $s1, $zero #Metemos en t2 la longitud del vector.


MostrarArray: # Este método mostrará el vector en pantalla.
# Lo recorremos, y en cada acceso a cada elemento, imprimimos el mismo.

  lw $a0, 0($t1) # Metemos en $a0 la palabra en la dirección t1, que será la dirección del elemento que queremos imprimir.
  li $v0, 1 #Cargamos el código para imprimir enteros.
  syscall # imprimimos!

  #A continuación imprimimos un espacio.
  la $a0, espacio
  li $v0, 4
  syscall

  addi $t1, 4 # Aumentamos la dirección en 4, para acceder al siguiente elemento.
  sub $t2, $t2, 1 # t2 es nuestro contador inverso, cuando llegue a 0, habremos recorrido todo el vector.

  bnez $t2, MostrarArray #Si t2 no es 0, iteramos.

### RESETEAMOS t1 y t2 ###
	add $t1, $s0, $zero # Asignamos la dirección de vector a t1.
  # t1 es el incremento en la dirección, que nos permitirá acceder a los elementos; aumentará de 4 en 4.
  add $t2, $s1, $zero #Metemos en t2 la longitud del vector.

Minimo:
	


EXIT: # Acaba el programa

  li $v0, 4 # Cargamos el código de erro para imprimir Strings
  la $a0, finMsg # Indicamos la dirección del String que queremos imprimir
  syscall # imprimimos

  li $v0, 10 # Indicamos la orden de terminar el programa
  syscall # Terminamos el programa
