# Final Lab Solution (first 2021)/CPCS214

# Student Name: Rehab Hamad 




############################################




#	A subroutine called Read_Array() to read array elements from the user.
 

#	A subroutine called Dispaly_Array() to display array elements . 

#       A subroutine called Check_Ascending() to show weather the array is sorted in ascending order 

#	A subroutine called Count_Negative( ) to count number of array elements that are negative.

#	A subroutine called ComputeSeries() that computes the following  series .The subroutine should deal with the numbers as float numbers.   

#       s=  1/2+1/4+  1/6+⋯+  1/12  s=  1/2+1/4+  1/6+⋯+  1/12


############################################



.data

msg1: .asciiz "Enter the array size:  "

msg2: .asciiz "Enter elements of array : "

msg3: .asciiz "The array elements are:  "

msg4: .asciiz "\nNumber of negative values in array is:   "

msg5: .asciiz "\nArray elements are sorted in Ascending order"

msg6: .asciiz "\nArray elements are not sorted in Ascending order"

msg7: .asciiz "\nSum of series : "



space: .asciiz "  "

arr: .word 5



s: .float 1.0
e: .float 2.0
mpp: .float 2.0
x: .float 0.0








.text

main:

#pritn mag1 
la $a0,msg1
li $v0,4
syscall


#read number of array  Size  from user 
 li $v0,5

   syscall
# $t0 contains number of elements
  move $t0,$v0     





 #####################################################





###########  Read_Array Call   #############

############################################




     # display the second message

     li $v0,4

     la $a0,msg2

     syscall

     la $s0,arr          # $s0 contain the address of array element

     

jal readArr









#########   Display_Array Call  #############

#############################################



     #display the 3rd message

     la $a0,msg3

     li $v0,4						

     syscall

     la $s0,arr # $s0 contain the address of array element

jal dispArray









#########  Check_Ascending Call  #############

##############################################



     la $s0,arr

 jal Checkascending






##########  Count_Negative Call  #############

##############################################




   la $a0,msg4

     li $v0,4						

     syscall

     la $s0,arr

 jal CountNegative






##########   SumSeries Call      ############

#############################################


li $v0,4
la $a0,msg7
syscall

 
jal SumSeries




##########   End of your program  ##########

############################################



li $v0,10

syscall



#########    Read_Array subroutine  ##############

##################################################



    #  ReadArrar subroutien

readArr :

    li $s3,0                  # $s1 is a counter

  

loop:

    beq $s3,$t0,exitloop      # if counter = number of elements exitloop 

    #input the current number

    li $v0,5

    syscall				

    sw $v0,0($s0) # store the entered number in the array

    addi $s0,$s0,4 # change pointer to the next location in array

    addi $s3 , $s3 ,1 # incr the counter

    j loop



						

exitloop: jr $ra







#########    display_Array subroutine  ############

###################################################



    # dispArray subroutine

dispArray:						

    li $s2,0          # $s1 is a counter



displayLoop:

    beq $s2,$t0,end   #if counter = number of elements



    #display the current number

    lw $a0,0($s0)     # load the entered number from the array

    li $v0,1          # print the number

    syscall

    
    la $a0, space     # to separate elemens by spaces

    li $v0, 4

    syscall 




    addi $s0,$s0,4    # change pointer to the next location

    addi $s2 , $s2,1 # increment the counter



    j displayLoop



end: jr $ra









#########    Check_Ascending subroutine  ###########

####################################################

Checkascending:

 # $s1 is a counter
li $s1,0    

#limit of loop is arrayLength-1 becouse i wont check last element

addi $t4,$t0,-1 
loop3:
#if counter = number of elements
beq $s1,$t4,eLoop3 

# load the number from the array to $t1
lw $t1,0($s0) 

addi $s2,$s0,4  # chang to the next location 


lw $t3,0($s2) # load  number to $t3


bgt $t1,$t3,ns # if greater then next element  not sorted in Ascending order 
addi $s0,$s0,4 # chang to the next location 




addi $s1 , $s1 ,1 # incr the counter
j loop3
eLoop3:
li $v0,4
la $a0,msg5
syscall
j exit 
ns:
li $v0,4
la $a0,msg6
syscall
exit: jr $ra







#########    Count_Negative subroutine   ###########

####################################################




CountNegative:
# $s1 is a counter 
li $s1,0
 # $t4 is a counter of nigative number                      
li $t4,0                

CoutNLoop: 

 #if counter s1 = number of elements  
beq $s1,$t0,endCount 
 # load number from the array      
lw $a0,0($s0)                    

move $t3,$a0
# change pointer to the next location in Array 
addi $s0,$s0,4                    
 # increment the counter
addi $s1 , $s1 ,1 
 # if $t3 < 0 increment  counter nigative number                   
bgt $zero,$t3,incr       

j CoutNLoop

incr :
addi $t4,$t4,1

j CoutNLoop


endCount : 
move $a0,$t4
li $v0,1
syscall
jr $ra





########      Sumseries subroutine        ##########

####################################################

SumSeries:



l.s $f0,s #load numbers 1
l.s $f1,e #load numbers 1
l.s $f2,x #load numbers 0 stores result
l.s $f4,mpp #MyBoint

#we have 6 turm
li $v0,6
move $t1,$v0 
           
li $t0,0

loop8:
div.s $f3,$f0,$f1 #div  x/y


add.s $f2,$f2,$f3 #for sum

add.s $f1,$f1,$f4 #y++
add $t0,$t0,1 

blt $t0,$t1,loop8


mov.s $f12,$f2
li $v0,2
syscall


jr $ra



