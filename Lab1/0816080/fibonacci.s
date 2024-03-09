#int Fibonacci(int n) {
#   if(n<=1)
#       return n
#    else {
#   		return(Fibonacci(n - 1) + Fibonacci(n - 2));
#   }
#} 

.data
argument: .word 7 # Number to find the factorial value of
str1: .string " the number in the Fibonacci sequence is "


.text

#addi   ->跑计㎝盽计
#sw     ->register狥﹁ store memory
#lw     ->memory狥﹁ load register
main:
        lw       a0, argument   # Load argument from static data
        jal      ra, Fibonacci       # Jump-and-link to the 'Fibonacci' label

        # Print the result to console
        mv       a1, a0
        lw       a0, argument
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

Fibonacci:
        addi     sp, sp, -16    #call stack ,four 4-bytes register
        sw       ra, 8(sp)      #ra-> return address(function磅︽Ч璶铬︽)
        sw       a0, 0(sp)      #a0->function把计 save n     
        beq      a0, zero,L1    #if(n == 0) return 0  ->jump to L1
        addi     t0, a0,-1 
        beq      t0,zero,L2     #if(n==1) return 1    ->jump to L2
        
        #Fibonacci
        addi     a0, a0, -1     #set a0=(n-1)
        jal      ra, Fibonacci
        addi     sp, sp, -8
        sw       a0, 0(sp)

        lw       a0, 8(sp)
        addi     a0, a0,-2       #set a0=(n-2)
        jal      ra, Fibonacci


        lw       t0, 0(sp)
        add      a0, a0, t0
        lw       ra, 16(sp)
        addi     sp, sp, 24

        ret

L1:
        addi     a0,zero,0
        addi     sp, sp, 16
        ret
L2:
        addi     a0,zero,1
        addi     sp, sp, 16
        ret

printResult:
        mv       t0, a0     
        mv       t1, a1     #result

        mv       a1,t0
        li       a0,1
        ecall

        la       a1, str1
        li       a0, 4      #Printa0﹃
        ecall


        mv       a1, t1
        li       a0, 1      #Print a0计
        ecall

        ret
