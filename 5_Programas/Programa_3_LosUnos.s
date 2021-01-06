#Programa #3 - Unos
#Diseñe un programa que, dado un número entero introducido desde el teclado, calcule el
#número de unos que hay en la palabra bits que lo representa. El programa finaliza cuando el
#número introducido es cero.


# Aplicaremos una máscara que irá cambiando de manera que podamos "leer" cada bit,
# yendo del LSB al MSB.

.data 0x10000000


nombre:  .asciiz "Programa #3\n (introduce 0 para terminar el programa)" #El nombre de nuestro programa
readMsg: .asciiz "\nTe diré cuantos unos hay en la palabra bits que representa a un número, introdúcelo: "
showMsg: .asciiz "\nEl número de unos es: "
endMsg:  .asciiz "\n\n * * * * Fin del programa * * * * "


# Segmento de código
		.globl main
		.text 0x00400000

		.ent main

main: # Método main
  li $t1, 1 #Está será nuestra máscara
  li $t2, 1 #Este es nuestro número
  li $t3, 0 #Esta es nuestra variable auxiliar
  li $t4, 0 #Esta es nuestra variable suma

  li $v0, 4 # Cargamos el código para imprimir Strings
  la $a0, nombre # Indicamos la dirección del String que queremos imprimir
  syscall # imprimimos

Bucle_General:

  li $v0, 4 # Cargamos el código para imprimir Strings
  la $a0, readMsg # Indicamos la dirección del String que queremos imprimir
  syscall # imprimimos

  # Leemos un entero

  li $v0, 5 # Cargamos el código para leer enteros
  syscall #Leemos el entero
  beq $v0, $zero, EXIT # Si el número introducido es 0, terminar programa
  add $t2, $v0, $zero # Metemos el valor de $v0, el introducido por teclado, en t2

  j Bucle_Lectura

MostrarSuma:

li $v0, 4 # Cargamos el código de para imprimir Strings
la $a0, showMsg # Indicamos la dirección del String que queremos imprimir
syscall # imprimimos

li $v0, 1 # Cargamos el código de para imprimir enteros
add $a0, $zero, $t4 # Metemos el número de la suma en a0
syscall # imprimimos

and $t4, $zero, $t4 #Ponemos la variable suma a 0.
li $t1,1 #Ponemos la máscara a 1.


j Bucle_General # Volvemos al bucle principal

Bucle_Lectura:

  beq $t1, 0x80000000, MostrarSuma
  #Si la máscara es 0x80000000, es que ya hemos "leido" todos los bits.
  # Volvemos al Bucle_General, a leer el siguiente número.

  and $t3,$t2,$t1 # Aplicamos la máscara. Si el resulado es 0, el bit es 0.

  sll $t1,$t1,1 #Desplazamos la máscara de 1 a la izquierda

  beq $t3, $zero, Bucle_Lectura #Si el bit es 0, pasamos a leer el siguiente, iteramos.

  addi $t4, 1 # Si el bit no es 0, sumamos 1.

  j Bucle_Lectura #Volvemos a iterar.

EXIT: # Acaba el programa

  li $v0, 4 # Cargamos el código de erro para imprimir Strings
  la $a0, endMsg # Indicamos la dirección del String que queremos imprimir
  syscall # imprimimos

  li $v0, 10 # Indicamos la orden de terminar el programa
  syscall # Terminamos el programa
