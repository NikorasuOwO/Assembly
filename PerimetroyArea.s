
# Programa que calcula área y perímetro de un círculo
# ---------------------------------------------------
# Segmento de datos

		.data 0x10000000
radio:		.word  7		# Radio del círculo
		.align 2		# Alinea para 2^2=4 bytes
perimetro:	.space 4		# Perímetro del círculo
area:		.space 4		# Área del círculo
msg1:		.asciiz "Perimetro: "
msg2:		.asciiz "\nArea: "
msg3:		.asciiz "\nFin\n"

# ---------------------------------------------------------
# Segmento de código

		.globl main
		.text 0x00400000

		.ent main
main:
		la $t0, radio	# Obtiene dirección del radio
		lw $s0, 0($t0)	# Lee el radio de memoria, lo asigna a s0
		li $t1, 31415	# PI con 4 cifras fraccionarias
		li $t2, 2

# ---------------------------------
# Cálculo e impresión del perímetro

		mult $t1, $t2	# 2*PI
		mflo $t2
		mult $t2, $s0	# 2*PI*radio
		mflo $t2

		la $t0, perimetro 	# Obtiene dirección del perímetro
		sw $t2, 0($t0)	# Escribe el perímetro en memoria

		la $a0, msg1		# Obtiene dirección del msg1
		li $v0, 4		# print_string
		syscall		# Imprime el msg1

		move $a0, $t2	# Pone perímetro en $a0
		li $v0, 1		# print_int
		syscall		# Imprime el perímetro

# ----------------------------
# Cálculo e impresión del área

		mult $t1, $s0	# PI*radio
		mflo $t2
		mult $t2, $s0	# PI*radio*radio
		mflo $t2

		la $t0, area		# Obtiene dirección del área
		sw $t2, 0($t0)	# Escribe el área en memoria

		la $a0, msg2		# Obtiene dirección del msg2
		li $v0, 4		# print_string
		syscall		# Imprime el msg2

		move $a0, $t2 	# Pone el área en $a0
		li $v0, 1		# print_int
		syscall		# Imprime el área

# ----------------
# Fin del programa

		la $a0, msg3		# Obtiene dirección del msg3
		li $v0, 4		# print_string
		syscall		# Imprime el msg3

		li $v0, 10		# exit
		syscall		# Finaliza la ejecución

		.end main
