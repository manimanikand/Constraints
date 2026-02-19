module alu_4bit_tb;
  logic [3:0] a;
  logic [3:0] b;
  logic [2:0] op;
  logic [3:0] result;
  logic carry;
  logic overflow;
  logic zero;

  alu_4bit dut (
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .carry(carry),
    .overflow(overflow),
    .zero(zero)
  );

  task automatic check(
    input logic [3:0] a_i,
    input logic [3:0] b_i,
    input logic [2:0] op_i,
    input logic [3:0] exp_result,
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
    check(4'h3, 4'h5, 3'b000, 4'h8, 1'b0, 1'b1, 1'b0, "ADD overflow check");
    check(4'hF, 4'h1, 3'b000, 4'h0, 1'b1, 1'b0, 1'b1, "ADD carry check");
    check(4'h7, 4'h2, 3'b001, 4'h5, 1'b1, 1'b0, 1'b0, "SUB basic");
    check(4'hA, 4'h5, 3'b010, 4'h0, 1'b0, 1'b0, 1'b1, "AND");
    check(4'hA, 4'h5, 3'b011, 4'hF, 1'b0, 1'b0, 1'b0, "OR");
    check(4'hA, 4'h5, 3'b100, 4'hF, 1'b0, 1'b0, 1'b0, "XOR");
    check(4'hA, 4'h0, 3'b101, 4'h5, 1'b0, 1'b0, 1'b0, "NOT A");
    check(4'h9, 4'h0, 3'b110, 4'h2, 1'b0, 1'b0, 1'b0, "SHL");
    check(4'h9, 4'h0, 3'b111, 4'h4, 1'b0, 1'b0, 1'b0, "SHR");
    $display("All ALU checks completed.");
    $finish;
  end
endmodule
