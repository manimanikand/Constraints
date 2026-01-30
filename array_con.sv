class A1;
    randc int data[5];
    randc int data1[];

    constraint c1 {
        foreach(data[i])
        data[i] inside {[0:15]};
    }

    constraint c2 {
        data1.size() inside {[3:7]};
        foreach(data1[i])
        data1[i] inside {[15:30]};

    }

endclass

module tb;
    A1 a1;

    initial begin
        a1=new();
        repeat(10) begin
            a1.randomize();
            $display("data=%0p ||  data1=%0p",a1.data,a1.data1);
        end
    end
endmodule