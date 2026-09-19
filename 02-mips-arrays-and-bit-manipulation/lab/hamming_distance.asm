# Hamming Distance
#
# Reads two integers, prints every bit position where they differ and
# the total number of differing bits. Repeats until the user enters 0.
#
# Author: Atakan Akar

.data
askWether:
	.asciiz "Do you want to continue calculate hamming distance between two registers( Enter 1 for yes 0 for no):"
enterOne:
	.asciiz "\nEnter the first register:"
enterTwo:
	.asciiz "\nEnter the second register:"
mesajAnlamlı:
	.asciiz "\nTwo register have different value at index:"
result:
	.asciiz "\nTotal difference:"
	.text
main:
	jal askTheRegisters
	move $a0,$v0
	move $a1,$v1

	jal loopForHamming

	li $v0, 4
    	la $a0, askWether
    	syscall

    	li $v0, 5
    	syscall
   	move $s0, $v0

	bne $s0,$zero,main

	li $v0, 10
    	syscall

askTheRegisters:
	addi $sp,$sp,-12
	sw $ra,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)

	li $v0, 4
    	la $a0, enterOne
    	syscall

    	li $v0, 5
    	syscall
    	move $s0, $v0

    	li $v0, 4
    	la $a0, enterTwo
    	syscall

        li $v0, 5
    	syscall
   	move $s1, $v0

   	move $v1,$s1
   	move $v0,$s0

    	move $a0, $v0
    	li $v0, 34
    	syscall

        move $a0, $v1
    	li $v0, 34
    	syscall

    	move $v1,$s1
   	move $v0,$s0

   	lw $s0,0($sp)
   	lw $s1,4($sp)
   	lw $ra,8($sp)
   	addi $sp,$sp,12

   	jr $ra

loopForHamming:

	addi $sp,$sp,-28
	sw $ra,24($sp)
	sw $s5,20($sp)
	sw $s4,16($sp)
	sw $s3,12($sp)
	sw $s2,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)

	move $s0,$a0
	move $s1,$a1

	xor $s2,$s0,$s1

	addi $s3,$zero,0
	addi $s5,$zero,0
loopForCounting:
	beq $s3,32,stopCounting
	andi $s4,$s2,1
	bne $s4,1,doNotIncrementTheValue
	li $v0, 4
    	la $a0, mesajAnlamlı
    	syscall

    	li $v0, 1
    	move $a0,$s3
    	syscall
    	addi $s5,$s5,1

doNotIncrementTheValue:
	addi $s3,$s3,1
	srl $s2,$s2,1
	j loopForCounting

stopCounting:
	li $v0, 4
    	la $a0, result
    	syscall

	li $v0, 1
    	move $a0,$s5
    	syscall

	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)
	lw $ra,24($sp)
	addi $sp,$sp,28

	jr $ra
