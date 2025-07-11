module traffic_light_controller (
    input clk,
    input rst,
    output reg [2:0] lights  // [2] = Red, [1] = Yellow, [0] = Green
);
    reg [1:0] state;
    parameter RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;

    reg [3:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= RED;
            count <= 0;
        end else begin
            count <= count + 1;
            case (state)
                RED: begin
                    lights <= 3'b100;
                    if (count == 4) begin
                        state <= GREEN;
                        count <= 0;
                    end
                end
                GREEN: begin
                    lights <= 3'b001;
                    if (count == 4) begin
                        state <= YELLOW;
                        count <= 0;
                    end
                end
                YELLOW: begin
                    lights <= 3'b010;
                    if (count == 2) begin
                        state <= RED;
                        count <= 0;
                    end
                end
                default: state <= RED;
            endcase
        end
    end
endmodule
