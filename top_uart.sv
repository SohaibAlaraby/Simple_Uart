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



module top_uart(
/*these signals is for waveform visualization and not affecting the main function of the design*/

output logic       dataFromTransmitter,
output logic       dataToReciever,
output bit         doneOfReciever,        
output logic [7:0] dataAtReciever,
output logic [7:0] Baudrate_counter_,
output logic       bit_flag_,
output logic [3:0] bit_counter_,
output logic       State_ 
);

bit clk;

logic Start;
logic Tx_rst;
logic [7:0] data;
bit done;
bit done_rx;
logic transfere_data_before_sync;
logic transfere_data_after_sync;
logic [7:0] data_recieved;
always #10 clk =~ clk;



test_Trans good(
.clk(clk),
.Start(Start),
.Tx_rst(Tx_rst),
.data(data),
.done(done),
.transfere_data(transfere_data_before_sync)
);
Reciever2 rec(
.clk(clk),
.Rs232(transfere_data_after_sync),
.Rst_tx(Tx_rst),
.done(doneOfReciever),
.rx_data(dataAtReciever),
.Baudrate_counter_(Baudrate_counter_),
.bit_flag_(bit_flag_),
.bit_counter_(bit_counter_),
.State_(State_)
);
Transmitter trans1(
.clk(clk),
.Start(Start),
.Tx_rst(Tx_rst),
.data(data),
.done(done),
.transfere_data(transfere_data_before_sync)
);
syncronizer sync(
.clk(clk),
.reset(Tx_rst),
.data_in(transfere_data_before_sync),
.data_out(transfere_data_after_sync)


);
assign dataFromTransmitter = transfere_data_before_sync;
assign dataToReciever = transfere_data_after_sync;

endmodule

