# This example shows an implementation of the mathematical
# factorial function (! function).

.data
n: .word 10 # Number to find the bubblesort value of
arr: .word 5,3,6,7,31,23,43,12,45,1
str1: .string "Array: "
str2: .string "Sorted: "
str3: .string " "
str4: .string "\n"

.text
main:
        la      a1, str1   # print the initial array
        li      a0, 4
        ecall

        la      a1,str4
        li      a0,4
        ecall

        jal     ra,printArray

        jal     ra,bubblesort

        la      a1,str2
        li      a0,4
        ecall

        jal     ra,printArray

        # Exit program
        li       a0, 10
        ecall

# t0:i
# t1:j
# t2:n
# t3:arr array
bubblesort:
        addi    sp, sp, -8    #call stack
        sw      ra, 0(sp)

        addi    t0, zero, 0   #i=0
        lw      t2,n          #n=10

outer_loop:
        #if i>=n, exit process
        bge     t0,t2,outer_end
        addi    t1,t0,-1      #j=i-1
inner_loop:
        #if j<0, exit inner loop
        blt     t1,zero,inner_end
        la      t3,arr     #load address
        #(arr+4)=arr[1] ,every integer is 4 byte
        slli    t6,t1,2     #shift left immediate-> t6=t1*(2*2)
        #j++ (4 byte= 1)
        add     t3,t3,t6    #arr +4
        lw      t4,0(t3)    #load arr[j]
        lw      t5,4(t3)    #load arr[j+1]

        bge     t5,t4,inner_end     #if arr[j+1]>=arr[j],no swap
        la      a0,arr
        mv      a1,t1       #save index in a1(i)
        jal     ra,swap
        addi    t1,t1,-1
        j       inner_loop
inner_end:
        #	i = i + 1
	    addi t0,t0,1
	    j outer_loop
outer_end:
	    # function complete
	    lw ra,0(sp)
	    addi sp,sp,8
	    ret


swap:
        addi    sp,sp,-24
        #t0 t1 t2 will be uesd, have to save
        sw      t0,0(sp)
        sw      t1,8(sp)
        sw      t2,16(sp)
        #before call this function, it's already saved
        #index i in a1,arr address in a0
        #shift a1 to get i++
        slli    a1,a1,2
        add     t1,a0,a1
        #t1 now is array,swap ([i],[i+1])
        lw      t0,0(t1)
        lw      t2,4(t1)
        sw      t2,0(t1)
        sw      t0,4(t1)

        #load back
        lw t0,0(sp)
	    lw t1,8(sp)
	    lw t2,16(sp)
	    addi sp,sp,24
	    ret

# t0:i   t1:j    t2:arr
printArray:
        li t0,0
        lw t1,n

printArray_for:
        bge t0,t1,printArray_for_End
    
        la t2,arr
        slli t4,t0,2
        add t2,t2,t4

        lb a1,0(t2)
        li a0,1
        ecall 

        la a1,str3
        li a0,4
        ecall 

        # i++
        addi t0,t0,1
        j printArray_for
    
printArray_for_End:
        la a1,str4
        li a0,4
        ecall 
        ret