
### SEGUNDO PROGRAMA EN ASSEMBLY: Evaluación de un Polinomio (1.1) ###

#Sea P(x) = 6x^2 - 3x + 15
#Sea X0 = 2
#¿Cuanto será P(X0)?

.data
.globl main

.text
.ent main

main:

  li $t0 2 #Le asignamos 2 a t0, será nuestro X0

  li $t2 6
  li $t1 3
  li $t6 15

  mult $t0, $t2
  mflo $t2
  mult $t0, $t2
  mflo $t2

  mult $t0, $t1
  mflo $t1 # t1 = 3*t0

  sub $t0, $t2, $t1 #t1 = t2 - t3 => t1 = 6*t0^2 - 3*t0
  add $t0, $t0, $t6 #Ponemos en t0, t1 + 15

  move $a0, $t0 #Ponemos el resultado en a0 para que el sistema pueda operar con él

  li $v0, 1 #Indicamos operación de print
  syscall #Sistema despierta, quiero imprimir lo que esté en a0!

  li $v0 10 #Indicamos operación salida
  syscall #Sistema, quiero salir!
