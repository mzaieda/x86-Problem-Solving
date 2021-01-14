.data
	string: .space 20 
	var_ask_char: .asciiz "Enter the number of characters in the string (must match): \n"
	var_ask_string: .asciiz "Enter the string: "
	var_isPalin:  .asciiz "\nIs Palindrome\n"
	var_notPalin:  .asciiz "\nIs not Palindrome\n"

.text
	#print the ask string
	li $v0, 4
	la $a0, var_ask_char
	syscall
	
	#read from the user the number of character in the string
	li $v0, 5
	syscall
	move $s0, $v0
	move $s1, $s0			#for later use
	addi $s0, $s0, 1		#including the null character
	
	#print the ask string
	li $v0, 4
	la $a0, var_ask_string
	syscall
	
	#read from the user the string
	li $v0, 8
	la $a0, string
	move $a1,$s0
	syscall
		
	
	li $t3, 2		
	li $t4, 0
	div $s1, $t3
	mflo $s7		#getting half of the string stored in ns7
	la $s3, string		#s3 pointing at the string 
	add $s4,$s3,$s0		#s4 poiting at the end of the string
	sub $s4, $s4, 2		#after the sub
	div $s0, $t3
	mflo $s2
	lbu $t8, ($s3)
	lbu $t9, ($s4)
	beq $t8, $t9, loop	#checks to enter the loop of checking
	j notPalin		
	
	li $s5, 1
	loop:
	add $s3, $s3, 4		#getting the next char
	sub $s4, $s4, 4		#getting the next char from behind
	lbu $t5, ($s3)		#loading the byte in temp reg
	lbu $t6, ($s4)
	beq $s5, $s7, palin	#is palin when the counter reaches half of the word
	add $s5, $s5, 1		#incrementing the counter
	beq $t5, $t6, loop	#looping over every char
	j notPalin		#else is not palin
	
	#printing the palin string and exiting	
	palin:
	li $v0, 4
	la $a0, var_isPalin
	syscall
	li $v0, 10
	syscall
	
	notPalin:
	li $v0, 4		#printing it is not a palindrome
	la $a0, var_notPalin	
	syscall
	la $t0, string		#getting the begining of the string
	add $t1, $s0, $t0	#getting the end of the string
	sub $t1, $t1, 2		#with the null character put in consideration
	li $t2, 0
	li $t3, 2
	div $s1, $t3
	mflo $s7		#half of the string
	plz:
	lbu $s4, ($t0)		#storing it in temo reg
	lbu $s5, ($t1)		#storing it in temo reg
	bne $s4, $s5, replace	#replacing the character to make it palin
	beq $t2, $s7, print	#print if the counter reached half of the word
	add $t2, $t2, 1		#incermeninting the counter
	add $t0, $t0, 4		#moving the pointer front
	sub $t1, $t1, 4		#moving the pointer backwards
	j plz			#loop again 
	
	
	replace:
	sb $s4, ($t0)		#replacing the character with the other
	sb $s4, ($t1)		#to double check they are the same
	j plz
	
	#printing the string and exiting
	print:
	li $v0, 4
	la $a0, string
	syscall
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
