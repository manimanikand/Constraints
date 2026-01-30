class A1;
    rand bit [3:0] data;
    rand bit [3:0] data1;
    
    constraint ca { data dist {0:=6, 1:=2, 2:=2, 3:=2} ;}
    constraint c1 { data1 dist {[0:3]:/4, 4:/4} ;}    
endclass

module tb;
    A1 a1;
     initial begin
        a1=new();
        repeat(12) begin
            a1.randomize();
            $display("data=%0d",a1.data);
            $display("data1=%0d",a1.data1);
        end
     end
endmodule
