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

