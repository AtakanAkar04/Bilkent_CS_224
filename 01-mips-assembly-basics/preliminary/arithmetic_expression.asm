# CS224 Computer Organization - Lab 1, Section 1
# Atakan Akar (22203140)
# Date: 09.10.2024
# Preliminary work: Part 2 - arithmetic expression with division and mod subroutines

.data

A:	.word 0

B:	.word 0

C:	.word 0

D:	.word 0

questionB:

	.asciiz "Enter B:\n"

questionC:

	.asciiz "Enter C:\n"

questionD:

	.asciiz "Enter D:\n"

		.text

	la $a0,questionB

	li $v0,4

	syscall

	li $v0, 5

	syscall

	sw $v0, B

	la $a0,questionC

	li $v0,4

	syscall

	li $v0, 5

	syscall

	sw $v0, C

	la $a0,questionD

	li $v0,4

	syscall

	li $v0, 5

	syscall

	sw $v0, D

	lw $a0,B

	lw $a1,C

	jal division

	move $s0, $v0

	lw $a0,D

	lw $a1,B

	jal mod

	move $s1,$v0

	add $s2,$s1,$s0

	lw $t0,C

	sub $s3,$s2,$t0

	#s3 parantezin içini içeriyor

	lw $t1, B

	move $a0,$s3

	move $a1,$t1

	jal division

	move $a0, $v0

	li $v0, 1

	syscall

	li $v0, 10

	syscall

division:
	beq $a1,$zero,finish
	slt $t0,$a0,$zero #B 0dan küçük mü t0 a at

	slt $t1,$a1,$zero #C 0dan küçük mü t1 e at

	bne $t0, $zero,convertB

	j doNotConvertB

convertB:

	sub $a0,$zero,$a0

doNotConvertB:

	bne $t1, $zero,convertC

	j doNotConvertC

convertC:

	sub $a1,$zero,$a1

doNotConvertC:

	addi $v0,$zero,0 #s3 toplam bölüm sayısını tıtacak

divideBtoC:

   	slt $t2, $a0, $a1

    	bne $t2, $0, endLoop

    	sub $a0, $a0, $a1

    	addi $v0, $v0, 1

    	j divideBtoC

endLoop:

	xor $t2,$t1,$t0

	bne $t2,$zero,convertBtoCtoNegative

	j doNot

convertBtoCtoNegative:

	sub $v0,$zero,$v0

doNot:

	jr $ra

mod:
	beq $a1,$zero,finish
	slt $t0,$a0,$zero #B 0dan küçük mü t0 a at

	slt $t1,$a1,$zero #C 0dan küçük mü t1 e at

	bne $t0, $zero,convertBforMod

	j doNotConvertBforMod

convertBforMod:

	sub $a0,$zero,$a0

doNotConvertBforMod:

	bne $t1, $zero,convertD

	j doNotConvertD

convertD:

	sub $a1,$zero,$a1

doNotConvertD:

subtractToFindMod:

	slt $t2, $a0, $a1

	bne $t2, $0, endLoopForMod

	sub $a0, $a0, $a1

	j subtractToFindMod

endLoopForMod:

	addi $t4,$zero,1

	beq $t4,$t0,convertModToNegative

	j doNotConvertForMod

convertModToNegative:

	sub $a0,$zero,$a0

doNotConvertForMod:

	move $v0,$a0

	jr $ra

finish:
	li $v0, 10
	syscall
