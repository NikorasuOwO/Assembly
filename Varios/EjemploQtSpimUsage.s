.globl main
.text 0x00400000

.ent main
main:

  addi $8, $0, 11 #Inicializamos $8 a 11
  addi $9, $0, 4 #Inicializamos $9 a 4

  div $8, $9   #Dividimos 11 por 4
  mflo $10 #El cociente va a $10
  mfhi $11 #El resto va a $11

  li $v0, 10 #Metemos "10" en v0, indicando que queremos salir.
  syscall #Llamamos al sistema, Sistema despierta! Quiero salir!
.end
