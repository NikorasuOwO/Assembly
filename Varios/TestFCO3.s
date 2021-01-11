.data 0x10000000
lado:    .word 6
.text 0x00400000
.globl __start

__start: la $t0, lado
lw $t1, 0($t0)
li $t2, 4
mult $t1, $t2
mflo $v0
