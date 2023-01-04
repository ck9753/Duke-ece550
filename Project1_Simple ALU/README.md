Chloe Kang
NetID: yk234

Project Checkpoint 1

I used Verilog to design and siumlate ALU. ALU operates Add and Subtraction depending on ALU Opcode.

**Addition**
To build it, I used **Carry-Lookahead Adders (CLA)** for less delay. To process two 32-bits operands, CLA have 4 blocks where each block has 8-bits each.


**Subtraction**
To build it, I also used **Carry-Lookahead Adders (CLA)**. In a similar way to addition, I had 4 blocks that have 8-bit each to build 32-bits subtraction.
Unlike addition, I used two's complement to make data_operandB negative and add with data_operandA.