		 .globl __start
         .text 0x00400000
__start: li $t0,75369
         li $t1,12976
         add $s0,$t1,$t0
         add $s0,$s0,$s0

# 4 inst maquina
# li -> ori
# add $s0,$s0,$s0 :: 0x0040000c
# 0x01288020 es la traducción de add $16, $9, $8
# Result(30, 25) = 0x0000006e (110)
# Result(75369, 12976) = 0x0002b232
  # el primer li se traduce como una lui y una ori:
	  #lui $1, 1
		#ori $8, $1, 9833 
