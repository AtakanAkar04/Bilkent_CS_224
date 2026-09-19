# Formula Calculator
#
# Reads A, B and C and prints (A * B) mod C / (A - B).
# Reports a division-by-zero error and asks again when C = 0.
#
# Author: Atakan Akar

.data
A:	.word 0
B:	.word 0
C:	.word 0

questionA:
	.asciiz "Enter A:\n"
questionB:
	.asciiz "Enter B:\n"
questionC:
	.asciiz "Enter C:\n"
explanation:
	.asciiz "Result is equal to (a*b)modc/(a-b)\n"
divisionByZeroError:
	.asciiz "Division by zero error"

.text
loop:
    li $v0, 4
    la $a0, questionA
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, questionB
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 4
    la $a0, questionC
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    beq $t2,$zero,divisionByZero

	sub $s4,$t0,$t1
	beq $t4,$zero,divisionByZero
j doNot
divisionByZero:
li $v0, 4
    la $a0, divisionByZeroError
    syscall
    j loop
doNot:
    mult $t0, $t1
    mflo $s0 #so da a*b var

    div $s0, $t2
    mfhi $s1 #s1 de modun cevabı var

    sub $s2,$t0,$t1

    div $s1,$s2
    mflo $s3

    li $v0, 4
    la $a0, explanation
    syscall

    li $v0, 1
    move $a0,  $s3
    syscall
