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
///////////   task-1
    rand bit [7:0] data_2[4];

    constraint c3 {
        data_2[0] inside {[8'h10:8'hff]};

        foreach(data_2[i]){
        if(data[1]>0)
        data_2[i] inside {[8'h20:8'h2f]};
        }
    }
////////// task-2
    rand int data_3[5];

    constraint c4 {
        
        foreach(data_3[i]){
        data_3[i] inside {[0:50]};
        if(i>0)
        data_3[i] >= data_3[i-1];
        }
    }
endclass

module tb;
    A1 a1;

    initial begin
        a1=new();
        repeat(10) begin
            a1.randomize();
            $display("data=%0p ||  data1=%0p   || data_2=%0p || data_3=%0p ",a1.data,a1.data1,a1.data_2,a1.data_3);
        end
    end
endmodule