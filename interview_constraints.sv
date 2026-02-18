class interview_constraints;
  rand bit [1:0]      pkt_type;
  rand int unsigned   length;
  rand bit [31:0]     addr;
  rand byte           payload[];

  // Limit legal packet types for this example.
  constraint c_pkt_type {
    pkt_type inside {[2'b00:2'b10]};
  }

  // Interview-style conditional constraint.
  constraint c_length_by_type {
    if (pkt_type == 2'b00)
      length inside {[1:16]};
    else if (pkt_type == 2'b01)
      length inside {[32:64]};
    else
      length inside {[65:128]};
  }

  // Address must be 4-byte aligned and in a valid window.
  constraint c_addr_window {
    addr inside {[32'h0000_1000:32'h0000_1FFF]};
    addr[1:0] == 2'b00;
  }

  // Keep payload small in the demo while still linked to length.
  constraint c_payload_size {
    payload.size() == ((length < 8) ? length : 8);
  }

  constraint c_payload_values {
    foreach (payload[i]) payload[i] inside {[8'h10:8'hEF]};
  }

  // Avoid consecutive duplicate bytes.
  constraint c_payload_no_adjacent_repeat {
    foreach (payload[i]) if (i > 0) payload[i] != payload[i-1];
  }

  function void print();
    $display("pkt_type=%0d length=%0d addr=0x%08h payload=%0p", pkt_type, length, addr, payload);
  endfunction
endclass
