program test_Trans(
input bit clk,
output logic Start,
output logic Tx_rst,
output logic [7:0] data,
input bit done,
input logic transfere_data
);
/*simple Uart testbench*/
initial begin
Tx_rst <= 1;  //reset the design
#13
data <= 'd45;   //load data
Start <= 1;     //signal uart to start transmissing but it must not to start if reset is on

#14
Tx_rst <= 0;    //getting the reset off
#3
Start <= 0;     //Start signal may become zero during the Transmittion as its function at the begining of the transmission
@(posedge done) //wait until the first transmission complete
@(posedge clk)
Tx_rst <= 1;    //reset before the second Transmission
data <= 'd47;   //load new value
@(posedge clk)
@(posedge clk)
Tx_rst <= 0;    //reset is off
Start <= 1;     //raise the Start to start Transmission
@(posedge clk)
Start <= 0;     //Start signal may become zero during the Transmittion as its function at the begining of the transmission

end

endprogram
