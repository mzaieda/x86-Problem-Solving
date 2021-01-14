.data
	string: .space 100		#string to be entered by the user (the first string)
	string2: .space 8		#the string that contains the prefixes from the orgianl string
	buff: .space 10			#buffer for later use
	bin_string: .space 100		#string to be printed
	octal_string: .space 100	#string to be printed
	hexa_string: .space 100		#string to be printed
	dec_string: .space 100		#string to be printed
	ask_size: .asciiz "Enter the size of the string plus 2\n"
	ask: .asciiz "Enter the string binary = 0b, Octal = 0O, Hexa = 0X, and the decimal number system will have no prefix: "
	value: .asciiz "The number system you wnat to convert (binary = 0b, Octal = 0O, Hexa = 0X, and decimal = 0d): "
	invalid_input: .asciiz "Invalid Input"
	error: .asciiz "Error input"
	#to compare the prefixes with these bytes
	b: .byte 'b'			
	o: .byte 'O'
	H: .byte 'X'
	
.text

li $v0, 4		#print the ask the size
la $a0, ask_size
syscall

li $v0, 5		#read from the user the size of the string plus 2 (should be consedered by the user)
syscall

move $t0, $v0		#size of the string is saveed in t0

li $v0, 4		#ask the user the string 
la $a0, ask
syscall
	
li $v0, 8		#read from the user the string and save it in the string
la $a0, string
la $a1, 20
syscall

la $t1, string		#point the t1 at the start of the string
add $t1, $t1, 1		#increment the pointer by 1 to look at the prefixes
lb $t2, ($t1)		#store the content of the t1 in t2

#these are for comparing the innput prefixes
lb $s0, b		
lb $s1, o
lb $s2, H


check:
beq $t2, $s0, binary_handler		#if the second item is equal to b then go to binary handler
beq $t2, $s1, octal_handler		#if the second item is equal to the O then go to the octal handler
beq $t2, $s2, hexa_handler		#if the second item is equal to X then go to the hexa handler
j decimal_handler			#else then it has to be decimal

check1:					#this function is to be used by the handlers to check the number system they want to convert to 
beq $t7, $s0, binary
beq $t7, $s1, octal
beq $t7, $s2, hexa
j invalid				#otherwise it has to be invalid


binary_handler:				#biunary handler takes the binary number and asks the user what they want to convert to 
sub $t0, $t0, 2				#subtracting the pointer by 2 to get to the right element 
li $v0, 8				#read from the user the string
la $a0, string2
la $a1, 20
syscall

la $t6, string2				#store the pointer of string 2 in t6
add $t6, $t6, 1				#increment it by one to access the prefix item
lb $t7, ($t6)

addi $t1, $t1, 1		
j convert_dec				#convert the number to decimal


octal_handler:				#octal handler takes the binary number and asks the user what they want to convert to 
sub $t0, $t0, 2				#subtract from the string 2 to get to the right element 
li $v0, 8				#read from the user a string which contains prefixes only
la $a0, string2
la $a1, 20
syscall

la $t6, string2
add $t6, $t6, 1			#increment it by one to access the letter
lb $t7, ($t6)

add $t1, $t1, 1
j convert_dec			#convert the number to decimal


hexa_handler:			#hexa handler takes the binary number and asks the user what they want to convert to
sub $t0, $t0, 2			#subtract the size by two 
li $v0, 8			#read from the user another string which is the prefixes
la $a0, string2
la $a1, 20
syscall

la $t6, string2			#pointer to the start of the string
add $t6, $t6, 1
lb $t7, ($t6)

add $t1, $t1, 1			#increment the t1 by one
j convert_dec

decimal_handler:
j convert_dec			#automatical convert to dec

convert_dec:
li $t4, 1			
lb $t3, ($t1)
beq $t3, $t4, power		#the function that calculates the power 
sub $t1, $t1, 1
sub $t0, $t0, 1
beqz $t0, converted		#if it is converted then ncall converted
j convert_dec			#repeat for several numbers

converted:		
li $v0, 4
la $a0, value
syscall

li $v0, 8			#read fron the user the buffer needed
la $a0, buff
la $a1, 10
syscall

move $t7, $a0
j check 


li $s4, 2		#the number that will be multiplied by always
power:			
move $t7, $t0
sub $t7, $t7, 1			#subtract the size by one to remove the 0 prefix
beqz $t7, convert_dec		#call the convert to decimal when needed
j multiply			#keep multiplying the number whenever it reaches one

multiply:			#the function that keeps multiplying the number by 2 until reaching the power as a contraint
mult $s4, $s4
mflo $s6			#storing the result of mult in s6
move $s4, $s6
beqz $t6, power
j multiply			#recall power againn to check if the else go to multiply


#this label chacks if the user is invalid and then exits
invalid:
li $v0, 4
la $a0, invalid_input
syscall
li $v0, 10
syscall

#this function converts the decimal to binary
binary:
add $t0,$s7,$zero		
la $a0,bin_string
move $t9 $a0

li $t5, 0 #the counter for the con function 


li $t8, 0
con:
li $t5,2		
div $t7,$t5	#divide the number by 2
mfhi $t6	#get the remainder in t6 
mflo $t7	#get the resuot in t7		
sb $t6,($t9)	#retreiving the element in the string in nt6
add $t5,$t5,1
bnez $t7,con	#if the t7 is not equal to zero then go to con
la $t0, bin_string	#replacing the pointer of the first string by the bin_string which contains the result
		
add $t0,$t0,$t8		#finaly adding the t0 with the counter number
sub $t0,$t0,1
j end1 			#junmp to end to print the number


li $t8, 0
con1:			#this function connverts the octal taken from the octal funnction
li $t5,2
div $t7,$t5		#divide the number i t7 by 2
mfhi $t6		#storing the remainder i nt6
mflo $t7		#storing the result in nt7		
sb $t6,($a0)		#storing the byte pointed by a0 in to t6
add $t8,$t8,1		#increment the t8
bnez $t7,con1		#loop again
la $t0, octal_string	#having the pointer over the string of octal 	
add $t0,$t0,$t8		#inncrement the t0 by the counter
sub $t0,$t0,1
j end1 			#jump to the prinnting phase

hexa:
li $s0,16		#having the base 16 soted in ns0
li $t5,2		
div $t7,$t5		#divinnf the numner by the 2
mfhi $t6		#remainder in t6	
mflo $t7		#storing the remainder 
bgt $t6,16, hexa		#comparing it with 9 then loop againn

con4:
sb $t6,($a0)		#storing the byte pointed by the string
add $a0,$a0,1			
add $t8,$t8,1
bnez $t7,con4		#loop agai nwith the following conntrasint
	
la $t0, hexa_string	#get the poiner at the strin
add $t0,$t0,$t8		#inncrement 
sub $t0,$t0,1		#subtract the size by one agina

li $t8, 0
con3:
li $t5,2
div $t7,$t5
mfhi $t6
mflo $t7				
sb $t6,($a0)
add $t8,$t8,1
bnez $t7,con3	
la $t0, hexa_string
		
add $t0,$t0,$t8
sub $t0,$t0,1
j end1 

octal:		#channginn to octal 
add $t7,$t4,$zero
la $a0,octal_string
li $t8,0

li $t5,8
div $t7,$t5
mfhi $t6
mflo $t7	
			#remainder handler		
sb $t6,($a0)
add $a0,$a0,1
			
	
add $t8,$t8,1
bnez $t7,con2		
la $t0, octal_string
		
add $t0,$t0,$t8
sub $t0,$t0,1 
sub $t8,$t8,1
lb $t9,($t0)
sb $t9,($t1)
add $t1,$t1,1
sub $t0,$t0,1
bnez $t8,octal_string		#comapring the valiue with th coal string
			
li $t8, 0
con2:		#second conversion
li $t5,2
div $t7,$t5
mfhi $t6
mflo $t7				
sb $t6,($a0)
add $t8,$t8,1
bnez $t7,con2	
la $t0, dec_string
		
add $t0,$t0,$t8
sub $t0,$t0,1
j end1 

#printinng the string
end1:		
li $v0, 4
j check1 
la $a0, bin_string
li $v0, 10
syscall

#printinng the string			
end2:
li $v0, 4
j check1 
la $a0, octal_string
li $v0, 10
syscall

#printinng the string
end3:
li $v0, 4
j check1 
la $a0, hexa_string
li $v0, 10
syscall

#printinng the string
end4:
li $v0, 4
j check1 
la $a0, dec_string
li $v0, 10
syscall


