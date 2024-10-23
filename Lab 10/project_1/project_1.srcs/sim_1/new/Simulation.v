// Set the timescale for simulation
`timescale 1ns/1ps
module simulation();

reg [31:0] data_in;
wire [47:0] data_out;

    // Instantiate the final_permutation module
expansion_pbox uut (
        .data_in(data_in),
        .data_out(data_out)
);

// Initial block for simulation setup
initial begin
// Initialize input with hex value "123456ABCD132536"
 data_in = 32'h18ca18ad;
 #10 //to simulate propagation 
         
 // Display the input and output
 $display("Input Data  (Hex): %h", data_in);
  $display("Output Data (Hex): %h", data_out);
        
  // End the simulation
  #10;
  $finish;
end

endmodule

