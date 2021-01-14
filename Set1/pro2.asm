.data
	ask_usr: .asciiz "Enter an integer number: "
	odd_s: .asciiz "This is an odd number. \n"
	even_s: .asciiz "This is an even number. \n"
	prime_s: .asciiz "This is an odd and prime number. \n"
.text
	#print the string to ask from the user
	li $v0, 4
	la $a0, ask_usr
	syscall
	
	#get the number from the user
	li $v0, 5
	syscall
	
	#saving the user entered in s0 (preserved)
	move $s0, $v0
	
	#applying the special cases of 0,1,2 
	#where 0 is even
	# 1 is odd
	# 2 is even and prime, and not odd, then it should be even only
	li $t1, 2
	li $t5, 0
	li $t6, 1
	beq $t1, $s0, even
	beq $t6, $s0, odd_only
	beq $t5, $s0, even
	
	#loop for the prime logic, else go to check if it is even only or odd
	while:
	div $s0, $t1			#dividing the number by 2
	add $t1, $t1, 1			#incrementing the $t1 (2) by 1
	mfhi $t2			#storing the remainder in t2
	beq $t1, $s0, prime		#if the counter is equal to the number then it has to be prime
	bnez $t2, while			#if the remainder is not zero then keep looping
	j check				#else check if it is odd or even
	
	
	#check if the number is odd or even
	check:
	li $t3, 2			#store 2 in t3
	div $s0, $t3			#divide the number by 2
	mfhi $t4			#store the remainder in t4
	bnez $t4, odd_only		#if the remainder is not 0 then it has to be odd
	beq $t4, $zero, even 		#else it is even
	
	#label for printing its even and exiting
	even:				
	li $v0, 4
	la $a0, even_s
	syscall
	li $v0, 10
	syscall
	
	#label for printing its odd and exiting
	odd_only:
	li $v0, 4
	la $a0, odd_s
	syscall
	li $v0, 10
	syscall
	
	#label for printing its prime and exiting
	prime:
	li $v0, 4
	la $a0, prime_s
	syscall
	li $v0, 10
	syscall
		
	
	
	
	 
	
	
