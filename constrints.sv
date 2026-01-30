class CON;

    rand int A;
    rand int B;
    rand logic [7:0] c;

    constraint C1{A>5;A<50;}
    constraint C2{B>10;B<100;}

     constraint c3{
         c inside {8'h10,8'h20,8'h30};
         }

    constraint inside_range {
        c inside {[8'd0:8'd10]};
    }


endclass

module tb;

    CON c1;

    initial begin
        c1=new();
        repeat(10) begin
            c1.randomize();
            $display("value of A=%d and B=%d",c1.A,c1.B);
            $display("value of C=%h",c1.c);
        end
    end

endmodule