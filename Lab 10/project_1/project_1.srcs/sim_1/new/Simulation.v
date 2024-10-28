// Set the timescale for simulation
`timescale 1ns/1ps
module simulation();

reg [0:63] data_in;
wire [0:63] data_out;
reg [0:47] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;

reg [0:63] IP1;
wire [0:63] IP_OUT;
	// Instantiate the final_permutation module
DES_Implementation uut (data_in,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16,data_out);
initial_permutation IP_Module1 (IP1,IP_OUT);

// Initial block for simulation setup
initial begin
// Initialize input with hex value "123456ABCD132536"
 data_in = 64'h123456ABCD132536;
 K1 = 48'b0001_1001_0100_1100_1101_0000_0111_0010_1101_1110_1000_1100;
 
 IP1 = 64'h123456ABCD132536;
 K2 = 48'b0;
 K3 = 48'b0;
 K4 = 48'b0;
 K5 = 48'b0;
 K6 = 48'b0;
 K7 = 48'b0;
 K8 = 48'b0;
 K9 = 48'b0;
 K10 = 48'b0;
 K11 = 48'b0;
 K12 = 48'b0;
 K13 = 48'b0;
 K14 = 48'b0;
 K15 = 48'b0;
 K16 = 48'b0;
 #10 //to simulate propagation
   	 
  // End the simulation
  #10;
  $finish;
end

endmodule
