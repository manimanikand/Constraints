module interview_constraints_tb;
  interview_constraints tr;

  initial begin
    tr = new();

    repeat (12) begin
      assert(tr.randomize())
        else $fatal(1, "Randomization failed");
      tr.print();
    end

    $finish;
  end
endmodule
