`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 11:52:51 PM
// Design Name: 
// Module Name: DES_Implementation
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DES_Implementation(
    input [63:0] Input,
    output [63:0] Output
    );
endmodule

module initial_permutation(
    input [63:0] data_in,  // 64-bit input data
    output [63:0] data_out // 64-bit output data after permutation
);

// Perform the bit permutation according to the correct order (starting from data_out[0])
 //58 50 42 34 26 18 10 02
assign data_out[0] = data_in[57];   // Bit 58 to output 0
assign data_out[1] = data_in[49];   // Bit 50 to output 1
assign data_out[2] = data_in[41];   // Bit 42 to output 2
assign data_out[3] = data_in[33];   // Bit 34 to output 3
assign data_out[4] = data_in[25];   // Bit 26 to output 4
assign data_out[5] = data_in[17];   // Bit 18 to output 5
assign data_out[6] = data_in[9];    // Bit 10 to output 6
assign data_out[7] = data_in[1];    // Bit 02 to output 7

// 60 52 44 36 28 20 12 04
assign data_out[8] = data_in[59];   // Bit 60 to output 8
assign data_out[9] = data_in[51];   // Bit 52 to output 9
assign data_out[10] = data_in[43];  // Bit 44 to output 10
assign data_out[11] = data_in[35];  // Bit 36 to output 11
assign data_out[12] = data_in[27];  // Bit 28 to output 12
assign data_out[13] = data_in[19];  // Bit 20 to output 13
assign data_out[14] = data_in[11];  // Bit 12 to output 14
assign data_out[15] = data_in[3];   // Bit 04 to output 15

//  62 54 46 38 30 22 14 06
assign data_out[16] = data_in[61];  // Bit 62 to output 16
assign data_out[17] = data_in[53];  // Bit 54 to output 17
assign data_out[18] = data_in[45];  // Bit 46 to output 18
assign data_out[19] = data_in[37];  // Bit 38 to output 19
assign data_out[20] = data_in[29];  // Bit 30 to output 20
assign data_out[21] = data_in[21];  // Bit 22 to output 21
assign data_out[22] = data_in[13];  // Bit 14 to output 22
assign data_out[23] = data_in[5];   // Bit 06 to output 23

// 64 56 48 40 32 24 16 08
assign data_out[24] = data_in[63];  // Bit 64 to output 24
assign data_out[25] = data_in[55];  // Bit 56 to output 25
assign data_out[26] = data_in[47];  // Bit 48 to output 26
assign data_out[27] = data_in[39];  // Bit 40 to output 27
assign data_out[28] = data_in[31];  // Bit 32 to output 28
assign data_out[29] = data_in[23];  // Bit 24 to output 29
assign data_out[30] = data_in[15];  // Bit 16 to output 30
assign data_out[31] = data_in[7];   // Bit 08 to output 31

// 57 49 41 33 25 17 09 01
assign data_out[32] = data_in[56];  // Bit 57 to output 32
assign data_out[33] = data_in[48];  // Bit 49 to output 33
assign data_out[34] = data_in[40];  // Bit 41 to output 34
assign data_out[35] = data_in[32];  // Bit 33 to output 35
assign data_out[36] = data_in[24];  // Bit 25 to output 36
assign data_out[37] = data_in[16];  // Bit 17 to output 37
assign data_out[38] = data_in[8];   // Bit 09 to output 38
assign data_out[39] = data_in[0];   // Bit 01 to output 39

// 59 51 43 35 27 19 11 03
assign data_out[40] = data_in[58];  // Bit 59 to output 40
assign data_out[41] = data_in[50];  // Bit 51 to output 41
assign data_out[42] = data_in[42];  // Bit 43 to output 42
assign data_out[43] = data_in[34];  // Bit 35 to output 43
assign data_out[44] = data_in[26];  // Bit 27 to output 44
assign data_out[45] = data_in[18];  // Bit 19 to output 45
assign data_out[46] = data_in[10];  // Bit 11 to output 46
assign data_out[47] = data_in[2];   // Bit 03 to output 47

//  61 53 45 37 29 21 13 05
assign data_out[48] = data_in[60];  // Bit 61 to output 48
assign data_out[49] = data_in[52];  // Bit 53 to output 49
assign data_out[50] = data_in[44];  // Bit 45 to output 50
assign data_out[51] = data_in[36];  // Bit 37 to output 51
assign data_out[52] = data_in[28];  // Bit 29 to output 52
assign data_out[53] = data_in[20];  // Bit 21 to output 53
assign data_out[54] = data_in[12];  // Bit 13 to output 54
assign data_out[55] = data_in[4];   // Bit 05 to output 55

//63 55 47 39 31 23 15 07
assign data_out[56] = data_in[62];  // Bit 63 to output 56
assign data_out[57] = data_in[54];  // Bit 55 to output 57
assign data_out[58] = data_in[46];  // Bit 47 to output 58
assign data_out[59] = data_in[38];  // Bit 39 to output 59
assign data_out[60] = data_in[30];  // Bit 31 to output 60
assign data_out[61] = data_in[22];  // Bit 23 to output 61
assign data_out[62] = data_in[14];  // Bit 15 to output 62
assign data_out[63] = data_in[6];   // Bit 07 to output 63

endmodule

module final_permutation(
    input [63:0] data_in,  // 64-bit input data
    output [63:0] data_out // 64-bit output data after final permutation
);

// Perform the bit permutation according to the final permutation (FP) table
//40 08 48 16 56 24 64 32
assign data_out[0] = data_in[39];   // Bit 40 to output 0
assign data_out[1] = data_in[7];    // Bit 08 to output 1
assign data_out[2] = data_in[47];   // Bit 48 to output 2
assign data_out[3] = data_in[15];   // Bit 16 to output 3
assign data_out[4] = data_in[55];   // Bit 56 to output 4
assign data_out[5] = data_in[23];   // Bit 24 to output 5
assign data_out[6] = data_in[63];   // Bit 64 to output 6
assign data_out[7] = data_in[31];   // Bit 32 to output 7

//39 07 47 15 55 23 63 31
assign data_out[8] = data_in[38];   // Bit 39 to output 8
assign data_out[9] = data_in[6];    // Bit 07 to output 9
assign data_out[10] = data_in[46];  // Bit 47 to output 10
assign data_out[11] = data_in[14];  // Bit 15 to output 11
assign data_out[12] = data_in[54];  // Bit 55 to output 12
assign data_out[13] = data_in[22];  // Bit 23 to output 13
assign data_out[14] = data_in[62];  // Bit 63 to output 14
assign data_out[15] = data_in[30];  // Bit 31 to output 15

// 38 06 46 14 54 22 62 30
assign data_out[16] = data_in[37];  // Bit 38 to output 16
assign data_out[17] = data_in[5];   // Bit 06 to output 17
assign data_out[18] = data_in[45];  // Bit 46 to output 18
assign data_out[19] = data_in[13];  // Bit 14 to output 19
assign data_out[20] = data_in[53];  // Bit 54 to output 20
assign data_out[21] = data_in[21];  // Bit 22 to output 21
assign data_out[22] = data_in[61];  // Bit 62 to output 22
assign data_out[23] = data_in[29];  // Bit 30 to output 23

// 37 05 45 13 53 21 61 29
assign data_out[24] = data_in[36];  // Bit 37 to output 24
assign data_out[25] = data_in[4];   // Bit 05 to output 25
assign data_out[26] = data_in[44];  // Bit 45 to output 26
assign data_out[27] = data_in[12];  // Bit 13 to output 27
assign data_out[28] = data_in[52];  // Bit 53 to output 28
assign data_out[29] = data_in[20];  // Bit 21 to output 29
assign data_out[30] = data_in[60];  // Bit 61 to output 30
assign data_out[31] = data_in[28];  // Bit 29 to output 31

// 36 04 44 12 52 20 60 28
assign data_out[32] = data_in[35];  // Bit 36 to output 32
assign data_out[33] = data_in[3];   // Bit 04 to output 33
assign data_out[34] = data_in[43];  // Bit 44 to output 34
assign data_out[35] = data_in[11];  // Bit 12 to output 35
assign data_out[36] = data_in[51];  // Bit 52 to output 36
assign data_out[37] = data_in[19];  // Bit 20 to output 37
assign data_out[38] = data_in[59];  // Bit 60 to output 38
assign data_out[39] = data_in[27];  // Bit 28 to output 39

// 35 03 43 11 51 19 59 27
assign data_out[40] = data_in[34];  // Bit 35 to output 40
assign data_out[41] = data_in[2];   // Bit 03 to output 41
assign data_out[42] = data_in[42];  // Bit 43 to output 42
assign data_out[43] = data_in[10];  // Bit 11 to output 43
assign data_out[44] = data_in[50];  // Bit 51 to output 44
assign data_out[45] = data_in[18];  // Bit 19 to output 45
assign data_out[46] = data_in[58];  // Bit 59 to output 46
assign data_out[47] = data_in[26];  // Bit 27 to output 47

// 34 02 42 10 50 18 58 26
assign data_out[48] = data_in[33];  // Bit 34 to output 48
assign data_out[49] = data_in[1];   // Bit 01 to output 49
assign data_out[50] = data_in[41];  // Bit 41 to output 50
assign data_out[51] = data_in[9];   // Bit 09 to output 51
assign data_out[52] = data_in[49];  // Bit 49 to output 52
assign data_out[53] = data_in[17];  // Bit 17 to output 53
assign data_out[54] = data_in[57];  // Bit 57 to output 54
assign data_out[55] = data_in[25];  // Bit 25 to output 55

// 33 01 41 09 49 17 57 25
assign data_out[56] = data_in[32];  // Bit 33 to output 56
assign data_out[57] = data_in[0];   // Bit 01 to output 57
assign data_out[58] = data_in[40];  // Bit 41 to output 58
assign data_out[59] = data_in[8];   // Bit 09 to output 59
assign data_out[60] = data_in[48];  // Bit 49 to output 60
assign data_out[61] = data_in[16];  // Bit 17 to output 61
assign data_out[62] = data_in[56];  // Bit 57 to output 62
assign data_out[63] = data_in[24];  // Bit 25 to output 63

endmodule

module expansion_pbox(
    input [31:0] data_in,   // 32-bit input
    output [47:0] data_out  // 48-bit expanded output
);

// Perform the bit expansion according to the expansion P-box table
assign data_out[0] = data_in[31];  // Bit 32 to output 0
assign data_out[1] = data_in[0];   // Bit 01 to output 1
assign data_out[2] = data_in[1];   // Bit 02 to output 2
assign data_out[3] = data_in[2];   // Bit 03 to output 3
assign data_out[4] = data_in[3];   // Bit 04 to output 4
assign data_out[5] = data_in[4];   // Bit 05 to output 5

assign data_out[6] = data_in[3];   // Bit 04 to output 6
assign data_out[7] = data_in[4];   // Bit 05 to output 7
assign data_out[8] = data_in[5];   // Bit 06 to output 8
assign data_out[9] = data_in[6];   // Bit 07 to output 9
assign data_out[10] = data_in[7];  // Bit 08 to output 10
assign data_out[11] = data_in[8];  // Bit 09 to output 11

assign data_out[12] = data_in[7];  // Bit 08 to output 12
assign data_out[13] = data_in[8];  // Bit 09 to output 13
assign data_out[14] = data_in[9];  // Bit 10 to output 14
assign data_out[15] = data_in[10]; // Bit 11 to output 15
assign data_out[16] = data_in[11]; // Bit 12 to output 16
assign data_out[17] = data_in[12]; // Bit 13 to output 17

assign data_out[18] = data_in[11]; // Bit 12 to output 18
assign data_out[19] = data_in[12]; // Bit 13 to output 19
assign data_out[20] = data_in[13]; // Bit 14 to output 20
assign data_out[21] = data_in[14]; // Bit 15 to output 21
assign data_out[22] = data_in[15]; // Bit 16 to output 22
assign data_out[23] = data_in[16]; // Bit 17 to output 23

assign data_out[24] = data_in[15]; // Bit 16 to output 24
assign data_out[25] = data_in[16]; // Bit 17 to output 25
assign data_out[26] = data_in[17]; // Bit 18 to output 26
assign data_out[27] = data_in[18]; // Bit 19 to output 27
assign data_out[28] = data_in[19]; // Bit 20 to output 28
assign data_out[29] = data_in[20]; // Bit 21 to output 29

assign data_out[30] = data_in[19]; // Bit 20 to output 30
assign data_out[31] = data_in[20]; // Bit 21 to output 31
assign data_out[32] = data_in[21]; // Bit 22 to output 32
assign data_out[33] = data_in[22]; // Bit 23 to output 33
assign data_out[34] = data_in[23]; // Bit 24 to output 34
assign data_out[35] = data_in[24]; // Bit 25 to output 35

assign data_out[36] = data_in[23]; // Bit 24 to output 36
assign data_out[37] = data_in[24]; // Bit 25 to output 37
assign data_out[38] = data_in[25]; // Bit 26 to output 38
assign data_out[39] = data_in[26]; // Bit 27 to output 39
assign data_out[40] = data_in[27]; // Bit 28 to output 40
assign data_out[41] = data_in[28]; // Bit 29 to output 41

assign data_out[42] = data_in[27]; // Bit 28 to output 42
assign data_out[43] = data_in[28]; // Bit 29 to output 43
assign data_out[44] = data_in[29]; // Bit 30 to output 44
assign data_out[45] = data_in[30]; // Bit 31 to output 45
assign data_out[46] = data_in[31]; // Bit 32 to output 46
assign data_out[47] = data_in[0];  // Bit 01 to output 47

endmodule



