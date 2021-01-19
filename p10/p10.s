

# Segmento de datos

.data 0x10000000
  testOtro: .space 4
  test: .byte 80

# Segmento de código

		.globl main
		.text 0x00400000

		.ent main

main: # Método main

andi $17, $0, 1
beq $17, $0, salir

salir:
  li $v0, 10
  syscall
