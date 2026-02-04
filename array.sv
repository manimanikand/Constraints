/*
Class: rand int arr[];

Constraint:

arr.size() between 6 and 10

Even index i → arr[i] odd

Odd index i → arr[i] even
Hint: use foreach(arr[i]) and i % 2
*/

class A;
  rand int arr[];

  constraint c1 {
    arr.size() inside {[6:10]};

    foreach(arr[i])  arr[i] inside {[0:30]};

    foreach (arr[i]) {
      if (i % 2 == 0)
        arr[i] % 2 == 1; // even index → odd value
      else
        arr[i] % 2 == 0; // odd index → even value
    }
  }
endclass

module tb;

    A a;

    initial begin
        a=new();
        repeat(12) begin
            a.randomize();
            $display("value of arry=%0p",a.arr);
        end
    end

endmodule
