# ------------------------------------------------------------------
# Programa que calcula índices estadísticos de n medidas

# ------------------------------------------------------------------
# Segmento de datos

			.data 0x10000000
medidas:		.float 1.0, 2.0, 3.0, 4.0, 5.0
n:		    	.byte 5
			      .align 2
media:		  .space 4
varianza:		.space 4
msg1:			  .asciiz "Media aritmética: "
msg2:			  .asciiz "\nVarianza: "

# ------------------------------------------------------------------
# Segmento de código

			.globl main
			.text 0x00400000

			.ent main
main:

# -------------------------------------------------
# Cálculo de la media aritmética

			la $t0, n			# dirección de dimensión
			lbu $t1, 0($t0)		# lee dimensión (natural)
			mtc1 $t1, $f0		# copia dimensión en $f0
			cvt.s.w $f0, $f0		# casting: (float)n

			la $t0, medidas		# dirección del vector
			li.s $f2, 0.0		# suma = 0.0

bucle1:		lwc1 $f4, 0($t0)		# lee medidas[i]
			add.s $f2, $f2, $f4	# incrementa la suma

			addiu $t0, $t0, 4		# incrementa dirección
			addiu $t1, $t1, -1	# decrementa contador
			bne $t1, $zero, bucle1	# salta si quedan medidas

			div.s $f2, $f2, $f0	# media = suma / n

			la $t0, media		# dirección de media
			swc1 $f2, 0($t0)		# almacenamiento de media

# -------------------------------------------------
# Impresión de la media aritmética

			la $a0, msg1
			li $v0, 4			# print_string
			syscall

			mov.s $f12, $f2
			li $v0, 2			# print_float
			syscall

# -------------------------------------------------
# Cálculo de la varianza poblacional

	lbu $t1, n # Guardamos n en t0. # Nuestro contador inverso empieza a n.
	mtc1 $t1, $f0 # Ponemos el contenido de t0 en f0
	cvt.s.w $f0, $f0 # Cambiamos el formato a IEE754
	#La media está en f12
	la $t0, medidas
	mtc1 $zero, $f1 # Nuestro regisro suma empieza a 0

	# n => f0
	# media => f12
	# Elemento -> f2
	# Suma => f1


BucleVarianza:

	lwc1 $f2, 0($t0) #Cargamos el valor de lo que haya en la dirección t0 en f2

	sub.s $f2, $f2, $f12 #Hacemos dato-media y ponemos la resta en f2
	mul.s $f2, $f2, $f2 # Ponemos en f2 su cuadrado.
	add.s $f1, $f1, $f2 # Actualizamos el registro suma, sumandole f2.

	addiu $t0, $t0, 4		# incrementa dirección
	addiu $t1, $t1, -1	# decrementa contador

	bne $t1, $zero, BucleVarianza	# salta si quedan medidas

# Cuando ya se han sumado todas las restas al cuadrado, dividimos por n:

	div.s $f12, $f1, $f0 # Ponemos el cociente en $12 para que sea más fácil imprimir

	la $t1, varianza # Cargamos la dirección de la variable varianza en t1
	swc1 $f12, 0($t1) # cargamos el valor de la varianza en la dirección de memoria de la variable.

# -------------------------------------------------

# Impresión de la varianza
	li $v0, 4 # Cargamos código para imprimir un string
	la $a0, msg2 # Cargamos dirección del string en a0
	syscall # Imprimimos String

 li $v0, 2 # Cargamos el código para imprimir un print_float
 syscall # Imprime lo que haya en f12!

# -------------------------------------------------
salir:

			li $v0, 10			# exit
			syscall
