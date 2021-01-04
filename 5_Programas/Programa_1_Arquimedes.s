### 5 Programas ###


## Programa #1 - Arquímedes ##

# Implemente un programa que calcule la superficie y el área de una esfera.
# El radio de la esfera se introduce por teclado. Utilice aritmética real.

# ---------------------------------------------------------------------------

# Segmento de datos

.data 0x10000000

nombre:  .asciiz "Programa #1\n" #El nombre de nuestro programa
readMsg: .asciiz "Calculamos el área y volumen de una esfera. Introduce el radio: "
areaMsg: .asciiz "Área: "
volMsg:  .asciiz "\nVolumen: "
endMsg:  .asciiz "\n\n * * * * Fin del programa * * * * "

radio:   .word 1 #Almacenaremos en radio el radio dado por teclado
area:    .word 1 #Almacenaremos en área el área calculada
vol:     .word 1 #Almacenaremos en vol el volumen calculado


# Segmento de código

		.globl main
		.text 0x00400000

		.ent main

main: # Método main

  # Presentación
  la $a0, nombre #Introducimos en a0 la dirección del mensaje nombre
  li $v0, 4 # Indicamos el código para imprimir un String
  syscall # Hacemos la llamada al sistema

  # Imprimimos mensaje para recibir el radio
la $a0, readMsg # Metemos en a0 el mensaje a imprimir
li $v0, 4		# Indicamos el código para imprimir un String
syscall		# Hacemos la llamada al sistema

  # Lectura del Radio
  li $v0, 6 # Indicamos el código para leer un float
  syscall # Hacemos la llamada al sistema

  # Almacenamos el radio
  la $a0, radio # Almacenamos en $a0 la dirección de radio.
  swc1 $f0, 0($a0) #Almacenamos el radio en la dirección de radio

  # Calculamos el área

  li.s $f2, 3.14159 # Asignamos pi a f2
  li.s $f4, 4.0 # Asignamos 4 a f4
  mul.s $f2, $f2, $f4 #Asignamos 4pi a f2

  l.s $f4, radio # Asignamos el radio a f4
  mul.s $f12, $f4, $f4 # Asignamos a f12, radio^2

  mul.s $f12, $f2, $f12 # Metemos en f12 4pi*radio^2
  swc1 $f12, 4($a0) # Almacenamos en area el area calculada

  #Imprimimos area
  la $a0, areaMsg # Metemos en a0 el mensaje a imprimir
  li $v0, 4		# Indicamos el código para imprimir un String
  syscall		# Hacemos la llamada al sistema

  li $v0, 2		# Indicamos el código para imprimir un float simple (El que esté en f12)
  syscall

  # Calculamos el volumen, vamos a aprovechar el cálculo anterior.
  # V = A*radio/3

  #Calculamos r/3

  li.s $f2, 3.0
  div.s $f4, $f4, $f2 #Metemos en f4 radio/3
  mul.s $f12, $f12, $f4 # Metemos en f12 A*radio/3, o sea V.

  la $a0, vol #Almacenamos en $a0 la dirección de vol

  swc1 $f12, 0($a0) # Almacenamos en vol el volumen calculada

  #Imprimimos Volumen
  la $a0, volMsg # Metemos en a0 el mensaje a imprimir
  li $v0, 4		# Indicamos el código para imprimir un String
  syscall		# Hacemos la llamada al sistema

  li $v0, 2		# Indicamos el código para imprimir un float simple (El que esté en f12)
  syscall

  #Imprimimos mensaje final

  la $a0, endMsg # Metemos en a0 el mensaje a imprimir
  li $v0, 4		# Indicamos el código para imprimir un String
  syscall		# Hacemos la llamada al sistema

  # Exit call

  li $v0, 10		# Indicamos el código para terminar el programa
  syscall		# Hacemos la llamada al sistema

  # Fin
