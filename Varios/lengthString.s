
### Programa que calcula la longitud de un String dado. Por defecto "Matrix" ###

# DATA

.data 0x10000000

cadena: .asciiz "Matrix"
longitud: .space 1

# --------------------------------------------------------------------------

# CODE

.text 0x00400000
.globl main

.ent main

 main:

  la $t0, cadena # Dirección de la cadena
  li $t1, 0 # Contador

bucle:

  lbu $t2, 0($t0) # Cargamos el byte, sin signo, porque no hay signo, es un ascii.
  beq $t2, $zero, salir # Si el byte es null, salimos!!
  addiu $t1, $t1, 1 # Nuestro contador es un natural, sumamos 1 en unsigned
  addiu $t0, $t0, 1 # Aumentamos la dirección, también sin signo porque es una dirección
  j bucle

salir: # SALIMOS

  la $t0, longitud
  sb $t1, 0($t0)

  li $v0, 10
  syscall
