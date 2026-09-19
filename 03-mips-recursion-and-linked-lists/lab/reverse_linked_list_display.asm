# CS224 Computer Organization - Lab 3, Section 1
# Atakan Akar (22203140)
# Date: 16.10.2024
# Lab work: Part 2 - Display Linked List in Reverse Order Recursively

.data
sizeInput:
	.asciiz	"\nEnter the size of the linked list: "
productNumberInput:
	.asciiz	"\nEnter the product number: "
askForHowManySold:
	.asciiz	"\nEnter how many sold: "
stringForFirst:
	.asciiz	"-->("
stringForVırgul:
	.asciiz	","
stringForKapanis:
	.asciiz	")"
stringForBosluk:
	.asciiz "\n"

	.text
main:

	li   $v0, 4
    	la   $a0, sizeInput
    	syscall
    	li   $v0, 5
    	syscall
    	move $s0, $v0  #s0 da linked listin sizeı var
    	move $a0, $s0
    	jal inputForLinkedList
    	move $a0,$v1
    	move $s0,$a0
    	jal printLinkedList
    	li   $v0, 4
    	la   $a0, stringForBosluk
    	syscall
    	move $a0,$s0
    	jal recursivePrint

    	li   $v0, 10
    	syscall

recursivePrint:
    	addi $sp,$sp,-8
    	sw $a0,4($sp)
    	sw $ra,0($sp)
    	bne $a0,$zero,else
    	addi $sp,$sp,8
    	jr $ra
else:
	lw $s0,0($a0)
	move $a0,$s0
	jal recursivePrint
	lw $a0,4($sp)
	lw $ra,0($sp)
	lw $s1,4($a0)
	lw $s2,8($a0)
	la $a0, stringForFirst

	li	$v0, 4
	syscall

	move	$a0, $s1
	li	$v0, 1
	syscall

	la	$a0, stringForVırgul
	li	$v0, 4
	syscall

	move	$a0, $s2
	li	$v0, 1
	syscall

	la	$a0, stringForKapanis
	li	$v0, 4
	syscall

	addi $sp,$sp,8
	jr $ra

inputForLinkedList:

	addi	$sp, $sp, -36
	sw	$s7, 32($sp)
	sw	$s6, 28($sp)
	sw	$s5, 24($sp)
	sw	$s4, 20($sp)
	sw	$s3, 16($sp)
	sw	$s2, 12($sp)
	sw	$s1, 8($sp)
	sw	$s0, 4($sp)
	sw	$ra, 0($sp)

	move	$s0, $a0 #s0 da artık linked listin size ı var
	addi	$s1,$zero,1
	blt	$s0, $s1, allDoneLast

	li	$a0, 12
	li	$v0, 9
	syscall

	addi 	$s0,$s0,-1
	move	$s2, $v0	# $s2 de artık heade point ediyor
	move	$s3, $v0	# $s3 su anda heade point ediyor ancak sonradan iterator olarak kullanılacak

	li   $v0, 4
    	la   $a0, productNumberInput
    	syscall    #node a gelcek urun nosunu input olarak sormak için string bastır

    	li   $v0, 5
    	syscall #su anda $v0 da yerleştirilecek olan numaranın değeri var
    	sw $v0,4($s3)

    	li   $v0, 4
    	la   $a0, askForHowManySold

    	syscall    #node a gelcek urun nosunu kac tane sattığını input olarak sormak için string bastır

    	li   $v0, 5
    	syscall #su anda $v0 da yerleştirilecek olan numaranın kac tane sattıgı var var

    	sw $v0,8($s3)

addNode:

    	beq	$s0, $zero, allDone
    	addi 	$s0,$s0,-1
    	li	$a0, 12
	li	$v0, 9
	syscall

	sw	$v0, 0($s3)
	move 	$s3,$v0

	li   $v0, 4
    	la   $a0, productNumberInput

    	syscall    #node a gelcek urun nosunu input olarak sormak için string bastır

    	li   $v0, 5

    	syscall #su anda $v0 da yerleştirilecek olan numaranın değeri var

    	sw $v0,4($s3)

    	li   $v0, 4

    	la   $a0, askForHowManySold

    	syscall    #node a gelcek urun nosunu kac tane sattığını input olarak sormak için string bastır

    	li   $v0, 5

    	syscall #su anda $v0 da yerleştirilecek olan numaranın kac tane sattıgı var var

    	sw $v0,8($s3)

	j addNode

allDone:

    	sw $zero, 0($s3)

    	move $v0,$s3

    	move $v1,$s2

allDoneLast:

	lw	$ra, 0($sp)

	lw	$s0, 4($sp)

	lw	$s1, 8($sp)

	lw	$s2, 12($sp)

	lw	$s3, 16($sp)

	lw	$s4, 20($sp)

	lw	$s5, 24($sp)

	lw	$s6, 28($sp)

	lw	$s7, 32($sp)

	addi	$sp, $sp, 36

	jr	$ra

printLinkedList:

	addi	$sp, $sp, -20

	sw	$s3, 16($sp)

	sw	$s2, 12($sp)

	sw	$s1, 8($sp)

	sw	$s0, 4($sp)

	sw	$ra, 0($sp)

	move $s0, $a0 #s0 da ilk nodun adresi var

printTheNextNode:

	beq $s0,$zero,printFinish

	lw $s1,0($s0)#s1 de diğer node var

	lw $s2,4($s0)#s2 de no var

	lw $s3,8($s0)#s3 de kac tane satıldıgı var

	la	$a0, stringForFirst

	li	$v0, 4

	syscall

	move	$a0, $s2

	li	$v0, 1

	syscall

	la	$a0, stringForVırgul

	li	$v0, 4

	syscall

	move	$a0, $s3

	li	$v0, 1

	syscall

	la	$a0, stringForKapanis

	li	$v0, 4

	syscall

	move $s0,$s1
	j printTheNextNode

printFinish:

    	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
