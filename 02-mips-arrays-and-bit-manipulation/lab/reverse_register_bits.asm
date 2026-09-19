# CS224 Computer Organization - Lab 2, Section 1
# Atakan Akar (22203140)
# Date: 16.10.2024
# Lab work: Part 2 - Reversing Register Question

.data
askWether:
	.asciiz "\nDo you want to continue reverse operation( Enter 1 for yes 0 for no):"
enterOne:
	.asciiz "\nEnter the register:"
result:
	.asciiz "\nAfter reversing the result:"
	.text
main:
	jal askTheRegister
	move $a0,$v0

	jal loopForReversing

	li $v0, 4
    	la $a0, askWether
    	syscall

    	li $v0, 5
    	syscall
   	move $s0, $v0

	bne $s0,$zero,main

	li $v0, 10
    	syscall

askTheRegister:
	addi $sp,$sp,8
	sw $ra,4($sp)
	sw $s0,0($sp)

	li $v0, 4
    	la $a0, enterOne
    	syscall

    	li $v0, 5
    	syscall
    	move $s0, $v0

    	move $a0, $s0

    	li $v0, 34
    	syscall

	move $v0,$s0
 	lw $s0,0($sp)
   	lw $ra,4($sp)
   	addi $sp,$sp,8

   	jr $ra

loopForReversing:

	addi $sp,$sp,-28
	sw $ra,24($sp)
	sw $s5,20($sp)
	sw $s4,16($sp)
	sw $s3,12($sp)
	sw $s2,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)

	move $s0,$a0

	addi $s1,$zero,31 #32 i biti sayacak olan şey
	addi $s2,$zero,0 #s2 resultı tutacak

loop:
	beq $s1,$zero,stop
	andi $s3,$s0,1
	add $s2,$s2,$s3
	sll $s2,$s2,1
	srl $s0,$s0,1
	addi $s1,$s1,-1
	j loop

stop:

	li $v0, 4
    	la $a0, result
    	syscall

    	move $a0, $s2
    	li $v0, 34
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
