.data

	array: .space 40
	ask_size: .asciiz "Number of elements: "
	ask_items: .asciiz "Enter the numbers to be stored in the array (max 10): "
	max: .asciiz "\nMax is: "
	min: .asciiz "\nMin is: "

.text 


	#ask from the user the size
	li $v0, 4
	la $a0, ask_size
	syscall

	#havinng it in s0
	li $v0,5
	syscall
	move $s0, $v0

	li $v0, 4
	la $a0, ask_items
	syscall

	la $t0, array 
	li $s1, 0   

	
	loop:		#loop over the array to store the entered values
	li $v0,5
	syscall
	sw $v0, ($t0)	#store in a temp reg
	add $s1,$s1,1	#incremet the counter
	add $t0,$t0,4	#icremet the pointer
	blt $s1, $s0, loop	#if it is less tha nthe s0 the loop again


	la $t0, array #reseatting
	li $s1, 0
	lw $s0,($t0)   #loading the word i the s0
	lw $s4,($t0)  #loadinng the word in the s4
	find:
	add $t0,$t0,4	#icremet the pointer
	lw $s3,($t0)		#fidinng ghe max 
	ble $s3,$s0,setMin	#going to set the min
	bge $s3,$s4 setMax	#goinf to set the max
	add:
	add $t0,$t0,4		#chaingn the poiunter 
	add $s1,$s1,1		#icreasinng the counter
	blt $s1,$s0, find
	j exit
	
	setMin:
	move $s0,$s3		#setting the min from s3
	b add			#then branch

	setMax:
	move $s4,$s3		#setting the max from s3
	b add			#then branch

	#print the max and min and exit
	exit:			
	li $v0, 4
	la $a0,max
	syscall
	
	li $v0, 1
	move $a0, $s4
	syscall

	li $v0, 4
	la $a0,min
	syscall

	li $v0, 1
	move $a0, $s0
	syscall

	li $v0,10
	syscall





