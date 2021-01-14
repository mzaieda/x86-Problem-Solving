.data
	array: .word 1, 2, 3, 4, 5
	index: .asciiz "Index of: "
.text

main:
jal function		#jump to function and setting the ra to PC+4

li $v0, 4		#print the index of 
la $a0, index
syscall

li $v0, 1		#printing the index int that is defined from the funnction
move $a0, $s7		#printing what is in s7 which was found in function
syscall

li $v0, 10		#at the end of the function exit the program
syscall

function:
	li $t0, 4		#item to search for (This is to be changed by the user)
	la $t1, array		#pointing the t1 at the begininng of the array
	li $t2, 5		#number of items in the array
	li $t4, 0		#loading zero in t4 which is the counter
	search:
	lbu $t5, ($t1)		#loadinng the byte that t1 is pointing at
	beq $t5, $t0, found	#if it was found then branch to found
	add $t4, $t4, 1		#increment the t4 by which is the counter
	add $t1, $t1, 4		#increment the pointer by 4 to check the next item
	beq $t4, $t2, notFound	#at the end of the loop check jump to not found if it was not found
	j search		#else repeat the loop again

	found:
	move $s7, $t4		#saving the index in s7	
	jr $ra			#go back the return address after saving the output to s7


	notFound:
	li $t5, -1		#else set the t5 to -1 which means it was not found
	move $s7, $t5		#set s7 to -1
	jr $ra			#go back to the ra after saving -1 in the s7


















