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
