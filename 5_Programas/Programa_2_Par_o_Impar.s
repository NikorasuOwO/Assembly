### 5 Programas ###


## Programa #2 - Par o impar ##

#Diseñe un programa que indique si un número entero es par o impar. En matemáticas, un
#número entero es par si es divisible entre dos. Sin embargo, en el programa no está
#permitido utilizar la instrucción de división. El programa finaliza cuando el número
#introducido es cero.

#Solo para complicarme la vida voy a manipular bits, no van a haber divisiones.

# Segmento de datos

.data 0x10000000

nombre:  .asciiz "Programa #2\n (introduce 0 para terminar el programa)" #El nombre de nuestro programa
readMsg: .asciiz "\nTe diré si el número es par o impar, introdúcelo: "
evenMsg: .asciiz " es par\n"
oddMsg:  .asciiz " es impar\n"
endMsg:  .asciiz "\n\n * * * * Fin del programa * * * * "

# Segmento de código

		.globl main
		.text 0x00400000

		.ent main

main: # Método main

  # Presentación
  la $a0, nombre #Introducimos en a0 la dirección del mensaje nombre
  li $v0, 4 # Indicamos el código para imprimir un String
  syscall # Hacemos la llamada al sistema

Bucle: #Empezamos la rama Bucle

# Imprimimos mensaje de Lectura

la $a0, readMsg # Metemos en a0 el mensaje a imprimir
li $v0, 4		# Indicamos el código para imprimir un String
syscall		# Hacemos la llamada al sistema

#Leemos un número

  #Lectura del número
  li $v0, 5 # Cargamos el código para leer enteros
  syscall # Sistema, lee el enteros
  #El entero estará en v0

  beq $zero, $v0, EXIT #Si v0 es 0, salta a la rama EXIT (Termina el programa)

  #El cálculo:
    #Un número en binario es par cuando su LSB es 0, y eso es lo que queremos comprobar,
    #Haremos la operación lógica AND con 0x1, si da 0x0, el número es par, sino impar.

  andi $v1, $v0, 1 #1 es nuestra máscara, hacemos la operación AND entre el número y 1.
                    # El resultado de la opración estará en v0.

  beq $zero, $v1, Par #Si el resultante es igual a zero, salta a la rama Par

  #Sino, el número será impar:

  add $a0, $v0, $zero #Metemos el número en a0
  li $v0, 1 #Imprimimos el valor del número
  syscall

  la $a0, oddMsg # Metemos en a0 el mensaje a imprimir
  li $v0, 4		# Indicamos el código para imprimir un String
  syscall		# Hacemos la llamada al sistema

  j Bucle #Volvemos al bucle

  Par: # Rama para imprimir el mensaje si es par.

  add $a0, $v0, $zero #Metemos el número en a0
  li $v0, 1 #Imprimimos el valor del número
  syscall

    la $a0, evenMsg # Metemos en a0 el mensaje a imprimir
    li $v0, 4		# Indicamos el código para imprimir un String
    syscall		# Hacemos la llamada al sistema

    j Bucle

  EXIT: # Rama para terminar el programa

    #Imprimimos mensaje de salida

    la $a0, endMsg # Metemos en a0 el mensaje a imprimir
    li $v0, 4		# Indicamos el código para imprimir un String
    syscall		# Hacemos la llamada al sistema


    li $v0, 10		# Indicamos el código para terminar el programa
    syscall		# Hacemos la llamada al sistema

  # Fin
