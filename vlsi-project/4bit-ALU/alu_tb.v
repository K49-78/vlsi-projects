module alu_tb;
    reg [3:0] A, B;
    reg [1:0] sel;
    wire [3:0] result;

    alu uut (.A(A), .B(B), .sel(sel), .result(result));

    initial begin
        A = 4'b0101; B = 4'b0011; sel = 2'b00; #10; // ADD
        sel = 2'b01; #10; // SUB
        sel = 2'b10; #10; // AND
        sel = 2'b11; #10; // OR
        $stop;
    end
endmodule
