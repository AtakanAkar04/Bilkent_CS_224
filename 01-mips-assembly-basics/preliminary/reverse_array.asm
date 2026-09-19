# CS224 Computer Organization - Lab 1, Section 1
# Atakan Akar (22203140)
# Date: 09.10.2024
# Preliminary work: Part 1 - read an array and reverse it in place

.data
question1:
	.asciiz "Enter the size of the array:"
question2:
	.asciiz "Enter the number:"

size: 	.word 0
	.align 4
array:  .space 80

	.text

	la $a0,question1
	li $v0,4
	syscall

	li $v0, 5
	syscall
	#la $t0, size
	sw $v0, size

	lw $s0,size
	la $s1, array
	addi $s2,$zero,0
	beq $zero,$s0,done

loop:
	la $a0,question2
	li $v0,4
	syscall

	li $v0, 5
	syscall
	sw $v0, 0($s1)
	addi $s1,$s1,4

	#sw $v0, size

	addi $s2,$s2,1
	bne $s2,$s0,loop

	addi $s1,$s1,-4

	la $s2, array

loopSecond:
	lw $t0, 0($s1)
	lw $t1, 0($s2)
	sw $t0, 0($s2)
	sw $t1, 0($s1)
	addi $s2,$s2,4
	addi $s1,$s1,-4
	ble $s1,$s2, endLoop
	j loopSecond
endLoop:

	lw $s0, size
	la $s1, array

printingLoop:
	lw $a0, 0($s1)
	li $v0, 1
	syscall
	addi $s1,$s1,4
	addi $s0,$s0,-1
	bne $s0,$zero,printingLoop

done:
	li $v0, 10
	syscall
