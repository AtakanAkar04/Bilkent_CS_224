# CS224 Computer Organization - Lab 1, Section 1
# Atakan Akar (22203140)
# Date: 09.10.2024
# Lab work: Part 3 - Fibonacci Question

##
##	Program3.asm is a loop implementation
##	of the Fibonacci function
##

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text

# execution starts here
	li $a0,7	# to calculate fib(7)
	#flb->fib olmalı
	jal fib		# call fib
	move $a0,$v0	# print result
	li $v0, 1
	syscall

	la $a0,endl	# print newline
	#must be endl not end syntax error
	li $v0,4
	syscall

	li $v0,10
	#must be 10 not 100 t finish the execution
	syscall	# bye bye

#------------------------------------------------

fib:	move $v0,$a0	# initialise last element
	addi $t2,$t2,2
	blt $a0,$t2,done	# fib(0)=0, fib(1)=1
	#must also be a register

	li $t0,1	# second last element
	li $v0,0	# last element
	#the values must be reversed
loop:	add $t1,$t0,$v0	# get next value
	#dollar sign is missing
	move $t0,$v0	# update second last
	move $v0,$t1	# update last element
	addi $a0,$a0,-1	# decrement count
	#must be -1 and addi
	bgt $a0,$zero,loop	# exit loop when count=0
	# must be zero register $zer0 not zero
done:	jr $ra

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
endl:	.asciiz "\n"

##
## end of Program3.asm
