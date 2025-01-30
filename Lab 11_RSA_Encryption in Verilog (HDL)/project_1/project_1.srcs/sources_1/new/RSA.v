`timescale 1ns / 1ps

//module RSA(

//    );
//endmodule

module RSA_Key_Generation(
    input wire clk,
    input wire reset,
    output reg [31:0] public_key_e,
    output reg [31:0] public_key_n,
    output reg [31:0] private_key_d
);
    reg [31:0] p, q, n, phi_n, e, d;
    reg [2:0] state;
    initial begin
        p = 7;  // Example prime number p
        q = 11;  // Example prime number q
        e = 13;  // Example e
        state = 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            p <= 7;
            q <= 11;
            n <= 0;
            phi_n <= 0;
            e <= 13;
            d <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin
                    n <= p * q;
                    phi_n <= (p - 1) * (q - 1);
                    state <= 1;
                end
                1: begin
                    d <= modinv(e, phi_n);  // Calculate the modular inverse of e mod phi_n
                    state <= 2;
                end
                2: begin
                    public_key_e <= e;
                    public_key_n <= n;
                    private_key_d <= d;
                    state <= 3;
                end
                default: state <= 3;
            endcase
        end
    end
    
   function [31:0] modinv(input [31:0] a, input [31:0] m);
        integer m0, t, q;
        integer x0, x1;
        begin
            m0 = m;
            t = 0;
            q = 0;
            x0 = 0;
            x1 = 1;

            while (a > 1) begin
                q = a / m;
                t = m;
                m = a % m;
                a = t;
                t = x0;
                x0 = x1 - q * x0;
                x1 = t;
            end

            if (x1 < 0)
                x1 = x1 + m0;

            modinv = x1;
        end
    endfunction
endmodule

    // Function to compute modular inverse
`timescale 1ns / 1ps
module fast_exponentiation #(parameter width = 7) (
    input [width:0] base,
    input [width:0] exp,
    input [width:0] mod,
    output reg [width:0] result
);
    reg [15:0] temp_base;
    reg [15:0] temp_result;
    integer i;

    always @(*) begin
        temp_base = base % mod;
        temp_result = 1;

        for (i = 0; i < 7; i = i + 1) begin
            if (exp[i] == 1) begin
                temp_result = (temp_result * temp_base) % mod;
            end
            temp_base = (temp_base * temp_base) % mod;
        end

        result = temp_result;
    end
endmodule

// Define the RSA_Encryption module, which performs RSA encryption
module RSA_Encryption(
    input [7:0] plaintext,  // 8-bit plaintext to be encrypted
    input [7:0] e,          // 8-bit public exponent in RSA encryption
    input [7:0] n,          // 8-bit modulus used in RSA encryption
    output [7:0] ciphertext // 8-bit encrypted ciphertext output
);

    // Intermediate wire to hold the result from the fast exponentiation module
    wire [7:0] result;

    // Instantiate the fast_exponentiation module to perform modular exponentiation
    // The plaintext, exponent `e`, and modulus `n` are passed as inputs
    // The result is the computed (plaintext^e) % n
    fast_exponentiation exp (
        .base(plaintext), // Base is the plaintext message
        .exp(e),          // Exponent is the public exponent `e`
        .mod(n),          // Modulus is `n`
        .result(result)   // Result of exponentiation is stored in `result`
    );

    // Assign the result of the modular exponentiation to the ciphertext output
    assign ciphertext = result;

endmodule

module RSA_Decryption(
    input [7:0] ciphertext,  // 8-bit ciphertext
    input [7:0] d,           // 8-bit private exponent
    input [7:0] n,           // 8-bit modulus
    output [7:0] plaintext
);
    wire [7:0] result;
    fast_exponentiation exp1 (
        .base(ciphertext),
        .exp(d),
        .mod(n),
        .result(result)
    );
    assign plaintext = result;
endmodule

`timescale 1ns / 1ps
module RSA(
    input wire clk,
    input wire reset,
    input wire [7:0] plaintext,
    output wire [7:0] ciphertext,
    output wire [7:0] decrypted_text
);

    // Wires to connect the modules
    wire [31:0] public_key_e;
    wire [31:0] public_key_n;
    wire [31:0] private_key_d;
    wire [7:0] encrypted_text;
    
    // Instantiate the RSA Key Generation module
    RSA_Key_Generation rsa_key_gen (
        .clk(clk),
        .reset(reset),
        .public_key_e(public_key_e),
        .public_key_n(public_key_n),
        .private_key_d(private_key_d)
    );

    // Instantiate the RSA Encryption module
    RSA_Encryption rsa_encryption (
        .plaintext(plaintext),
        .e(public_key_e[7:0]),       // Only use the lower 8 bits
        .n(public_key_n[7:0]),       // Only use the lower 8 bits
        .ciphertext(encrypted_text)
    );

    // Instantiate the RSA Decryption module
    RSA_Decryption rsa_decryption (
        .ciphertext(encrypted_text),
        .d(private_key_d[7:0]),     // Only use the lower 8 bits
        .n(public_key_n[7:0]),      // Only use the lower 8 bits
        .plaintext(decrypted_text)
    );
    assign ciphertext = encrypted_text;
endmodule



