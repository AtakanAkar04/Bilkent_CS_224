# CS224 Computer Organization - Lab 3, Section 1
# Atakan Akar (22203140)
# Date: 16.10.2024
# Lab work: Part 1 - Recursive Division

.data
questionForNumber1:
	.asciiz "\nEnter the first number:"
questionForNumber2:
	.asciiz "\nEnter the second number:"
finish:
	.asciiz "\nProgram is finished!"

	.text
main:

	li   $v0, 4
    	la   $a0, questionForNumber1
    	syscall

    	li   $v0, 5
    	syscall

    	move $s0,$v0

	li   $v0, 4
    	la   $a0, questionForNumber2
    	syscall

    	li   $v0, 5
    	syscall

    	move $s1,$v0

    	beq $s0,$zero,end
    	beq $s1,$zero,end

    	move $a1,$s0
    	move $a0,$s1

    	jal division

    	move $s2,$v0

    	li   $v0, 1
    	move   $a0, $s2
    	syscall

    	j main

end:
	li   $v0, 4
    	la   $a0, finish
    	syscall

	li   $v0, 10
    	syscall

division:
	addi $sp,$sp,-12
	sw $a1,8($sp)
	sw $a0,4($sp)
	sw $ra,0($sp)
	beq $a1,$a0,else
	bgt $a1,$a0,else
	addi $v0,$zero,0
	addi $sp,$sp,12
	jr $ra

else:
	sub $a1,$a1,$a0
	jal division
	lw $a1,8($sp)
	lw $a0,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,12
	addi $v0,$v0,1
	jr $ra
