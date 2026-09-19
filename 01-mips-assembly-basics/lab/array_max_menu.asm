# Array Maximum Menu
#
# Reads an array, then offers a menu to:
#   1. find the maximum element,
#   2. count how many times the maximum appears,
#   3. count the other elements that divide the maximum evenly.
#
# Author: Atakan Akar

.data
question1:
	.asciiz "Enter the size of the array:"
question2:
	.asciiz "Enter the number:"
menu:
	.asciiz "\n1)Find the maximum number stored in the array and display that number.\n2)Find the number of times the maximum number appears in the array.\n3)Find how many numbers we have (other than the maximum number) that we can divide the maximum number without a remainder.\n4)Quit.\n"
choice:
	.asciiz "Enter Choice:"
size: 	.word 0
	.align 4
array:  .space 400

	.text
	la $a0,question1
	li $v0,4
	syscall

	li $v0, 5
	syscall
	sw $v0, size

	lw $t0,size
	la $t1, array
	addi $t2,$zero,0
	beq $zero,$t0,done

loopForNumberInput:

	la $a0,question2
	li $v0,4
	syscall

	li $v0, 5
	syscall

	sw $v0, 0($t1)
	addi $t1,$t1,4
	#sw $v0, size
	addi $t2,$t2,1
	bne $t2,$t0,loopForNumberInput

menuLoop:
	addi $t0,$zero,1
	addi $t1,$zero,2
	addi $t2,$zero,3
	addi $t3,$zero,4

	la $a0,menu
	li $v0,4
	syscall

	li $v0, 5
	syscall

	move $t4,$v0
	beq $t4,$t0,maxNumberCounterJr
	j jump1
maxNumberCounterJr:
	jal maxNumberCounter
	move $a0, $v1
	li $v0, 1
	syscall
jump1:
	beq $t4,$t1,appearJr
	j jump2
appearJr:
	j appear
jump2:
	beq $t4,$t2,findDividents
jump3:

	bne $t4,$t3,menuLoop

done:

maxNumberCounter:
	la $t0,array
	lw $v1,0($t0)
	lw $t2, size
	addi $t3, $zero,0
loopForTraversal:

	lw $t5,0($t0)
	slt $t4,$t5,$v1
	beq $t4,$zero,changeTheMax
	j doNotChangeMax
changeTheMax:
	move $v1,$t5
doNotChangeMax:
	addi $t0,$t0,4
	addi $t3,$t3,1
	bne $t2,$t3,loopForTraversal
	jr $ra

appear:
	jal maxNumberCounter
	move $s0,$v1
	la $t0,array
	addi $s2,$zero,0
	lw $t2, size
	addi $t3, $zero,0

loopForCounting:
	lw $t4,0($t0)
	addi $t0,$t0,4
	addi $t3,$t3,1
	beq $t4,$s0,increment
	j doNotIncrement
increment:
	addi $s2,$s2,1
doNotIncrement:
	bne $t2,$t3,loopForCounting
	move $a0, $s2
	li $v0, 1
	syscall
	j jump2

findDividents:
	jal maxNumberCounter
	move $s0,$v1
	la $s7,array
	addi $s2,$zero,0
	lw $t2, size
	addi $s5,$zero,0
loopForDividentsTraversal:
	lw $s6,0($s7)
	beq $s6,$zero,doNotPrint
	move $a1,$s6
	move $a0,$s0
	jal mod
	lw $t2, size
	move $s1,$v0
	beq $s6,$v1,doNotPrint
	bne $s1,$zero,doNotPrint
	addi $s5,$s5,1
doNotPrint:
	addi $s2,$s2,1
	addi $s7,$s7,4
	bne $s2,$t2,loopForDividentsTraversal
	move $a0, $s5
	li $v0, 1
	syscall
	j jump3

mod:
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
	bne $t2, $zero, endLoopForMod
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
