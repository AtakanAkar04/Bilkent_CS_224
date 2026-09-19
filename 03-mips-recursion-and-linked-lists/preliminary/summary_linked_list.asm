# Summary Linked List
#
# Builds a linked list of (product number, units sold) sales records and
# generates a new list that combines the records of each product.
#
# Author: Atakan Akar

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
bosluk:
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
    	move $a0,$s0
    	jal resulList
    	jal printLinkedList

    	li   $v0, 10
    	syscall

resulList:
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

	addi $s0,$zero,0 #s0 da yeni linked listin size ı var
	move $s1,$a0 #s1 de eski linked listin adresi var

createNode:

	beq $s0,$zero,firstCreated
	j notFirst
firstCreated:
	li	$a0, 12
	li	$v0, 9
	syscall
	move $s6,$v0
	sw $zero,8($s6)
	move $s7,$s6 #s7 hep baslangıc adresini tasıyacak
	addi	$sp, $sp, -4
	sw	$s7, 0($sp)

	j itIsFirst
notFirst:
	li	$a0, 12
	li	$v0, 9
	syscall
	sw $v0,0($s6)
	move $s6,$v0
	sw $zero,8($s6)

itIsFirst:
	addi $s0,$s0,1

	lw $s3,4($s1)
	sw $s3,4($s6)
iterateInFirstLinkedList:
	lw $s2,0($s1)
	lw $t0,4($s1)

	bne $t0,$s3,stopIteration
	lw $s5,8($s6)
	lw $s7,8($s1)
	add $s5,$s5,$s7
	sw $s5,8($s6)

	beq $s2,$zero,stopCreating
	move $s1,$s2

	j iterateInFirstLinkedList
stopIteration:
	#beq $s2,$zero,stopCreating DUSUN
	#move $s1,$s2
	j createNode
stopCreating:
	lw $s7,0($sp)
	addi $sp,$sp,4
	move $a0,$s7
	sw	$zero,0($s6)
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
	li   $v0, 4
    	la   $a0, bosluk
    	syscall
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
