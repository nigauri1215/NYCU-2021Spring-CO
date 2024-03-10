Computer Organization
==
This series of LABs will help you understand the CPU architecture.
## Lab1
In Lab0, students will know the difference between assembly and high-level languages. 
In order to test the correctness of the program, students should use RISC-V simulator - Ripes to simulate the programs. 
## Lab2
The goal of this LAB is to implement a 32-bit ALU (Arithmetic Logic Unit). ALU is the basic computing component of a CPU. Its operations include AND, OR, addition, subtraction, etc. 
LAB 3 will be reused; you will use this module in the later LABs. 
## Lab3
Utilizing the ALU in Lab2 to implement a Simple Single-Cycle CPU. CPU is the most important unit in computer system. Read the document carefully and do the Lab, and you will have the elementary knowledge of CPU.
## Lab4
In Lab4 we have the goal to realize how to set the control signal in different instruction type. ( Decoder & ALU Controller), clarify how sign-extend work and connect all datapath to form a single cycle CPU.
## Lab5
According to the architecture diagram below, in this lab you should modify the Single Cycle CPU designed from Lab4 and implement a 5-stage Pipeline Processor with IF, ID, EX, MEM and WB stages.
For a pipeline processor design, a pipeline register module between each 2 stages is required and the pipeline registers are written when each positive clock edge is triggered.
## Lab6
Cache Performance is important for system performance. In order to understand the performance difference between different cache architectures, you are asked to simulate direct mapped and n-way set associative cache behaviors and written in C++ style.
