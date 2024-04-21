program test_reciever(
    input bit clk,
    output bit Rst_tx,
    output logic Rs232,
    input logic done,
    input logic [7:0] rx_data,
    input logic [7:0] Baudrate_counter_,
    input logic bit_flag_,
    input logic [3:0] bit_counter_,
    input logic State_
    );

reg [9:0] data=10'b1000011010;
int count=0;
initial begin
Rst_tx <=1;
Rs232 <=1;
#10
Rst_tx <=0;
for (int j=0;j<=9;j++)begin
   	while(count!=30) begin
   	  @(posedge clk) count++;
 	  end
		Rs232 <= data[j];
		count=0;
end
end




endprogram

module top_rec(

    output bit clk,
    output bit Rst_tx,
    output logic Rs232,
    output logic done,
    output logic [7:0] rx_data,
    //ports ends here
    output logic [7:0] Baudrate_counter_,
    output logic bit_flag_,
    output logic [3:0] bit_counter_,
    output logic State_
);

always #10 clk =~ clk;


test_reciever ts(

    clk,
    Rst_tx,
    Rs232,
    done,
    rx_data,
    
    Baudrate_counter_,
    bit_flag_,
    bit_counter_,
    State_
);
Reciever2 Reciever_inst(

    clk,
    Rst_tx,
    Rs232,
    done,
    rx_data,
    
    Baudrate_counter_,
    bit_flag_,
    bit_counter_,
    State_
);

endmodule
