# Simple UART

UART stands for Universal Asynchronous Receiver/Transmitter. It's a hardware communication protocol used for serial communication between devices. UART is commonly used in embedded systems and microcontrollers to facilitate communication with peripherals like sensors, displays, and other microcontrollers.
Data Transmission: UART transmits data serially, one bit at a time, over two lines: one for transmitting (TX) and one for receiving (RX). Start and Stop Bits: Each data frame typically starts with a start bit and ends with one or more stop bits. These bits help synchronize the receiving and transmitting devices. Baud Rate: The baud rate specifies the speed of data transmission, indicating how many bits per second (bps) are being sent. Common baud rates include 9600, 115200, etc. Asynchronous Communication: UART operates asynchronously, meaning that the transmitting and receiving devices don't share a common clock signal. Instead, they rely on the start and stop bits for synchronization. Data Frame: A typical UART data frame consists of a start bit, data bits (usually 8 bits), an optional parity bit for error checking, and one or more stop bits.

## Receiver and Transmitter overview

![<img src="images/example.png" width="300" />](https://github.com/SohaibAlaraby/Simple_Uart/blob/610f0a2fc5fc12fff783e0bd5bc5d92e2afa757d/images/receiver_transmitter.png)

## UART Data Frame

![images/example.png](https://github.com/SohaibAlaraby/Simple_Uart/blob/21c0d63d989961b929c90049266a9e92f832786e/images/Data_frame.png)


## Receiver Time Diagram

![<img src="images/example.png" width="300" />](https://github.com/SohaibAlaraby/Simple_Uart/blob/c0e2a4763548e5af3ae88bf76f13a7282774e147/images/receiver_td.png)

## Transmitter Time Diagram

![<img src="images/example.png" width="300" />](https://github.com/SohaibAlaraby/Simple_Uart/blob/436169928ea70ba42c635e971ca94d8a0ccc0e20/images/sending_td.png)

## Results
![<img src="images/example.png" width="300" />](https://github.com/SohaibAlaraby/Simple_Uart/blob/1c392e2bdfe37f24e631f481347b3f4ba8457018/images/waveform.png)
