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
	add $t1, $s0, $zero # Asignamos la dirección del primer elemento del vector.
  # t1 es el incremento en la dirección, que nos permitirá acceder a los elementos; aumentará de 4 en 4.
  add $t2, $s1, $zero #Metemos en t2 la longitud del vector.

	lw $t3, 0($s0) #Ponemos en t3 el primer elemento del vector, será nuestra variable mínimo.

Minimo:

	lw $t0, 4($t1) # Ponemos en $t0 el elemento del Vector #Empezamos por el segundo#
	addi $t1, 4 # Añadimos 4 a la dirección para acceder al siguiente elemento después.
	sub $t2, $t2, 1 # t2 es nuestro contador inverso, cuando llegue a 0, habremos recorrido todo el vector.
	beqz $t2, MostrarMinimo # Si t2 es cero, terminamos el programa.

 bge		$t0, $t3, Minimo	# Si t0 es más grande que t3, volvemos al bucle
	add $t3, $t0, $zero # Si t0 es más pequeño, metemos en valor en t3.
	j Minimo # Volvemos al bucle

MostrarMinimo:

	# Imprimimos el mensaje de "Mínimo"

	la $a0, minMsg
	li $v0, 4
	syscall


	add $a0, $t3, $zero # Ponemos el mínimo en a0
	li $v0, 1 # Indicamos el código para imprimir un entero.
	syscall

### RESETEAMOS t1 y t2 ###
	add $t1, $s0, $zero # Asignamos la dirección del primer elemento del vector.
	 # t1 es el incremento en la dirección, que nos permitirá acceder a los elementos; aumentará de 4 en 4.
	 add $t2, $s1, $zero #Metemos en t2 la longitud del vector.

	lw $t3, 0($s0) #Ponemos en t3 el primer elemento del vector, será nuestra variable mínimo.


	Maximo:

	lw $t0, 4($t1) # Ponemos en $t0 el elemento del Vector #Empezamos por el segundo#
	addi $t1, 4 # Añadimos 4 a la dirección para acceder al siguiente elemento después.
	sub $t2, $t2, 1 # t2 es nuestro contador inverso, cuando llegue a 0, habremos recorrido todo el vector.
	beqz $t2, MostrarMaximo # Si t2 es cero, terminamos el programa.

  blt	$t0, $t3, Maximo	# Si t0 es más grande que t3, volvemos al bucle
	add $t3, $t0, $zero # Si t0 es más pequeño, metemos en valor en t3.
	j Maximo # Volvemos al bucle

	MostrarMaximo:

	# Imprimimos el mensaje de "Mínimo"

	la $a0, maximoMsg
	li $v0, 4
	syscall

	add $a0, $t3, $zero # Ponemos el mínimo en a0
	li $v0, 1 # Indicamos el código para imprimir un entero.
	syscall

### RESETEAMOS t1 y t2 ###
	add $t1, $s0, $zero # Asignamos la dirección del primer elemento del vector.
	#	t1 es el incremento en la dirección, que nos permitirá acceder a los elementos; aumentará de 4 en 4.
	add $t2, $s1, $zero #Metemos en t2 la longitud del vector.

	and $t3, $t3, $zero #Ponemos t3 a 0.


Suma:

	lw $t0,0($t1) # Cargamos en $t0 el elemento propio de la dirección en $t1
	addi $t1, $t1, 4
	# Añadimos 4 para acceder en la siguiente iteración al siguiente elemento del vector
	sub $t2, $t2, 1 #t2 es nuestro contador inverso, cuando sea 0, hemos recorrido ya todo el bucle.
	add $t3, $t3, $t0 # Añadimos $t0 a $t3. En $t3 está la suma secuencial del vector.
	beqz $t2, MostrarSuma
	j Suma

MostrarSuma:
	la $a0, sumaMsg # Cargamos la dirección de lo que queremos imprimir en $a0
	li $v0, 4 # Cargamos el código para imprimir un String
	syscall # Imprimimos el String

	add $a0, $t3, $zero #Cargamos el entero que queremos imprimir en a0
	li $v0, 1 # Ponemos v0 a 1 indicando que queremos imprimir un entero.
	syscall # Imprimimos el entero.

	### RESETEAMOS t1 y t2 ###
add $t1, $s0, $zero # Asignamos la dirección del primer elemento del vector.
	#	t1 es el incremento en la dirección, que nos permitirá acceder a los elementos; aumentará de 4 en 4.
add $t2, $s1, $zero #Metemos en t2 la longitud del vector.

Media:
	mtc1 $t3, $f0 # Copiamos el valor de $t3 a $f0
	mtc1 $s1, $f1 # Copiamos el valor de $s1, de la longitud del vector, a $f1
	div.s $f12, $f0, $f1 #Dividimos $f0 por $f1 y metemos el valor en $f12

	la $a0, mediaMsg # Cargamos la dirección de lo que queremos imprimir en $a0
	li $v0, 4 # Cargamos el código para imprimir un String
	syscall # Imprimimos el String

	li $v0, 2 # Ponemos v0 a 1 indicando que queremos imprimir un float. (el que está en $f12)
	syscall # Imprimimos el entero.

EXIT: # Acaba el programa

  li $v0, 4 # Cargamos el código de erro para imprimir Strings
  la $a0, finMsg # Indicamos la dirección del String que queremos imprimir
  syscall # imprimimos

  li $v0, 10 # Indicamos la orden de terminar el programa
  syscall # Terminamos el programa
