module alu_8bit_tb;
  logic [7:0] a;
  logic [7:0] b;
  logic [2:0] op;
  logic [7:0] result;
  logic carry;
  logic overflow;
  logic zero;

  alu_8bit dut (
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .carry(carry),
    .overflow(overflow),
    .zero(zero)
  );

  task automatic check(
    input logic [7:0] a_i,
    input logic [7:0] b_i,
    input logic [2:0] op_i,
    input logic [7:0] exp_result,
    input logic exp_carry,
    input logic exp_overflow,
    input logic exp_zero,
    input string test_name
  );
    begin
      a = a_i;
      b = b_i;
      op = op_i;
      #1;
      if ((result !== exp_result) || (carry !== exp_carry) ||
          (overflow !== exp_overflow) || (zero !== exp_zero)) begin
        $error("%s FAILED: a=%h b=%h op=%b => result=%h carry=%b ovf=%b zero=%b (exp %h %b %b %b)",
               test_name, a, b, op, result, carry, overflow, zero,
               exp_result, exp_carry, exp_overflow, exp_zero);
      end
      else begin
        $display("%s PASSED", test_name);
      end
    end
  endtask

  initial begin
    check(8'h7F, 8'h01, 3'b000, 8'h80, 1'b0, 1'b1, 1'b0, "ADD overflow check");
    check(8'hFF, 8'h01, 3'b000, 8'h00, 1'b1, 1'b0, 1'b1, "ADD carry check");
    check(8'h80, 8'h01, 3'b001, 8'h7F, 1'b1, 1'b1, 1'b0, "SUB overflow check");
    check(8'hAA, 8'h55, 3'b010, 8'h00, 1'b0, 1'b0, 1'b1, "AND");
    check(8'hAA, 8'h55, 3'b011, 8'hFF, 1'b0, 1'b0, 1'b0, "OR");
    check(8'hF0, 8'h0F, 3'b100, 8'hFF, 1'b0, 1'b0, 1'b0, "XOR");
    check(8'hA5, 8'h00, 3'b101, 8'h5A, 1'b0, 1'b0, 1'b0, "NOT A");
    check(8'h81, 8'h00, 3'b110, 8'h02, 1'b0, 1'b0, 1'b0, "SHL");
    check(8'h81, 8'h00, 3'b111, 8'h40, 1'b0, 1'b0, 1'b0, "SHR");
    $display("All 8-bit ALU checks completed.");
    $finish;
  end
endmodule
