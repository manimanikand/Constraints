/* Class: rand bit enable; rand int data;

Rule: enable==1 -> data inside [0:100];

Add a second constraint using solve enable before data;
*/

class A;

    rand bit enable;
    rand int data;

    constraint c1 {
        (enable==1) -> data inside {[0:100]};
       // solve enable before data;
    }
endclass

module tb;
    A a;
    initial begin
        a=new();
        repeat(10) begin
            a.randomize();
            $display("enable=%d, data=%d",a.enable,a.data);
        end
    end
endmodule

