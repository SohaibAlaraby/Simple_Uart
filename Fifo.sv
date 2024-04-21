module FIFO #(
    parameter buffer_width = 7,
    parameter FIFO_size = 64
) (
    input [buffer_width-1 : 0] dataIn,
    input wr_en,rd_en,
    input clk,
    input rst,
    output reg [buffer_width-1 : 0] dataOut,
    output empty,full

);
    reg [buffer_width-1 : 0] storage [FIFO_size-1 : 0]; //memory
    reg [buffer_width-1 : 0] wr_ptr,rd_ptr,counter;
    reg empty_flag,full_flag;
  always @(counter) begin //empty and full flags
        empty_flag = (counter == 0);
        full_flag  = (counter == FIFO_size);
  end

  always @(posedge clk,posedge rst) begin //counter

    if (rst) begin
        counter <= 'b0;
    end else if((!empty_flag && rd_en) && (!full_flag && wr_en)) begin //read and write
        counter <= counter;

    end else if(!empty_flag && rd_en) begin //read
        counter <= counter-1;

    end else if(!full_flag && wr_en) begin //write
        counter <= counter+1;
        
    end else begin
        counter <= counter;
    end
  end  
  always @(posedge clk,posedge rst) begin //rd ,wr ptrs
    if (rst) begin
        wr_ptr <= 'b0;
        rd_ptr <= 'b0;
    end else begin
        if(!empty_flag && rd_en) begin //read
            rd_ptr <= rd_ptr + 1;
        end else begin
            rd_ptr <= rd_ptr;
        end    
        if(!full_flag && wr_en) begin //write
            wr_ptr <= wr_ptr + 1;
        
        end else begin
            wr_ptr <= wr_ptr;
        
        end
    
    end
  end
  always @(posedge clk,posedge rst) begin //read
    if (rst) begin
       dataOut<='b0;
    end else begin
        if (!empty_flag && rd_en) begin
            dataOut <= storage[rd_ptr];
        end else begin
            dataOut <= dataOut;
        end
        
    end
    
  end

  always @(posedge clk) begin //store
    if (!full_flag && wr_en) begin
        storage[wr_ptr] <= dataIn;
    end else begin
        storage[wr_ptr] <= storage[wr_ptr];
    end
    
  end
assign empty = empty_flag;
assign full = full_flag;
  
endmodule
//----------------------------------------------


module FIFO_tb(dataIn,wr_en,rd_en, clk,rst, dataOut, empty,full);

parameter buffer_width = 8;
parameter FIFO_size = 12;
output reg [buffer_width-1 : 0] dataIn;
output reg wr_en,rd_en;
output reg clk;
output reg rst;
input wire [buffer_width-1 : 0] dataOut;
input wire empty,full;
parameter DELAY = 3;


FIFO #(.buffer_width(buffer_width),.FIFO_size(FIFO_size)) myFifo(
	.dataIn(dataIn),
	.wr_en(wr_en),
	.rd_en(rd_en),
	.clk(clk),
	.rst(rst),
	.dataOut(dataOut),
	.empty(empty),
	.full(full)


);

int i = 0;
initial begin
	clk=1'b0;
	wr_en=1'b0;
	rd_en=1'b0;
	rst=1'b1;
	dataIn='b0;

end

initial begin
	main;
end

task main;
	fork
		generateclk;
		generaterst;
		operation;
		
	join

endtask
task generateclk;
begin
	forever #DELAY clk=!clk;
end
endtask

task generaterst;
begin

#(DELAY*2) rst=1'b0;
#8.6 rst=1'b1;
#8.6 rst=1'b0;
end
endtask


task operation;
	begin  
           for (i = 0; i < 17; i = i + 1) begin: WRE  
                #(DELAY*5)  
                wr_en = 1'b1;  
                dataIn = dataIn + 8'd1;  
                #(DELAY*2)  
                wr_en = 1'b0;  
           end  
           #(DELAY)  
           for (i = 0; i < 17; i = i + 1) begin: RDE  
                #(DELAY*2)  
                rd_en = 1'b1;  
                #(DELAY*2)  
                rd_en = 1'b0;  
           end  
   end  

endtask
endmodule

