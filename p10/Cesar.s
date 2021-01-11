# ------------------------------------------------------------------
# Programa que encripta un mensaje por medio del cifrado de César
# Solamente se cifran los símbolos del alfabeto en mayúsculas
# Alfabeto inglés: 26 letras, desde A (65=0x41) hasta Z (90=0x5A)

# ------------------------------------------------------------------
# Segmento de datos

			.data 0x10000000
textoplano:		.asciiz "Juan Carlos I de Borbon."
criptograma:		.space 50
clave:		.byte 3
msg1:			.asciiz "Texto plano: "
msg2:			.asciiz "\nCriptograma: "

# ------------------------------------------------------------------
# Segmento de código

			.globl main
			.text 0x00400000

			.ent main
main:

# -------------------------------------------------
# Impresión del texto plano del mensaje

			la $a0, msg1
			li $v0, 4		# print_string
			syscall

			la $a0, textoplano
			li $v0, 4		# print_string
			syscall

# -------------------------------------------------
# Lectura de memoria de la clave de cifrado

			la $t0, clave		# dirección de la clave
			lbu $s0, 0($t0)		# lectura de la clave

# -------------------------------------------------
# Creación del criptograma

			la $t0, textoplano		# dirección textoplano
			la $t1, criptograma	# dirección criptograma

bucle:		lbu $s1, 0($t0)		# lee el carácter
			beq $s1, $zero, salir	# ¿final del mensaje?

			# Ampliación del programa

			sltiu $t3, $s1, 65
			bne $t3, $zero, siguiente
			sltiu $t3, $s1, 91
			beq $t3, $zero, siguiente


			addu $s1, $s1, $s0		# aplica la clave
			sltiu $t2, $s1, 91		# ¿código < 91?
			bne $t2, $zero, siguiente  	# salta si código < 91
			addiu $s1, $s1, -26	   	# ajuste del código

siguiente:		sb $s1, 0($t1)		# almacena el carácter

			addiu $t0, $t0, 1		# incrementa dirección
			addiu $t1, $t1, 1		# incremente dirección

			j bucle			# vuelve al bucle

# -------------------------------------------------
# Impresión del criptograma

salir:		la $a0, msg2
			li $v0, 4			# print_string
			syscall

			la $a0, criptograma
			li $v0, 4			# print_string
			syscall

# -------------------------------------------------
# Fin de la ejecución del programa

			li $v0, 10				# exit
			syscall

			.end main
