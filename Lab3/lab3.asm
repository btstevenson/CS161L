# Simple Program that reads in an integer, and casts it to a 
# floating point value. For example the floating point number
# 1.5 has a hex value of 0x3FC00000. This hex number has an
# integer value of 1,069,547,520.
#
# Sample Input : 1069547520
# Sample Output: 1.50000000
# java -jar Mars4_5.jar

.text

main:
   la    $a0, STR1   # load a message to be output
   li    $v0, 4      # syscall 4 (print_str)
   syscall           # outputs the string at $a0

   li    $v0, 5      # syscall 5 (read_int)
   syscall           # reads an int into $v0
   

   move  $s0, $v0    #saves input value of # of deciaml places to register s0
   
   
   la    $a0, STR2   # load a message to be output
   li    $v0, 4      # syscall 4 (print_str)
   syscall           # outputs the string at $a0

   li    $v0, 5      # syscall 5 (read_int)
   syscall           # reads an int into $v0
   

   move  $s1, $v0    #saves integer input to register s1
   
   srl   $s1, $s0    #right shifts the integer input by the number of decimal places
   
   
   
   mtc1  $v0, $f12   # moves integer to floating point register
   li    $v0, 2      # syscall 2 (print_float)
   syscall           # outputs the float at $f12

DONE:

.data
 
STR1:
   .asciiz "Enter an Integer to indicate how many decimal places:\n"
   
STR2:
   .asciiz "Enter an Integer: \n"
