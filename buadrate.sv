interface baudRate_intf(input clk);
//we are using interface to organize signals to or from the design
logic [1:0] IN;
logic OUT;
logic rst;


//prevent any timing race by using clocking block

clocking ck @(posedge clk);
	default input #5ns output #2ns;
	output IN,rst;
	input OUT;
endclocking

/*mode port is important to redefine the signal mode to different modules
sharing the same signals*/

modport DUT(input IN,rst,output OUT);
modport drive(clocking ck);

endinterface



module baud_rate(
	baudRate_intf.DUT a,
	input bit clk

);
parameter freq=50000000;

reg [9:0] FINAL_VALUE;	//baudrate=9600;

logic [9:0] counter;
always @(*)begin
case(a.IN)
	2'b00: FINAL_VALUE = 10'd325;	//baudrate=9600 in freq= 50MHz
	2'b01: FINAL_VALUE = 10'd162;	//baudrate=19200;
	2'b10: FINAL_VALUE = 10'd54;	//baudrate=57600;
	2'b11: FINAL_VALUE = 10'd27;	//baudrate=115200;
	default: FINAL_VALUE = 10'd325;
endcase
end

always_ff@(posedge clk,posedge a.rst)
begin
	if(a.rst)begin
		counter = 'd0;
	end else begin
		if(counter== FINAL_VALUE)begin
			counter ='d0; 
		end else begin
			counter= counter + 1'd1;
		end 
	end

$display("FINAL VALUE: %0d  counter: %0d ",FINAL_VALUE,counter);
end

assign a.OUT = (counter==FINAL_VALUE);

endmodule
//-----------------------------------------------
module baud_rate_tb (baudRate_intf.drive b
	
);
	
	


	
	initial begin
		#0 b.ck.rst<=1'b1;
		b.ck.IN <= 2'b10;
			
		#17 b.ck.rst<=1'b0;
		
	end

endmodule

module top;
bit clk;
always #10 clk=~clk;

baudRate_intf i(clk);

baud_rate m1(.a(i.DUT),
	     .clk(clk));

baud_rate_tb t1(i.drive);
endmodule