# Suma de los cuadrados de los primeros 10 números naturales
# ----------------------------------------------------------
			.text 0x00400000
			.globl main

			.ent main
main:
			li   $t0, 10 			# límite n
			li.s $f2, 0.0			# suma parcial a cero
			li   $t1, 0			# contador i a cero
bucle:
			addi 	   $t1, $t1, 1		# i++
			mtc1 	   $t1, $f4		# copia i en $f4
			cvt.s.w $f4, $f4			# (float)i
			mul.s   $f4, $f4, $f4		# cálculo de i * i
			add.s   $f2, $f2, $f4		# incremento suma

			bne $t1, $t0, bucle		# sale si contador = n+1

			li $v0, 10				# exit
			syscall 				# fin del método main

			.end main
