.globl main
.text 0x00400000

.ent main
main:

addi $t0, $zero, -13
addi $t1, $zero, -57
addi $t2, $zero, 3
div $t0, $t2
mfhi $t0
mult $t0, $t1
mflo $v0

li $v0, 10 #Metemos "10" en v0, indicando que queremos salir.
syscall #Llamamos al sistema, Sistema despierta! Quiero salir!
.end
