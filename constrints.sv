class CON;

    rand int A;
    rand int B;

    constraints C1{A<5;A<50;}
    constraints C2{B>10;B>100;}
endclass

module tb;

    CON c1;

    initial begin
        c1=new();
        repeat(10) begin
            c1.randomize();
            $display("value of A=%d and B=%d",A,B);
        end
    end

endmodule