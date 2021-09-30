          .globl __start
		  .data 0x10000000
textoFin:  .asciiz "Se acabooooo \n"
textoSuma: 	  .asciiz "Suma: "
textoNumero: 	  .asciiz "numero: "
		  
          .text 0x00400000

__start:
          li $s0, 0
loop:
          li $v0,5
          syscall
		  beq $v0, $zero, fin
          addu $s0,$s0,$v0
		  
          la $a0, textoSuma
		  li $v0, 4
		  syscall
		  
          li $v0,1
          move $a0, $s0
          syscall
		  
		  
          li $v0,11
          li $a0, 10
          syscall
		  addi $s1, $s1, 1

          la $a0, textoNumero
		  li $v0, 4
		  syscall

		  li $v0, 1
		  move $a0, $s1
		  syscall
		  
          li $v0,11
          li $a0, 10
          syscall
		  
          b loop

fin:      la $a0, textoFin
		  li $v0, 4
		  syscall
		  
		  li $v0,10
          syscall
