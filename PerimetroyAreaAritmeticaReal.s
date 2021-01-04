# Programa que calcula área y perímetro de un círculo
# ---------------------------------------------------
# Segmento de datos

.data 0x10000000

radio:		.float  7.0		# Radio del círculo
		.align 2		# Alinea para 2^2=4 bytes
perimetro:	.space 4		# Perímetro del círculo
area:		.space 4		# Área del círculo
msg1:		.asciiz "Perímetro: "
msg2:		.asciiz "\nÁrea: "
msg3:		.asciiz "\nFin\n"
# ---------------------------------------------------------
# Segmento de código

		.globl main
		.text 0x00400000

		.ent main
main:
		la $t0, radio	# Obtiene dirección del radio
		lwc1 $f0, 0($t0)	# Lee el radio de memoria
		li.s $f2, 3.1415	# PI
		li.s $f4, 2.0

# ---------------------------------
# Cálculo e impresión del perímetro

		mul.s $f4, $f4, $f2	# 2.0*PI
		mul.s $f4, $f4, $f0	# 2.0*PI*radio

		la $t0, perimetro 	# Obtiene dirección del perímetro
		swc1 $f4, 0($t0)	# Escribe el perímetro en memoria

		la $a0, msg1		# Obtiene dirección del msg1
		li $v0, 4		# print_string
		syscall		# Imprime el msg1

		mov.s $f12, $f4	# Copia el perímetro en $f12
		li $v0, 2		# print_float
		syscall		# Imprime el perímetro

# ----------------------------
# Cálculo e impresión del área

		mul.s $f4, $f2, $f0	# PI*radio
		mul.s $f4, $f4, $f0	# PI*radio*radio

		la $t0, area		# Obtiene dirección del área
		swc1 $f4, 0($t0)	# Escribe el área en memoria

		la $a0, msg2		# Obtiene dirección del msg2
		li $v0, 4		# print_string
		syscall		# Imprime el msg2

		mov.s $f12, $f4 	# Pone el área en $f12
		li $v0, 2		# print_float
		syscall		# Imprime el área

# ----------------
# Fin del programa

		la $a0, msg3		# Obtiene dirección del msg3
		li $v0, 4		# print_string
		syscall		# Imprime el msg3

		li $v0, 10		# exit
		syscall		# Finaliza la ejecución
