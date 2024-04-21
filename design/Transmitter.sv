module Transmitter(
input bit clk,
input logic Start,
input logic Tx_rst,
input logic [7:0] data,
output bit done,
output logic transfere_data
);

logic [7:0] data_tf;
logic bit_flag;
logic [3:0] bit_counter;
logic [10:0] Baudrate_counter;
reg State;


assign data_tf = Start ? data : data_tf; //when start signal become high store input data to 8 bit registers inside TX
//assign State = Tx_if.Start ? 1'b1 : State1;//state must be 1 during the transmition
always_ff @(posedge clk,posedge Tx_rst) begin //baudrate_counter
	if(Tx_rst) begin //positive rst
		Baudrate_counter <= 0;
		State <= 0;
	end else if(State) begin
		if(Baudrate_counter==30) begin
			Baudrate_counter <= 0;
			bit_flag <= 1;
		end else begin
			Baudrate_counter <= Baudrate_counter + 1;
		end
	end else begin
		Baudrate_counter <= 0;
	end 


end
always_ff @(posedge clk, posedge Tx_rst) begin

    State = Start ? 1'b1 : State;
    done = done ? 1'b0 : done;

end

always_ff @(posedge clk, posedge Tx_rst)begin	//tranfer
	
	if(Tx_rst) begin
		transfere_data <= 1'b1; //transmition line is high by default
		bit_counter <= 'b0;
		bit_flag <= 1'b1;
		done <= 1'b0;
	end else if(State) begin
		if(bit_flag) begin
			case(bit_counter)
			'd0: transfere_data <= 1'b0;
			'd1: transfere_data <= data_tf[0];
			'd2: transfere_data <= data_tf[1];
			'd3: transfere_data <= data_tf[2];
			'd4: transfere_data <= data_tf[3];
			'd5: transfere_data <= data_tf[4];
			'd6: transfere_data <= data_tf[5];
			'd7: transfere_data <= data_tf[6];
			'd8: transfere_data <= data_tf[7];
			default: transfere_data <= 1'b1;	
			endcase
			bit_flag <= 'b0;
			 
			if(bit_counter == 10) begin	//if bit counter reach 10 bits means that
				bit_counter <= 0;
				done <= 1'b1;
				State <= 1'b0;
			end else begin
				bit_counter <= bit_counter + 1;
			end
			
			
		end else begin
			transfere_data <= transfere_data ;	
		end
		
	end else begin
		transfere_data <= 1'b1;
	end


end
endmodule
