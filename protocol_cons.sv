constraint c_basic {
  write == 1;
  if (!transfer) begin
    psel    == 2'b00;
    penable == 1'b0;
  end
  else if (transfer && !access) begin
    psel    != 2'b00; // setup
    penable == 1'b0;
  end
  else begin
    psel    != 2'b00; // access
    penable == 1'b1;
  end
}
