## Sample execution blocks including new instructions

## To test an instruction, assemble the code block and place it in imem module. 
## All blocks start at address 0x0

## bcon example
addi $a0, $zero, 2             
addi $a1, $zero, 9
addi $a2, $zero, 3
sub $a1, $a1, $a0
bcon $a2, $a1, 2		# shouldn't take this branch as $a1 is not word-aligned
add $a1, $a1, 1
add $a2, $a2, 1
bcon $a2, $a1, -2       # taken when $a1 = $a2 + 4 and $a1 MOD 4 = 0
add $a2, $a2, $a1       # $a2 = 5 + 9 = 14

## bncon example
addi $a0, $zero, 1             
addi $a1, $zero, 10
addi $a2, $zero, 5
sub $a1, $a1, $a0
bncon $a2, $a1, 4		# taken since $a1 = $a2 + 4 but $a1 is not word-aligned
addi $a1, $a1, -1
addi $a2, $a2, -1
bncon $a2, $a1, -2      # taken when $a1 != $a2 + 4 or $a1 MOD 4 != 0
add $a2, $a2, $a1       # $a2 = 5 + 9 = 14

## jaladd example
addi $a0, $zero, 0x08
addi $a1, $zero, 0x08
jaladd $a0, $a1         # Jumps to address 0x10
addi $a2, $zero, 3      # Not executed
addi $ra, $ra, 6        # Jumped to here
addi $a2, $ra, 0		# here to show the value of $ra, should be 0x0E (14)

## jalsub example
addi $a0, $zero, 0x18
addi $a1, $zero, 0x08
jalsub $a0, $a1         # Jumps to address 0x10
addi $a2, $zero, 3      # Not executed
addi $ra, $ra, 6        # Jumped to here
addi $a2, $ra, 0	    # here to show the value of $ra, should be 0x0E (14)

## ror example
addi $t0, $zero, 0x0F0F
ror $t1, $t0, 3 # $t1 should be 0xE00001E1
addi $t2, $t1, 2

## spc example
spc 40($zero)
lw $t0, 40($zero)
addi $t0, $t0, 8 # at this point pc and aluout should be equal

## sw+ example
addi $a0, $zero, 0x50 
addi $a1, $zero, 1 
addi $a2, $zero, 16
beq $a1, $a2, 3         # not taken for $a1 = 1,2,4,8. taken for $a1 = 16
sw+ $a1, 0($a0)         # stores 1,2,4,8 into 0x50, 0x54, 0x58, 0x5c 
sll $a1, $a1, 1         # $a1 = $a1 * 2
j 0xc
add $a3, $zero, $a0     # $a3 = $a0 = 0x60

## xnori example
addi $t0, $t0, 1
addi $t1, $zero, 0xFF00	# sign extended to 0xFFFFFF00
addi $t0, $zero, 0x7051
xnori $t1, $t1, 0x80AF # $t1 has 0x00007050
addi $t1, $t1, 1
sub $t2, $t1, $t0 # result should be 0


