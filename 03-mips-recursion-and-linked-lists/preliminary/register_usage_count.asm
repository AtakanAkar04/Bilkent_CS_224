# CS224 Computer Organization - Lab 3, Section 1
# Atakan Akar (22203140)
# Date: 22.10.2024
# Preliminary work: Part 2 - Register Count

.data
question:
	.asciiz "\nwhich register:"

	.text
main:
	la $a1,main
	la $a2,end
	la $a0, question
    	li $v0, 4
    	syscall

    	li $v0, 5
   	syscall

   	move $a0,$v0 #s0 da artık hangi registerın sayılacağı var
   	add $s5,$s5,$s5

   	bgt $a0,31,done
   	blt $a0,0,done

   	jal countRegisters

   	move $a0,$v0
   	li $v0,1
   	syscall

   	j main

done:
	 li $v0, 10
   	 syscall

countRegisters:
start:
	addi	$sp, $sp, -36
	sw	$s7, 32($sp)
	sw	$s6, 28($sp)
	sw	$s5, 24($sp)
	sw	$ra  20($sp)
	sw	$s4, 16($sp)
	sw	$s3, 12($sp)
	sw	$s2, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)

	move $s0,$a0 #s0 istenen registerı tutuyı
	move $s1,$a1 #s1 baslangic maini tutuyo
	move $s2,$a2 #s2 son endi sutuyı
	li $t0,1
	addi $s3,$zero,0 #s3 total istenen register sayısını sayacak

countingLoop:
	beq $s1,$s2,endCountingLoop
	lw $s4,0($s1) #s4 te artık iterator gibi addreslerde iteratre edecek
	move $s5,$s4 #s5 temporary
	srl $s5,$s5,26

	beq $s5,$zero,rType
	beq $s5,3,jType
	beq $s5,2,jType
	j iType
rType:
	move $s5,$s4
	srl $s5,$s5,11
	andi $s5,$s5,31
	beq $s5,$s0,increment1
return1:
	move $s5,$s4
	srl $s5,$s5,16
	andi $s5,$s5,31
	beq $s5,$s0,increment2
return2:
	move $s5,$s4
	srl $s5,$s5,21
	andi $s5,$s5,31
	beq $s5,$s0,increment3

return3:
	j nextInstruction
increment1:
	addi $s3,$s3,1
	j return1
increment2:
	addi $s3,$s3,1
	j return2
increment3:
	addi $s3,$s3,1
	li $t0,1
	j return3
iType:
	move $s5,$s4
	srl $s5,$s5,16
	andi $s5,$s5,31
	beq $s5,$s0,increment1Itype
returnItype1:
	move $s5,$s4
	srl $s5,$s5,21
	andi $s5,$s5,31
	beq $s5,$s0,increment2Itype
returnItype2:
	j nextInstruction
increment1Itype:
	addi $s3,$s3,1
	j returnItype1
increment2Itype:
	addi $s3,$s3,1
	j returnItype2
jType:

nextInstruction:
	addi $s1,$s1,4
	j countingLoop

endCountingLoop:
	move $v0,$s3

	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3  12($sp)
	lw	$s4, 16($sp)
	lw	$ra, 20($sp)
	lw	$s5, 24($sp)
	lw	$s6, 28($sp)
	lw	$s7, 32($sp)
	addi	$sp, $sp, 36
	jr $ra
end:
