module syncronizer(
    input bit clk,
    input bit reset,
    input logic data_in,
    output logic data_out
);

reg [1:0] state, next_state;
always@(posedge clk or posedge reset)
begin
    if(reset)
        state <= 2'b11;
    else
        state <= next_state;
end
assign next_state[0] = data_in;
assign next_state[1] = state[0];
assign data_out = state[1];
endmodule 
module test(
output bit clk1,
output bit reset1,
output logic data_in1,
output logic data_out1

);
bit clk;
bit reset;
logic data_in;
logic data_out;

syncronizer uut(
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .data_out(data_out)
);

always
    #5 clk = ~clk;
assign clk1=clk;
assign reset1=reset;
assign data_in1=data_in;
assign data_out1=data_out;
initial begin
#13
reset = 1;
#11
reset = 0;
data_in = 1;
#10
data_in = 0;
#14
data_in = 1;
end

endmodule 
