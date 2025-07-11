module traffic_light_controller_tb;
    reg clk, rst;
    wire [2:0] lights;

    traffic_light_controller uut (
        .clk(clk),
        .rst(rst),
        .lights(lights)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; #10;
        rst = 0;
        #200;
        $stop;
    end
endmodule
