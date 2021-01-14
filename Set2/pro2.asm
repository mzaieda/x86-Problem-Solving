.data
	string: .space 100	#reserve 100 bits for string
	string1: .space 100	#reserve 100 bits for string1
	ask: .asciiz "\nEnter the size of the string: "		#ask the user the size of the string
	ask_string: .asciiz "\nString you want to reverse: "	#ask the user the string to reverse
	line: .asciiz "\n The reversed word: "			#final printing 
.text
	#system call to print the ask number string
	li $v0, 4
	la $a0, ask
	syscall
	
	#system call to read from the user int
	li $v0, 5
	syscall
	
	#storing the result in t0 and adding 1 to make in consideration the null character
	move $t0, $v0
	add $t0, $t0, 1
	
	#system call to print asking for the string
	li $v0, 4
	la $a0, ask_string
	syscall

	#system call to read a string
	li $v0, 8
	la $a0, string
	la $a1, ($t0)	#the length is stored in t0
	syscall
	
	#a pointer pointinng at the beginning of string
	la $t3, string
	#a pointer pointinng at the beginning of string1
	la $t4, string1
	#getting the t4 to the end of the string
	add $t4, $t4, $t0
	#nneglectinng the nunll character and a zero character
	sub $t4, $t4, 2
	
	#loop for loading and storing
	loop:
	lb $t6, ($t3)	#load the first item in string in t6
	sb $t6, ($t4)	#store the t6 in nthe last element in string1
	add $t3, $t3, 1	#icnrement the pointer of string by 1
	sub $t4, $t4, 1	#decrement the pointer of string1 by 1
	beqz $t6, print #if the t6 hits the null character go to print
	j loop		#else loop again

	print:
	#system call to print a new linne
	li $v0, 4
	la $a0, line
	syscall
	#system call to print a string1
	li $v0, 4
	la $a0, string1
	syscall
	#exit the program
	li $v0, 10
	syscall
	
	
