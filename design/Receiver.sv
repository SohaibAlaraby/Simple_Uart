module Reciever2 (
    input bit clk,
    input bit Rst_tx,
    input logic Rs232,
    output logic done,
    output logic [7:0] rx_data,
    //ports ends here
    output logic [7:0] Baudrate_counter_,
    output logic bit_flag_,
    output logic [3:0] bit_counter_,
    output logic State_
    );


logic [7:0] Baudrate_counter;
logic bit_flag;
logic [3:0] bit_counter;
logic State;
logic Start;

always_ff @(posedge Rst_tx) begin  : reset
    if(Rst_tx)begin
        Baudrate_counter <= 8'b0;
        bit_flag <= 1'b0;
        bit_counter <= 4'b0;
        State <=1'b0;
    end
end

always_ff @( posedge clk ) begin : Baudrate_counter1

    if(!Rst_tx)begin
        
            if(Baudrate_counter == 8'd30) begin
                Baudrate_counter <= 8'b0;
                bit_flag <= 1'b1;
            end else begin
                Baudrate_counter <= Baudrate_counter + 1;
            end
    end
end

always_ff @(posedge clk) begin :storeData
    if(!Rst_tx)begin
        if(State)begin
            if(bit_flag)begin
                case(bit_counter)
                    4'd1: rx_data[0] <= Rs232;
                    4'd2: rx_data[1] <= Rs232;
                    4'd3: rx_data[2] <= Rs232;
                    4'd4: rx_data[3] <= Rs232;
                    4'd5: rx_data[4] <= Rs232;
                    4'd6: rx_data[5] <= Rs232;
                    4'd7: rx_data[6] <= Rs232;
                    4'd8: rx_data[7] <= Rs232;
                    default: rx_data <= rx_data;
                endcase
                bit_flag <= 0;
                bit_counter <= bit_counter + 1;
                if(bit_counter == 4'd8) begin
                    bit_counter <= 4'b0;
                    done <= 1'b1;
                    State <= 1'b0;
                end
                
            end
        end
    end
end


always_ff @(Rs232) begin : State1
    if(!State && !Rs232 && bit_counter==0)begin
        State <= 1'b1;
    end 
end

always_ff @(posedge clk) begin : done1
    
  done <= done & 0;
end
//for debuging and waveform visualization
assign Baudrate_counter_ = Baudrate_counter;
assign bit_flag_ = bit_flag;
assign bit_counter_ = bit_counter;
assign State_ = State;

endmodule
