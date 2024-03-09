.data
arg1: .word 4 
arg2: .word 8
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
        lw       a0, arg1       #load from data,store arg1 in a0
        lw       a1, arg2       #arg2 in a1
        jal      ra, gcd       # Jump-and-link to the 'gcd' label

        # Print the result to console
        
        mv       a2, a0
        lw       a0, arg1
        lw       a1, arg2
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

gcd:
        addi     sp, sp, -16    #call stack, reserve four 4-bytes-register space in stack
        sw       ra, 0(sp)      #store return address
        #sw       a0, 0(sp)
        beq      a1, zero ,RT

        rem      t0, a0,a1      #store temporarily, t0=a0%a1
        mv       a0,a1
        mv       a1,t0

        jal      ra,gcd

        lw       ra,0(sp)
        addi     sp,sp,16
        ret

        RT:
        addi     sp, sp, 16
        jalr     ra
            
        


# expects:
# a1 a0: Value which gcd number was computed from
# a2: result m n
printResult:
        mv       t0, a0
        mv       t1, a1
        mv       t2, a2
        

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

        la       a1, str3
        li       a0, 4
        ecall

        mv       a1, t2
        li       a0, 1
        ecall


        ret
