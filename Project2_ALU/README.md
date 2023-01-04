Chloe Kang
NetID: yk234

Project Checkpoint 2

I used Verilog to design and siumlate ALU. ALU operates Add, Subtraction, bitwise Aand, bitwise Or, Logical Left Shift, and Arithmetic Right Shift depending on ALU Opcode.
For Subtraction, isNotEqual and isLessThan is also operated. For both Add and Subtraction, ALU also operates overflow to assert tru if and only if there is an overflow.

**Addition**
To build it, I use **Carry Select Adders (CSA)** for addition operation. To process two 32-bits operands, CSA have 3 separate RCA where each RCA has 16-bits each. Depending on the cout of the first 16-bit RCA from LSB to 16th bit, the Mux choose which the second 16-bit RCA will be used.  


**Subtraction**
To build it, I also use **Carry Select Adders (CSA)** for subtraction operation. In a similar way to addition, CSA have 3 separate RCA where each RCA has 16-bits each. Depending on the cout of the first 16-bit RCA from LSB to 16th bit, the Mux choose which the second 16-bit RCA will be used.
Unlike addition, I use two's complement to make data_operandB negative and add with data_operandA. To get 2's complement, I first use not operation to convert each bits to opposite and get 1'b0 for cin to add 1 after conversion.

**Overflow**
Overflow is determined inside CSA module. If MSB of data_operandA and data_operandB are same, and if the MSB of sum is different from those, overflow occurs.

**bitwise AND**
To build it, I operate and(&) operation bit by bit. For example, data_operandA[0] & data_operandB[0]

**bitwise OR**
To build it, I operate or(|) operation bit by bit.  For example, data_operandA[0] | data_operandB[0]

**SLL (Logical left-shift)**
SLL is operated depending on 5-bits ctrl_shiftamt. The module start reading ctrl_shiftamt from the LSB. If the LSB of strl_shiftamt is 1, the module get 0-30 bits of data_operandA, move them to the left, and fill the empty spots on right with 0. If the second bit of ctrl_ahiftamt is 1, then the module keeps bits 0 to 29 of the result from the previous step, move it to the left, and fill the empty spots with zeros again, and so on.

**SRA (Arithmetic right-shift)**
SRA is operated depending on 5-bits ctrl_shiftamt and MSB's value. It is separated by two cases, the case of MSB=0 and the case of MSB=1 of data_operandA. Like SLL, it starts reading the LSB of ctrl_shiftamt. If it is 1, the module get the first result getting 1 to 31 bits of data_operandA on the right side and fill MSB on the left side. (If MSB of data_operandA is 1, fill with 1s. If MSB of data_operandB is 0, fill with 0s.)
The module then read the second bit of ctrl_shiftamt. If it is 1,  the module get the first result getting 2 to 31 bits of the previous result on the right side and fill the empty places on the left side with MSB.
Once getting each results after reading all bits of ctrl_shiftamt, I get the final result of SRA depedning on the MSB's value.

**isLessThan**
It asserts if and only if data_operandA is strictly less than data_operandB. data_operandA is less than data_operandB iff MSB of the result of subtraction is 0 and subtraction overflow is 1 or MSB of the result of subtraction is 1 and subtraction overflow is 0. To calculate it, I use xor between the result of subtraction and subtraction overflow. 

**isNotEqual**
It asserts if and only if data_operandA and data_operandB are not equal. A and B are not equal iff bitwise_or of the subtraction result is 0 and subtraction cout is 0 as well.