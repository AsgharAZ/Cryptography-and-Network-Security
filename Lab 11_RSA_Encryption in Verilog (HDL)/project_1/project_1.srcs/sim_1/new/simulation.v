
module RSA_Test();
    reg clk;
    reg reset;
    reg [7:0] plaintext;
    wire [7:0] ciphertext;
    wire [7:0] decrypted_text;
    
    RSA rsa_top (
        .clk(clk),
        .reset(reset),
        .plaintext(plaintext),
        .ciphertext(ciphertext),
        .decrypted_text(decrypted_text)
    );
    
    initial begin
        clk = 0;
        reset = 0;
        plaintext = 8'd26;          
        reset = 1;
        #10 reset = 0;
        #100; //waiting for key generation
        
        // Display
        $display("Public Key (e, n): (%d, %d)", rsa_top.public_key_e, rsa_top.public_key_n);
        $display("Private Key (d): %d", rsa_top.private_key_d);
        
        // Wait for encryption and decryption
        #100;
        
        // Display the results
        $display("Plaintext: %d", plaintext);
        $display("Ciphertext: %d", ciphertext);
        $display("Decrypted Text: %d", decrypted_text);
        
        // End simulation
        #10 $finish;
    end
    
    // Clock generation
    always #5 clk = ~clk;

endmodule
