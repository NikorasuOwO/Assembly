.globl __start
.data 0x10000000
var: .word 26
chain: .asciiz "cornonavirus"

__start:
la $t0, var
la $t1, chain
lw $s0, 0($t0)
lb $s1, 5($t1)

.end
