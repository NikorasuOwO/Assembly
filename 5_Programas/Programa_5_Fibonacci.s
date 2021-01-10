# Programa #5 - Fibonacci
# Leonardo de Pisa (ca. 1170-1240), también conocido como Fibonacci, fue un matemático
# italiano. Difundió en Europa la utilidad práctica del sistema de numeración indoarábigo
# frente a la numeración romana, y fue el primer europeo en describir la sucesión numérica
# que lleva su nombre.

# Diseñe un programa que imprima en pantalla la sucesión o función de Fibonacci

# Dado que utilizamos aritmética entera es posible que se produzca un desbordamiento
# cuando se intente calcular el término n-ésimo, con n suficientemente grande. Determine
# haciendo uso de la reflexión y la paciencia, cuál es el término de la sucesión más grande
# que se puede calcular en aritmética entera. Nota importante: no olvide considerar, cuando
# se calcula el nuevo término de la sucesión, la diferencia entre las instrucciones add y addu,
# y tenga en cuenta que la llamada al sistema print_int interpreta el argumento como un
# número entero con signo codificado en complemento a dos. Así se las ponían a Fernando
# VII.


.data 0x10000000


nombre:  .asciiz "Programa #5 - Cálculo de la sucesión de Fibonacci\n " #El nombre de nuestro programa
finMsg:  .asciiz "\n\n * * * * Fin del programa * * * * "
readMsg: .asciiz "Introduce el número de elementos de la serie que quieres calcular. ¡CUIDADO! El máximo es 47: "
espacio: .asciiz " "

# Segmento de código
		.globl main
		.text 0x00400000

		.ent main

main: # Método main

	li $t0, 0 # Primer número de la sucesión
	li $t1, 1 # Segundo número de la sucesión
						# t2 será nuestro registro auxiliar

	li $v0, 4 # Cargamos código para imprimir un String
	la $a0, nombre # Cargamos la dirección del string
	syscall # Imprimimos le mensaje de presentación

	li $v0, 4 # Cargamos código para imprimir un String
	la $a0, readMsg # Cargamos la dirección del string
	syscall # Imprimimos le mensaje de que indica que hay que introducir un entero

	li $v0, 5 # Cargamos el código para leer un entero
	syscall # v0 será el número de términos que tendrá la sucesión
	move $t3, $v0 # Ponemos el valor de v0 en t3. Será el número de términos que imprimiremos.

	ImprimirFuera:
	### Imprimimos los dos primeros términos ###
	ble $v0, $zero, EXIT # Si hemos escrito que queremos imprimir 0 o menos enteros, ya ha acabado el programa.
	# Primero
	li $v0, 1
	li $a0, 0
	syscall

	sub $t3, $t3, 2
	# Restamos 2 a $t3 para hacer la siguiente comprobación
	# y para tener después en t3 los números que nos faltan por imprimir

	blt $t3, $zero, EXIT #Si el numero introducido es menor que 2-2, ya se ha impreso todo, terminamos.

	# Imprimimos un espacio
	li $v0, 4 #Cargamos el código para imprimir un String
	la $a0, espacio
	syscall
	# Segundo
	li $v0, 1
	li $a0, 1
	syscall

Bucle:

	beqz $t3, EXIT

	addu $t2, $t0, $t1 # Ponemos en t3 la suma de $t0 y $1

	# Imprimimos un espacio
	li $v0, 4 #Cargamos el código para imprimir un String
	la $a0, espacio
	syscall

	#Imprimimos el elemento de la serie
	move $a0, $t2 # Ponemos en a0 la suma, que queremos imprimir.
	li $v0, 1 #Cargamos código para imprimir un entero
	syscall # Imprimimos

	sub $t3, $t3, 1 # t3 es nuestra variable inversa, cuando sea 0, hemos impreso los n elementos.
	move $t0, $t1 # Ponemos en t0 lo que hay en t1, el termino n+1 pasa a ser n
	move $t1, $t2 # Ponemos en t1 lo que hay en t2. El término n+2 pasa a ser n+1.

	j Bucle # Saltamos a bucle.



EXIT:

	#Imprimimos String de salida
	la $a0, finMsg
	li $v0, 4
	syscall

	#Terminamos el programa
	li $v0, 10
	syscall
