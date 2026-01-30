class conditional;

    rand bit [1:0] opcode;
    rand bit [0:7] addr;

    constraint c1{
        if(opcode == 2'b00)
           addr inside {[8'h10:8'h1f]};
        else 
           addr inside {[8'h00:8'h10]};
    }
endclass


module tb;
    conditional c1;

    initial begin
        c1=new();
        repeat(10) begin
            c1.randomize() with {opcode inside {[0:1]};};
            $display("opcode=%0h,addr=%0h", c1.opcode,c1.addr);
        end

    end

endmodule