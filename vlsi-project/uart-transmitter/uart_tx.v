module uart_tx (
    input clk,
    input rst,
    input [7:0] data_in,
    input start,
    output reg tx,
    output reg busy
);
    reg [3:0] bit_cnt;
    reg [9:0] shift_reg;
    reg [3:0] state;

    parameter IDLE = 0, LOAD = 1, TRANS = 2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;
            busy <= 1'b0;
            bit_cnt <= 0;
            shift_reg <= 10'b1111111111;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    busy <= 1'b0;
                    if (start) begin
                        state <= LOAD;
                    end
                end
                LOAD: begin
                    shift_reg <= {1'b1, data_in, 1'b0}; // stop, data, start
                    bit_cnt <= 0;
                    busy <= 1'b1;
                    state <= TRANS;
                end
                TRANS: begin
                    tx <= shift_reg[0];
                    shift_reg <= {1'b1, shift_reg[9:1]};
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 9) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
