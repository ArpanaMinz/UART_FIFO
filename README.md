# UART_FIFO
Real Time Serial Data Reception on FPGA using UART with FIFO Buffering

The project involves designing a UART receiver on an FPGA(basys 3 board) to receive serial data from a PC-based 
UART transmitter. The received data is sequentially loaded into a synchronous FIFO for reliable buffering and 
subsequent processing. This setup enables robust data acquisition from a standard PC terminal to an FPGA platform.

# Insights
Tool used: Xilinx Vivado
Board Used: Basys 3 
Baud rate: 9600

# UART
 Universal Asynchronous Receiver/Transmitter (UART) is a fundamental hardware
 communication protocol used for asynchronous serial communication between digital devices.
 Unlike synchronous communication, UART does not require a shared clock signal between
 the transmitter and receiver. Instead, it uses predefined settings such as baud rate, data bits,
 parity, and stop bits to ensure both ends interpret the data correctly.
 UART is widely used in embedded systems due to its simplicity and minimal hardware
 requirements. It is commonly found in microcontrollers, FPGAs, GPS modules, Bluetooth
 modules, and various sensors. The protocol is ideal for point-to-point communication,
 especially when bandwidth requirements are low to moderate.

# How to Run
1. Open the project in **Xilinx Vivado**.  
2. Add RTL files and the XDC constraint file.  
3. Synthesize, Implement, and Generate Bitstream.  
4. Program the Basys 3 board.  
5. Connect a USB-to-UART terminal (e.g., Tera Term) at **9600 baud**.  
6. Send ASCII characters → They will be stored in FIFO and when FIFO is full the binary value of the ASCII characters is displayed on the LEDs.  

# Key Learnings
- UART communication protocol on FPGA.  
- Clock domain crossing (CDC) using **toggle synchronizer**.  
- Synchronous FIFO design for buffering.  
- RTL design, synthesis, and FPGA implementation flow.  
