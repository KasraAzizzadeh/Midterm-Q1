![alt text](https://res.cloudinary.com/witspry/image/upload/witscad/public/content/courses/computer-architecture/stack-cpu-operation.jpg)

# Stack Based ALU
Our project is a Stack Based ALU which is capable of doing 4 operations:
  1. Pushing number inside the stack (PUSH)
  2. Poping the most recent number outside of the stack (POP)
  3. Adding the two most recent numbers in the stack (Addition)
  4. Multiplying the two most recent numbers in the stack (Multiply)

## Tools
In this project we didn't use any particular tools. we coded our hardware
description in verilog language and simulated it using ModelSim

## Implementation Details
Our Project is consisted of a STACK_BASED_ALU modules that contains the logic of
our hardware and a testbench module that simulates our hardware based on different inputs

### STACK_BASED_ALU.v
As we mentioned our ALU is capable of four basic operations. For these operations we need:
  1. An n-bit input wire to push numbers inside the stack
  2. An n-bit output wire to return the result of Addition and Multiply
  3. A 1-bit output wire to inform us of any overflow
  4. A 1-bit clock input to synchronize our ALU
  5. A 1-bit reset input to return our stack and ALU to its primary state
  6. A 3-bit opcode
we decide which operation we should perform based on our opcode:
  * opcode '100' = Addition
  * opcode '101' = Multiply
  * opcode '110' = PUSJ
  * opcode '111' = POP
  * opcode '0xx' = No Operation

We also define an internal Vector Array of regs for our stack memory and also a reg variable called pointer so
we can find the top of our stack

based on any changes in our clock our module evaluates it's inputs and either does one of the aforementioned
operations if opcode[2] = 1 or does nothing if opcode[2] = 0
