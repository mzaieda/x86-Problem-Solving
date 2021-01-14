Set 1:
Problem 1: 
In this problem I forced the user to enter 5 integers to play with and find the max and min. First, I created the logic of 
storing the items entered in the array to analyze it with the logic of finding the max and min. The logic was based on a loop that 
was governed by a counter that whenever the a temp register is bigger than na current pointer value it jumps to setMax, and otherwise for minimum. 

Problem 2: 
In this problem I did three special cases for 0, 1, 2 and the other user entered data went through a loop of checking 
if it is prime or not, if it is prime then it is odd, if it is not prime then I divide every number before it and check 
its remainder if its 0, then it is only odd, otherwise it is even. 

Problem 3: 
I created two pointers that pointed at the beginning of the string and at the end of the string, and compare each of them,
if they are equal go to the loop that would check for every character later. If it is not equal then it is nont a palindrome 
and the logic of replacing the character was by using a temp reg to compare it with the two other reg pointing at the string edges 
and setting them to each other and so on for the rest of the string.


Set2:
Problem 1:
In this problem we were asked to search for an element and print the index, else -1. What I’ve done is the function only 
which was what the question asked for. The array contains 5 elements for example from 1-5. The t0 is to be set to change the item 
to search for. This is assuming that this function would be used in a custom program. I have the main label and the function label, 
with jal to function to have the ra set to the printing instruction after that and then exit the program. The function will search by 
incrementing the pointer of array, and checks if it was found. If it was found then the s7 register is set to the index, and jr 
the ra to print what is in s7.

Problem 2:
In this problem, I simply had a pointer to the beginning of the string entered. I also reserved space for another string to be
storing the reverse. I set the pointer of the second string to the end. In a loop, I load the byte in the first pointer of the first 
string, and then I store its item in the other pointer of the second string. I increment the pointer of the first string and decrement 
the second pointer, until the pointer points to zero, then print the reversed string.

Problem 3:
In this problem, I made the conversion into 6 main function to convert from a number to another, instead of 12. I made any number entered 
converted to a decimal number. This decimal number is then converted to binary or hexa or octal based on the user’s desired input. 
First of all I retrieve the user input size which is very important in my program to keep looping over the string plus which makes in consideration 
the two bytes for the prefixes. This string is parsed from the beginning and checked if it contains b, O, or X in their second element in the string. 
The handlers are activated based in the that, otherwise it goes to the decimal handler immediately. The handlers makes the string ready to enter the 
decimal conversion function by increasing the pointer and decreasing to the size. After the number goes to the decimal conversion, the user is then asked 
to enter the prefix related to the desired conversion. The conversion is made through the check1 function and goes to either binary, or octal, or hexa functions. 
After the conversion is made the result is stored in the bin_string, or octal_string, or hexa_string, or dec_string, and then printed. 
The conversion from the number to another was made by parsing the string and then loading them into registers which are then compared with t
heir appropriate signs. The hexa letter are translated into their equivalent ascii numbers such that is works. We assumed the user is entering 
the exact numbers as the characters in the string, otherwise the program will go into an infinite loop. The conversion from the number to another 
was made by parsing the string and then loading them into registers which are then compared with their appropriate signs.
