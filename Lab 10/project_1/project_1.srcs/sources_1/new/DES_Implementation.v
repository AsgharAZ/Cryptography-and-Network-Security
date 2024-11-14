`timescale 1ns / 1ps
module DES_Implementation2(
    input [0:63] Input,
    input[0:47] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16,
    output [0:63] Output
    );
    wire [0:31] L0,L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12,L13,L14,L15,L16;
    wire [0:31] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16;
    
    wire [0:63] ip;
    initial_permutation IP1 (Input,ip);
    
    //Before key
    //wire [0:47] BK1,BK2,BK3,BK4,BK5,BK6,BK7,BK8,BK9,BK10,BK11,BK12,BK13,BK14,BK15,BK16;
    //After key
    wire [0:47] AK1,AK2,AK3,AK4,AK5,AK6,AK7,AK8,AK9,AK10,AK11,AK12,AK13,AK14,AK15,AK16;
    //Before XORing finally at the end
    wire [0:31] BL1,BL2,BL3,BL4,BL5,BL6,BL7,BL8,BL9,BL10,BL11,BL12,BL13,BL14,BL15,BL16;
    // After Straight Permutation
    wire [0:31] SP1,SP2,SP3,SP4,SP5,SP6,SP7,SP8,SP9,SP10,SP11,SP12,SP13,SP14,SP15,SP16;
    
    //after permutation dividing into 2 parts
    assign L0 = ip[0:31];
    assign R0 = ip[31:63];
    
    assign L1 = R0;
    //getting through expansion key-bo  x then xor'ing
    wire [0:48] exp_o;
    expansion_pbox Exp1(R0,exp_o); //k
    assign AK1 = exp_o ^ K1; //Xor expansion P-box value with K1
    
    Calculate_SBOX SB1(AK1, BL1);
    //straight P-box (XOR with l_0)
    Straight_permutation StraightP1(BL1, SP1);
    assign R1 = L0 ^ SP1;
    assign Output = {L1,R1};
    
endmodule

module DES_Implementation(
    input [0:63] Input,
    input [0:47] K1, K2, K3, K4, K5, K6, K7, K8, K9, K10, K11, K12, K13, K14, K15, K16,
    output [0:63] Output,
    output [0:63] Round1Output, Round2Output, Round3Output, Round4Output,
    output [0:63] Round5Output, Round6Output, Round7Output, Round8Output,
    output [0:63] Round9Output, Round10Output, Round11Output, Round12Output,
    output [0:63] Round13Output, Round14Output, Round15Output, Round16Output
    );

    wire [0:31] L[0:16];  // Left parts for each round
    wire [0:31] R[0:16];  // Right parts for each round
    wire [0:63] ip;       // Initial Permutation output

    // Initial Permutation
    initial_permutation IP1(Input, ip);
    
    //key_generation
    
    // Divide input into left and right halves after initial permutation
    assign L[0] = ip[0:31];
    assign R[0] = ip[32:63];

    // Declare wires for intermediate values within each round
    wire [0:47] exp_out[1:16];   // Expansion P-box output for each round
    wire [0:47] AK[1:16];        // After XOR with key
    wire [0:31] SBOX_out[1:16];  // S-box output for each round
    wire [0:31] SP[1:16];        // Straight P-box output for each round

    // Loop through each of the 16 rounds
    genvar i;
    generate
    /////////////////////////
        for (i = 1; i <= 16; i = i + 1) begin : DES_rounds
            // Expansion P-box on the right half of the previous round
            expansion_pbox Exp(R[i-1], exp_out[i]);

            // XOR with round key
            assign AK[i] = exp_out[i] ^ (i == 1 ? K1 : 
                                         i == 2 ? K2 : 
                                         i == 3 ? K3 : 
                                         i == 4 ? K4 : 
                                         i == 5 ? K5 : 
                                         i == 6 ? K6 : 
                                         i == 7 ? K7 : 
                                         i == 8 ? K8 : 
                                         i == 9 ? K9 : 
                                         i == 10 ? K10 : 
                                         i == 11 ? K11 : 
                                         i == 12 ? K12 : 
                                         i == 13 ? K13 : 
                                         i == 14 ? K14 : 
                                         i == 15 ? K15 : K16);

            // S-Box processing
            Calculate_SBOX SB(AK[i], SBOX_out[i]);

            // Straight Permutation
            Straight_permutation SP_perm(SBOX_out[i], SP[i]);

            // Compute the next right half and left half
            assign L[i] = R[i-1];
            assign R[i] = L[i-1] ^ SP[i];
            
            // Output for each round's result as concatenation of left and right parts      
        end
    endgenerate

        // Assign each round's result to its respective output
    assign Round1Output = {L[1], R[1]};
    assign Round2Output = {L[2], R[2]};
    assign Round3Output = {L[3], R[3]};
    assign Round4Output = {L[4], R[4]};
    assign Round5Output = {L[5], R[5]};
    assign Round6Output = {L[6], R[6]};
    assign Round7Output = {L[7], R[7]};
    assign Round8Output = {L[8], R[8]};
    assign Round9Output = {L[9], R[9]};
    assign Round10Output = {L[10], R[10]};
    assign Round11Output = {L[11], R[11]};
    assign Round12Output = {L[12], R[12]};
    assign Round13Output = {L[13], R[13]};
    assign Round14Output = {L[14], R[14]};
    assign Round15Output = {L[15], R[15]};
    assign Round16Output = {L[16], R[16]};
    
    // Final output without the swap of the last round
    assign Output = {L[16], R[16]};
    
endmodule



module initial_permutation(
    input [0:63] data_in,  // 64-bit input data
    output [0:63] data_out // 64-bit output data after permutation
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
    input [0:63] data_in,  // 64-bit input data
    output [0:63] data_out // 64-bit output data after final permutation
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

module xor_48bit(
    input [47:0] num1,  // First 48-bit input
    input [47:0] num2,  // Second 48-bit input
    output [47:0] result  // 48-bit XOR result
);

// XOR operation between the two 48-bit numbers
assign result = num1 ^ num2;

endmodule

module Calculate_SBOX(
    input [47:0] in,
    output[31:0] out
    );
    wire [5:0] si0,si1,si2,si3,si4,si5,si6,si7;
    
    S_box_pre_calculation sp0(in[5:0],si0);
    S_box_pre_calculation sp1(in[11:6],si1);
    S_box_pre_calculation sp2(in[17:12],si2);
    S_box_pre_calculation sp3(in[23:18],si3);
    S_box_pre_calculation sp4(in[29:24],si4);
    S_box_pre_calculation sp5(in[35:30],si5);
    S_box_pre_calculation sp6(in[41:36],si6);
    S_box_pre_calculation sp7(in[47:42],si7);
    
    S8 sc0(si0 , out[3:0]);
    S7 sc1(si1 , out[7:4]);
    S6 sc2(si2 , out[11:8]);
    S5 sc3(si3 , out[15:12]);
    S4 sc4(si4 , out[19:16]);
    S3 sc5(si5 , out[23:20]);
    S2 sc6(si6 , out[27:24]);
    S1 sc7(si7 , out[31:28]);
    
endmodule 

module S_box_pre_calculation( 
    input [5:0] in,
    output reg [5:0] out
    );
    
  always @* begin
    out = 6'b000000; // Initialize to 0
    case (in)
        6'b0_0000_0: out = 0;
        6'b0_0001_0: out = 1;
        6'b0_0010_0: out = 2;
        6'b0_0011_0: out = 3;
        6'b0_0100_0: out = 4;
        6'b0_0101_0: out = 5;
        6'b0_0110_0: out = 6;
        6'b0_0111_0: out = 7;
        6'b0_1000_0: out = 8;
        6'b0_1001_0: out = 9;
        6'b0_1010_0: out = 10;
        6'b0_1011_0: out = 11;
        6'b0_1100_0: out = 12;
        6'b0_1101_0: out = 13;
        6'b0_1110_0: out = 14;
        6'b0_1111_0: out = 15;

        6'b0_0000_1: out = 16;
        6'b0_0001_1: out = 17;
        6'b0_0010_1: out = 18;
        6'b0_0011_1: out = 19;
        6'b0_0100_1: out = 20;
        6'b0_0101_1: out = 21;
        6'b0_0110_1: out = 22;
        6'b0_0111_1: out = 23;
        6'b0_1000_1: out = 24;
        6'b0_1001_1: out = 25;
        6'b0_1010_1: out = 26;
        6'b0_1011_1: out = 27;
        6'b0_1100_1: out = 28;
        6'b0_1101_1: out = 29;
        6'b0_1110_1: out = 30;
        6'b0_1111_1: out = 31;

        6'b1_0000_0: out = 32;
        6'b1_0001_0: out = 33;
        6'b1_0010_0: out = 34;
        6'b1_0011_0: out = 35;
        6'b1_0100_0: out = 36;
        6'b1_0101_0: out = 37;
        6'b1_0110_0: out = 38;
        6'b1_0111_0: out = 39;
        6'b1_1000_0: out = 40;
        6'b1_1001_0: out = 41;
        6'b1_1010_0: out = 42;
        6'b1_1011_0: out = 43;
        6'b1_1100_0: out = 44;
        6'b1_1101_0: out = 45;
        6'b1_1110_0: out = 46;
        6'b1_1111_0: out = 47;

        6'b1_0000_1: out = 48;
        6'b1_0001_1: out = 49;
        6'b1_0010_1: out = 50;
        6'b1_0011_1: out = 51;
        6'b1_0100_1: out = 52;
        6'b1_0101_1: out = 53;
        6'b1_0110_1: out = 54;
        6'b1_0111_1: out = 55;
        6'b1_1000_1: out = 56;
        6'b1_1001_1: out = 57;
        6'b1_1010_1: out = 58;
        6'b1_1011_1: out = 59;
        6'b1_1100_1: out = 60;
        6'b1_1101_1: out = 61;
        6'b1_1110_1: out = 62;
        6'b1_1111_1: out = 63;
      default: out = 0;
    endcase
    end
endmodule


module S1(
    input [5:0] in, 
    output reg [3:0] out
    );
    
   initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  always @* case (in)
    0 : out = 14;
    1 : out = 4;
    2 : out = 13;
    3 : out = 01;
    4 : out = 02;
    5 : out = 15;
    6 : out = 11;
    7 : out = 08;
    8 : out = 03;
    9 : out = 10;
    10 : out = 06;
    11 : out = 12;
    12 : out = 05;
    13 : out = 09;
    14 : out = 00;
    15 : out = 07;
    
    16 : out = 0;
    17 : out = 15;
    18 : out = 07;
    19 : out = 04;
    20 : out = 14;
    21 : out = 02;
    22 : out = 13;
    23 : out = 10;
    24 : out = 03;
    25 : out = 06;
    26 : out = 12;
    27 : out = 11;
    28 : out = 09;
    29 : out = 05;
    30 : out = 03;
    31 : out = 08;
    
    32 : out = 04;
    33 : out = 01;
    34 : out = 14;
    35 : out = 08;
    36 : out = 13;
    37 : out = 06;
    38 : out = 02;
    39 : out = 11;
    40 : out = 15;
    41 : out = 12;
    42 : out = 09;
    43 : out = 07;
    44 : out = 03;
    45 : out = 10;
    46 : out = 05;
    47 : out = 00;
    
    48 : out = 15;
    49 : out = 12;
    50 : out = 08;
    51 : out = 02;
    52 : out = 04;
    53 : out = 09;
    54 : out = 01;
    55 : out = 07;
    56 : out = 05;
    57 : out = 11;
    58 : out = 03;
    59 : out = 14;
    60 : out = 10;
    61 : out = 00;
    62 : out = 06;
    63 : out = 13;
  endcase
endmodule
module S2(
    input [5:0] in, 
    output reg [3:0] out
    );
    initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  always @* case (in)
  //15 01 08 14 06 11 03 04 09 07 02 13 12 00 05 10
    0 : out = 15;
    1 : out = 01;
    2 : out = 08;
    3 : out = 14;
    4 : out = 06;
    5 : out = 11;
    6 : out = 03;
    7 : out = 04;
    8 : out = 09;
    9 : out = 07;
    10 : out = 02;
    11 : out = 13;
    12 : out = 12;
    13 : out = 00;
    14 : out = 05;
    15 : out = 10;
    
    //03 13 04 07 15 02 08 14 12 00 01 10 06 09 11 05
    16 : out = 03;
    17 : out = 13;
    18 : out = 04;
    19 : out = 07;
    20 : out = 15;
    21 : out = 02;
    22 : out = 08;
    23 : out = 14;
    24 : out = 12;
    25 : out = 00;
    26 : out = 01;
    27 : out = 10;
    28 : out = 06;
    29 : out = 09;
    30 : out = 11;
    31 : out = 05;
    
    32 : out = 00;
    33 : out = 14;
    34 : out = 07;
    35 : out = 11;
    36 : out = 10;
    37 : out = 04;
    38 : out = 13;
    39 : out = 01;
    40 : out = 05;
    41 : out = 08;
    42 : out = 12;
    43 : out = 06;
    44 : out = 09;
    45 : out = 03;
    46 : out = 02;
    47 : out = 15;
    
    48 : out = 13;
    49 : out = 08;
    50 : out = 10;
    51 : out = 01;
    52 : out = 03;
    53 : out = 15;
    54 : out = 04;
    55 : out = 02;
    56 : out = 11;
    57 : out = 06;
    58 : out = 07;
    59 : out = 12;
    60 : out = 00;
    61 : out = 05;
    62 : out = 14;
    63 : out = 09;
  endcase
endmodule
module S3(input [5:0] in, output reg [3:0] out);

  initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  always @* case (in)
    0 : out = 10;
    1 : out = 00;
    2 : out = 09;
    3 : out = 14;
    4 : out = 06;
    5 : out = 03;
    6 : out = 15;
    7 : out = 05;
    8 : out = 01;
    9 : out = 13;
    10 : out = 12;
    11 : out = 07;
    12 : out = 11;
    13 : out = 04;
    14 : out = 02;
    15 : out = 08;
    
    16 : out = 13;
    17 : out = 07;
    18 : out = 00;
    19 : out = 09;
    20 : out = 03;
    21 : out = 04;
    22 : out = 06;
    23 : out = 10;
    24 : out = 02;
    25 : out = 08;
    26 : out = 05;
    27 : out = 14;
    28 : out = 12;
    29 : out = 11;
    30 : out = 15;
    31 : out = 01;
    
    32 : out = 13;
    33 : out = 06;
    34 : out = 04;
    35 : out = 09;
    36 : out = 08;
    37 : out = 15;
    38 : out = 03;
    39 : out = 00;
    40 : out = 11;
    41 : out = 01;
    42 : out = 02;
    43 : out = 12;
    44 : out = 05;
    45 : out = 10;
    46 : out = 14;
    47 : out = 07;
    
    48 : out = 01;
    49 : out = 10;
    50 : out = 13;
    51 : out = 00;
    52 : out = 06;
    53 : out = 09;
    54 : out = 08;
    55 : out = 07;
    56 : out = 04;
    57 : out = 15;
    58 : out = 14;
    59 : out = 03;
    60 : out = 11;
    61 : out = 05;
    62 : out = 02;
    63 : out = 12;
  endcase
endmodule
module S4(input [5:0] in, output reg [3:0] out);

  initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  always @* case (in)
    0 : out = 07;
    1 : out = 13;
    2 : out = 14;
    3 : out = 03;
    4 : out = 00;
    5 : out = 06;
    6 : out = 09;
    7 : out = 10;
    8 : out = 01;
    9 : out = 02;
    10 : out = 08;
    11 : out = 05;
    12 : out = 11;
    13 : out = 12;
    14 : out = 04;
    15 : out = 15;
    
    16 : out = 13;
    17 : out = 08;
    18 : out = 11;
    19 : out = 05;
    20 : out = 06;
    21 : out = 15;
    22 : out = 00;
    23 : out = 03;
    24 : out = 04;
    25 : out = 07;
    26 : out = 02;
    27 : out = 12;
    28 : out = 01;
    29 : out = 10;
    30 : out = 14;
    31 : out = 09;
    
    32 : out = 10;
    33 : out = 06;
    34 : out = 09;
    35 : out = 00;
    36 : out = 12;
    37 : out = 11;
    38 : out = 07;
    39 : out = 13;
    40 : out = 15;
    41 : out = 01;
    42 : out = 03;
    43 : out = 14;
    44 : out = 05;
    45 : out = 02;
    46 : out = 08;
    47 : out = 04;
    
    48 : out = 03;
    49 : out = 15;
    50 : out = 00;
    51 : out = 06;
    52 : out = 10;
    53 : out = 01;
    54 : out = 13;
    55 : out = 08;
    56 : out = 09;
    57 : out = 04;
    58 : out = 05;
    59 : out = 11;
    60 : out = 12;
    61 : out = 07;
    62 : out = 02;
    63 : out = 14;
  endcase
endmodule
module S5(input [5:0] in, output reg [3:0] out);

  initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  
  always @* case (in)
    0 : out = 02;
    1 : out = 12;
    2 : out = 04;
    3 : out = 01;
    4 : out = 07;
    5 : out = 10;
    6 : out = 11;
    7 : out = 06;
    8 : out = 08;
    9 : out = 05;
    10 : out = 03;
    11 : out = 15;
    12 : out = 13;
    13 : out = 00;
    14 : out = 14;
    15 : out = 09;
    
    16 : out = 14;
    17 : out = 11;
    18 : out = 02;
    19 : out = 12;
    20 : out = 04;
    21 : out = 07;
    22 : out = 13;
    23 : out = 01;
    24 : out = 05;
    25 : out = 00;
    26 : out = 15;
    27 : out = 10;
    28 : out = 03;
    29 : out = 09;
    30 : out = 08;
    31 : out = 06;
    
    32 : out = 04;
    33 : out = 02;
    34 : out = 01;
    35 : out = 11;
    36 : out = 10;
    37 : out = 13;
    38 : out = 07;
    39 : out = 08;
    40 : out = 15;
    41 : out = 09;
    42 : out = 12;
    43 : out = 05;
    44 : out = 06;
    45 : out = 03;
    46 : out = 00;
    47 : out = 14;
    
    48 : out = 11;
    49 : out = 08;
    50 : out = 12;
    51 : out = 07;
    52 : out = 01;
    53 : out = 14;
    54 : out = 02;
    55 : out = 13;
    56 : out = 06;
    57 : out = 15;
    58 : out = 00;
    59 : out = 09;
    60 : out = 10;
    61 : out = 04;
    62 : out = 05;
    63 : out = 03;
  endcase
endmodule
module S6(input [5:0] in, output reg [3:0] out);

  initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  
  always @* case (in)
    0 : out = 12;
    1 : out = 01;
    2 : out = 10;
    3 : out = 15;
    4 : out = 09;
    5 : out = 02;
    6 : out = 06;
    7 : out = 08;
    8 : out = 00;
    9 : out = 13;
    10 : out = 03;
    11 : out = 04;
    12 : out = 14;
    13 : out = 07;
    14 : out = 05;
    15 : out = 11;
    
    16 : out = 10;
    17 : out = 15;
    18 : out = 04;
    19 : out = 02;
    20 : out = 07;
    21 : out = 12;
    22 : out = 09;
    23 : out = 05;
    24 : out = 06;
    25 : out = 01;
    26 : out = 13;
    27 : out = 14;
    28 : out = 00;
    29 : out = 11;
    30 : out = 03;
    31 : out = 08;
    
    32 : out = 09;
    33 : out = 14;
    34 : out = 15;
    35 : out = 05;
    36 : out = 02;
    37 : out = 08;
    38 : out = 12;
    39 : out = 03;
    40 : out = 07;
    41 : out = 00;
    42 : out = 04;
    43 : out = 10;
    44 : out = 01;
    45 : out = 13;
    46 : out = 11;
    47 : out = 06;
    
    48 : out = 04;
    49 : out = 03;
    50 : out = 02;
    51 : out = 12;
    52 : out = 09;
    53 : out = 05;
    54 : out = 15;
    55 : out = 10;
    56 : out = 11;
    57 : out = 14;
    58 : out = 01;
    59 : out = 07;
    60 : out = 10;
    61 : out = 00;
    62 : out = 08;
    63 : out = 13;
  endcase
endmodule
module S7(input [5:0] in, output reg [3:0] out);

  initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  always @* case (in)
    0 : out = 04;
    1 : out = 11;
    2 : out = 02;
    3 : out = 14;
    4 : out = 15;
    5 : out = 00;
    6 : out = 08;
    7 : out = 13;
    8 : out = 03;
    9 : out = 12;
    10 : out = 09;
    11 : out = 07;
    12 : out = 05;
    13 : out = 10;
    14 : out = 06;
    15 : out = 01;
    
    16 : out = 13;
    17 : out = 00;
    18 : out = 11;
    19 : out = 07;
    20 : out = 04;
    21 : out = 09;
    22 : out = 01;
    23 : out = 10;
    24 : out = 14;
    25 : out = 03;
    26 : out = 05;
    27 : out = 12;
    28 : out = 02;
    29 : out = 15;
    30 : out = 08;
    31 : out = 06;
    
    32 : out = 01;
    33 : out = 04;
    34 : out = 11;
    35 : out = 13;
    36 : out = 12;
    37 : out = 03;
    38 : out = 07;
    39 : out = 14;
    40 : out = 10;
    41 : out = 15;
    42 : out = 06;
    43 : out = 08;
    44 : out = 00;
    45 : out = 05;
    46 : out = 09;
    47 : out = 02;
    
    48 : out = 06;
    49 : out = 11;
    50 : out = 13;
    51 : out = 08;
    52 : out = 01;
    53 : out = 04;
    54 : out = 10;
    55 : out = 07;
    56 : out = 09;
    57 : out = 05;
    58 : out = 00;
    59 : out = 15;
    60 : out = 14;
    61 : out = 02;
    62 : out = 03;
    63 : out = 12;
  endcase
endmodule
module S8(input [5:0] in, output reg [3:0] out);
   initial begin
    out = 4'b0000;  // Initialize out to 0
  end
  
  always @* case (in)
    0 : out = 13;
    1 : out = 02;
    2 : out = 08;
    3 : out = 04;
    4 : out = 06;
    5 : out = 15;
    6 : out = 11;
    7 : out = 01;
    8 : out = 10;
    9 : out = 09;
    10 : out = 03;
    11 : out = 14;
    12 : out = 05;
    13 : out = 00;
    14 : out = 12;
    15 : out = 07;
    
    16 : out = 01;
    17 : out = 15;
    18 : out = 13;
    19 : out = 08;
    20 : out = 10;
    21 : out = 03;
    22 : out = 07;
    23 : out = 04;
    24 : out = 12;
    25 : out = 05;
    26 : out = 06;
    27 : out = 11;
    28 : out = 10;
    29 : out = 14;
    30 : out = 09;
    31 : out = 02;
    
    32 : out = 07;
    33 : out = 11;
    34 : out = 04;
    35 : out = 01;
    36 : out = 09;
    37 : out = 12;
    38 : out = 14;
    39 : out = 02;
    40 : out = 00;
    41 : out = 06;
    42 : out = 10;
    43 : out = 10;
    44 : out = 15;
    45 : out = 03;
    46 : out = 05;
    47 : out = 08;
    
    48 : out = 02;
    49 : out = 01;
    50 : out = 14;
    51 : out = 07;
    52 : out = 04;
    53 : out = 10;
    54 : out = 08;
    55 : out = 13;
    56 : out = 15;
    57 : out = 12;
    58 : out = 09;
    59 : out = 09;
    60 : out = 03;
    61 : out = 05;
    62 : out = 06;
    63 : out = 11;
  endcase
endmodule

module Straight_permutation(
    input  [0:31] in,   // 32-bit input
    output [0:31] out   // 32-bit output
    );

    assign out[0]  = in[15];  // 16
    assign out[1]  = in[6];   // 07
    assign out[2]  = in[19];  // 20
    assign out[3]  = in[20];  // 21
    assign out[4]  = in[28];  // 29
    assign out[5]  = in[11];  // 12
    assign out[6]  = in[27];  // 28
    assign out[7]  = in[16];  // 17
    assign out[8]  = in[0];   // 01
    assign out[9]  = in[14];  // 15
    assign out[10] = in[22];  // 23
    assign out[11] = in[25];  // 26
    assign out[12] = in[4];   // 05
    assign out[13] = in[17];  // 18
    assign out[14] = in[30];  // 31
    assign out[15] = in[9];   // 10
    assign out[16] = in[1];   // 02
    assign out[17] = in[7];   // 08
    assign out[18] = in[23];  // 24
    assign out[19] = in[13];  // 14
    assign out[20] = in[31];  // 32
    assign out[21] = in[26];  // 27
    assign out[22] = in[2];   // 03
    assign out[23] = in[8];   // 09
    assign out[24] = in[18];  // 19
    assign out[25] = in[12];  // 13
    assign out[26] = in[29];  // 30
    assign out[27] = in[5];   // 06
    assign out[28] = in[21];  // 22
    assign out[29] = in[10];  // 11
    assign out[30] = in[3];   // 04
    assign out[31] = in[24];  // 25
endmodule

module key_generation(
    input [63:0] in,               // Initial 64-bit key with parity bits
    output reg [47:0] k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16 // 48-bit keys for each round
);

    wire [55:0] cipher_key;        // 56-bit cipher key after parity drop
    wire [27:0] left, right;        // 28-bit left and right halves of the cipher key for each round
    wire [27:0] L_CK, R_CK;         // Shifted left and right halves for the current round
    wire [47:0] round_key [1:16];  // Array to hold 48-bit keys for each round

    // Instantiate the Parity Drop module to generate the 56-bit key from the 64-bit input
    Parity_Drop parity_drop(in, cipher_key);
    assign left = cipher_key[55:28]; 
    assign right = cipher_key[27:0];
    
    // Loop through each of the 16 rounds
    genvar j;
    generate
    /////////////////////////
        for (j = 1; j <= 16; j = j + 1) begin : Key_generation
             Compression_PBOX_Key cpbox(left,right,round_key[j]);
             CircularShift CS(j, left,right,L_CK, R_CK);
            // Update left and right halves after shifting for the next round
            assign left = L_CK;
            assign right = R_CK;

            always @(*) begin
            case (j)
                1:  assign k1 = round_key[j];
                2:  assign k2 = round_key[j];
                3:  assign k3 = round_key[j];
                4:  assign k4 = round_key[j];
                5:  assign k5 = round_key[j];
                6:  assign k6 = round_key[j];
                7:  assign k7 = round_key[j];
                8:  assign k8 = round_key[j];
                9:  assign k9 = round_key[j];
                10: assign k10 = round_key[j];
                11: assign k11 = round_key[j];
                12: assign k12 = round_key[j];
                13: assign k13 = round_key[j];
                14: assign k14 = round_key[j];
                15: assign k15 = round_key[j];
                16: assign k16 = round_key[j];
            endcase
            end
        end
    endgenerate
endmodule

module CircularShift(
    input [4:0] round,             // Current round number (supports up to 16 rounds)
    input [27:0] left_in,          // 28-bit left half of the cipher key
    input [27:0] right_in,         // 28-bit right half of the cipher key
    output reg [27:0] L_CK,        // Shifted left half
    output reg [27:0] R_CK         // Shifted right half
);

    always @(*) begin
        if (round == 1 || round == 2 || round == 9 || round == 16) begin
            // 1-bit left circular shift for rounds 1, 2, 9, and 16
            L_CK = {left_in[26:0], left_in[27]};
            R_CK = {right_in[26:0], right_in[27]};
        end else begin
            // 2-bit left circular shift for other rounds
            L_CK = {left_in[25:0], left_in[27:26]};
            R_CK = {right_in[25:0], right_in[27:26]};
        end
    end

endmodule




module Parity_Drop(
    input [0:63] k_PB,  // Key with Parity Bits (64 bits) 
    output [0:55] C_k   // Cipher Key (56 bits)
);

    // Assign output bits based on the given table with zero-based indexing
    assign C_k[0]  = k_PB[56];
    assign C_k[1]  = k_PB[48];
    assign C_k[2]  = k_PB[40];
    assign C_k[3]  = k_PB[32];
    assign C_k[4]  = k_PB[24];
    assign C_k[5]  = k_PB[16];
    assign C_k[6]  = k_PB[8];
    assign C_k[7]  = k_PB[0];
    
    assign C_k[8]  = k_PB[57];
    assign C_k[9]  = k_PB[49];
    assign C_k[10] = k_PB[41];
    assign C_k[11] = k_PB[33];
    assign C_k[12] = k_PB[25];
    assign C_k[13] = k_PB[17];
    assign C_k[14] = k_PB[9];
    assign C_k[15] = k_PB[1];
    
    assign C_k[16] = k_PB[58];
    assign C_k[17] = k_PB[50];
    assign C_k[18] = k_PB[42];
    assign C_k[19] = k_PB[34];
    assign C_k[20] = k_PB[26];
    assign C_k[21] = k_PB[18];
    assign C_k[22] = k_PB[10];
    assign C_k[23] = k_PB[2];
    
    assign C_k[24] = k_PB[59];
    assign C_k[25] = k_PB[51];
    assign C_k[26] = k_PB[43];
    assign C_k[27] = k_PB[35];
    assign C_k[28] = k_PB[62];
    assign C_k[29] = k_PB[54];
    assign C_k[30] = k_PB[46];
    assign C_k[31] = k_PB[38];
    
    assign C_k[32] = k_PB[30];
    assign C_k[33] = k_PB[22];
    assign C_k[34] = k_PB[14];
    assign C_k[35] = k_PB[6];
    assign C_k[36] = k_PB[61];
    assign C_k[37] = k_PB[53];
    assign C_k[38] = k_PB[45];
    assign C_k[39] = k_PB[37];
    
    assign C_k[40] = k_PB[29];
    assign C_k[41] = k_PB[21];
    assign C_k[42] = k_PB[13];
    assign C_k[43] = k_PB[5];
    assign C_k[44] = k_PB[60];
    assign C_k[45] = k_PB[52];
    assign C_k[46] = k_PB[44];
    assign C_k[47] = k_PB[36];
    
    assign C_k[48] = k_PB[28];
    assign C_k[49] = k_PB[20];
    assign C_k[50] = k_PB[12];
    assign C_k[51] = k_PB[4];
    assign C_k[52] = k_PB[27];
    assign C_k[53] = k_PB[19];
    assign C_k[54] = k_PB[11];
    assign C_k[55] = k_PB[3];

endmodule



module Compression_PBOX_Key(
    input [0:27] L_CK,  // Left-shifted C_K (28 bits)
    input [0:27] R_CK,  // Right-shifted C_K (28 bits)
    output [0:47] C_k   // Cipher Key (48 bits)
);

    // Concatenate L_CK and R_CK to form the 56-bit key CK
    wire [0:55] CK = {L_CK, R_CK};

    // Assign output bits based on the Compression P-box mapping
    assign C_k[0]  = CK[13];
    assign C_k[1]  = CK[16];
    assign C_k[2]  = CK[10];
    assign C_k[3]  = CK[23];
    assign C_k[4]  = CK[0];
    assign C_k[5]  = CK[4];
    assign C_k[6]  = CK[2];
    assign C_k[7]  = CK[27];
    
    assign C_k[8]  = CK[14];
    assign C_k[9]  = CK[5];
    assign C_k[10] = CK[20];
    assign C_k[11] = CK[9];
    assign C_k[12] = CK[22];
    assign C_k[13] = CK[18];
    assign C_k[14] = CK[11];
    assign C_k[15] = CK[3];
    
    assign C_k[16] = CK[25];
    assign C_k[17] = CK[7];
    assign C_k[18] = CK[15];
    assign C_k[19] = CK[6];
    assign C_k[20] = CK[26];
    assign C_k[21] = CK[19];
    assign C_k[22] = CK[12];
    assign C_k[23] = CK[1];
    
    assign C_k[24] = CK[40];
    assign C_k[25] = CK[51];
    assign C_k[26] = CK[30];
    assign C_k[27] = CK[36];
    assign C_k[28] = CK[46];
    assign C_k[29] = CK[54];
    assign C_k[30] = CK[29];
    assign C_k[31] = CK[39];
    
    assign C_k[32] = CK[50];
    assign C_k[33] = CK[44];
    assign C_k[34] = CK[32];
    assign C_k[35] = CK[47];
    assign C_k[36] = CK[43];
    assign C_k[37] = CK[48];
    assign C_k[38] = CK[38];
    assign C_k[39] = CK[55];
    
    assign C_k[40] = CK[33];
    assign C_k[41] = CK[52];
    assign C_k[42] = CK[45];
    assign C_k[43] = CK[41];
    assign C_k[44] = CK[49];
    assign C_k[45] = CK[35];
    assign C_k[46] = CK[28];
    assign C_k[47] = CK[31];

endmodule



















