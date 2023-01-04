Chloe Kang
NetID: yk234

Project Checkpoint 3 Regfile

I used Verilog to design and siumlate Regfile. Regfile supports 2 read ports, 1 write port, and 32 registers. Write port uses control bits (ctrl_writeReg) to determine which registers it writes to out of 32 registers. Similarly, read port uses its control bits (ctrl_readRegA, ctrl_readRegB) to determine which registers it reads from out of 32 registers. The data(data_writeReg) will be written in the targeted register. After choosing the one that reads, output (data_readRegA, data_readRegB) will be from the picked registers.

**Register**
To build register, I use dffe for each bit and combine 32 bits together. 

**Decoder**
To build decoder, I use a input that is 4 bits of ctrl_writeReg and a output with only one high bit out of 32 bits to make one of the 32 registers work at a time.
I use truth table and and gate to build it.

**tristate buffer**
To build tristate buffer, I use two inputs and a output. 32 bits data and enable bit are inputs. By using bufif1 primitive code, it transfers input data if the enable bit is high. If not, the high impedence Z is filled in the output.

**write port**
To build write port, I call decoder to select the register that will be written. After getting temperary select bits(temp_select_bits), I use and gate for each temperary select bits and write enable bit.

**read port**
To build read port, I call decoder and tristate buffer to get the data from one selected register. For enable bit used in tristate buffer, decoder is operated to produce 32 bits of select bits.