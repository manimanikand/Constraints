module alu_8bit (
  input  logic [7:0] a,
  input  logic [7:0] b,
  input  logic [2:0] op,
  output logic [7:0] result,
  output logic       carry,
  output logic       overflow,
  output logic       zero
);
  logic [8:0] sum_ext;
  logic [8:0] sub_ext;

  always_comb begin
    result   = 8'h00;
    carry    = 1'b0;
    overflow = 1'b0;

    sum_ext = {1'b0, a} + {1'b0, b};
    sub_ext = {1'b0, a} - {1'b0, b};

    unique case (op)
      3'b000: begin // ADD
        result   = sum_ext[7:0];
        carry    = sum_ext[8];
        overflow = (~(a[7] ^ b[7])) & (a[7] ^ result[7]);
      end
      3'b001: begin // SUB
        result   = sub_ext[7:0];
        carry    = ~sub_ext[8]; // 1 => no borrow
        overflow = (a[7] ^ b[7]) & (a[7] ^ result[7]);
      end
      3'b010: result = a & b;             // AND
      3'b011: result = a | b;             // OR
      3'b100: result = a ^ b;             // XOR
      3'b101: result = ~a;                // NOT A
      3'b110: result = a << 1;            // logical shift left
      3'b111: result = a >> 1;            // logical shift right
      default: result = 8'h00;
    endcase

    zero = (result == 8'h00);
  end
endmodule
