// Set the timescale for simulation
`timescale 1ns/1ps
module Key_generator();

reg [0:63] key_in;
wire [0:47] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;
wire [0:55] parity_out;

wire [0:27] key_in_cp1;
wire [0:27] key_in_cp2;
wire [0:47] cp_out;

    reg [4:0] round;           // Current round number (supports up to 16 rounds)
    reg [27:0] left_in;        // 28-bit left half of the cipher key
    reg [27:0] right_in;        // 28-bit right half of the cipher key
    wire [27:0] L_CK;        // Shifted left half
    wire [27:0] R_CK;
    
key_generation uut (key_in,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16);
Parity_Drop uut2(key_in, parity_out);
CircularShift cs(round, left_in, right_in, key_in_cp1, key_in_cp2);
Compression_PBOX_Key uut3(key_in_cp1, key_in_cp2,cp_out);


initial begin
 key_in = 64'hAABB09182736CCDD;
 round = 5'b00001;
 left_in = 28'hC3C033A;
 right_in = 28'h33F0CFA;
// key_in_cp1 = ;
// K2 = 48'h4568_581A_BCCE;
// K3 = 48'h06ED_A4AC_F5B5;
// K4 = 48'hDA2D_032B_6EE3;
// K5 = 48'h69A6_29FE_C913;
// K6 = 48'hC194_8E87_475E;
// K7 = 48'h708A_D2DD_B3C0;
// K8 = 48'h34F8_22F0_C66D;
// K9 = 48'h84BB_4473_DCCC;
// K10 = 48'h0276_5708_B5BF;
// K11 = 48'h6D55_60AF_7CA5;
// K12 = 48'hC2C1_E96A_4BF3;
// K13 = 48'h99C3_1397_C91F;
// K14 = 48'h251B_8BC7_17D0;
// K15 = 48'h3330_C5D9_A36D;
// K16 = 48'h181C_5D75_C66D;
 #10 //to simulate propagation
  $finish;
end

endmodule
