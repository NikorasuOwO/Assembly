         .globl __start
         .data 0x1000000A
A:       .word 25
B:       .word 30
P:       .space 4
         .text 0x00400000
__start: la $t0,A
         la $t1,B
         la $t2,P
         lw $s0,0($t0)
         lw $s1,0($t1)
         add $s2,$s1,$s0
         add $s2,$s2,$s2
         sw $s2,0($t2)

         move $a0,$s2 # copia el perímetro en $a0
         li $v0,1 # código de print_int
         syscall # llamada al sistema

         ### Primera parte ###
         # 8
         # 3
         # 10000008
         # el primer la copia la primera dirección del programa, que es simplemente 0x10000000, o sea un uno y 31 ceros.
          # el segundo la ya no es un uno con muchos ceros sino 100...004
         # El .space 4 es para reservar 4 bytes i.e. un word, para poner luego el perímetro ahí.
         # 100..004
