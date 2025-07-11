module uart_tx_tb;
    reg clk, rst, start;
    reg [7:0] data_in;
    wire tx, busy;

    uart_tx uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .start(start),
        .tx(tx),
        .busy(busy)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; start = 0; data_in = 8'h00;
        #10 rst = 0;
        #20 data_in = 8'hA5; start = 1;
        #10 start = 0;
        #200;
        $stop;
    end
endmodule
