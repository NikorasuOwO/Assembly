# Suma de los cuadrados de los primeros 10 números naturales
# ----------------------------------------------------------
			.text 0x00400000
			.globl main

			.ent main
main:
			li $t0, 10 		# límite n
			li $s0, 0			# suma parcial a cero
			li $t1, 0			# contador i a cero
bucle:
			addi  $t1, $t1, 1	# i++
			multu $t1, $t1		# cálculo de i*i
			mflo  $t2			# resultado en $t2
			addu  $s0, $s0, $t2	# incremento suma parcial
			bne   $t1, $t0, bucle	# sale si contador = n+1

			li $v0, 10			# exit
			syscall 			# fin del método main

			.end main
