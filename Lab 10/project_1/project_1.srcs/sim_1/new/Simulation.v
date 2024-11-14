// Set the timescale for simulation
`timescale 1ns/1ps
module simulation();

        // Loop through each round and display results
integer i;
        
reg [0:63] data_in;
wire [0:63] data_out;
reg [0:47] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;
wire [0:63] R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16;

reg [0:63] IP1;
wire [0:63] IP_OUT;
	// Instantiate the final_permutation module
DES_Implementation uut (data_in,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16,data_out,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16);
initial_permutation IP_Module1 (IP1,IP_OUT);

reg [47:0] sbox_in;
wire [31:0] sbox_out;
Calculate_SBOX C_SP (sbox_in,sbox_out);

// Initial block for simulation setup
initial begin


//Testing out expansion box

//Testing out sbox in
 sbox_in = 48'b100101_100101_101010_000100_011111_011100_101111_010110;

 data_in = 64'h123456ABCD132536;
 //K1 = 48'b0001_1001_0100_1100_1101_0000_0111_0010_1101_1110_1000_1100;
 
 IP1 = 64'h123456ABCD132536;
 K1 = 48'h194C_D072_DE8C;
 K2 = 48'h4568_581A_BCCE;
 K3 = 48'h06ED_A4AC_F5B5;
 K4 = 48'hDA2D_032B_6EE3;
 K5 = 48'h69A6_29FE_C913;
 K6 = 48'hC194_8E87_475E;
 K7 = 48'h708A_D2DD_B3C0;
 K8 = 48'h34F8_22F0_C66D;
 K9 = 48'h84BB_4473_DCCC;
 K10 = 48'h0276_5708_B5BF;
 K11 = 48'h6D55_60AF_7CA5;
 K12 = 48'hC2C1_E96A_4BF3;
 K13 = 48'h99C3_1397_C91F;
 K14 = 48'h251B_8BC7_17D0;
 K15 = 48'h3330_C5D9_A36D;
 K16 = 48'h181C_5D75_C66D;
 #10 //to simulate propagation
   	 

        // Log the output values for each round
        $display("Starting DES Simulation...");
        $display("Initial Input: %h", data_in);
        

        for (i = 1; i <= 16; i = i + 1) begin
            #10;  // Wait to allow round processing
            $display("Round %0d Results:", i);
            $display("  Expansion Output (exp_out): %h", uut.exp_out[i]);
            $display("  After Key XOR (AK): %h", uut.AK[i]);
            $display("  S-Box Output (SBOX_out): %h", uut.SBOX_out[i]);
            $display("  Straight Permutation (SP): %h", uut.SP[i]);
            $display("  Round %0d Output: %h", i, {uut.L[i], uut.R[i]});
        end

        // Display final output
        $display("Final Output (Data Out): %h", data_out);
  // End the simulation
  #10;
  $finish;
end

endmodule
