/* neenga oru packet class imagine pannunga: rand bit [1:0] pkt_type; rand int length;. 
Condition: pkt_type==2’b00 na length 1..10, illa na 20..30. 
Idhuku constraint‑a un style‑la try pannuveengala?
*/

    // class range;
    //     rand bit [1:0] pkt_type;
    //     rand int length;

    //     constraint c1{
    //         if(pkt_type==2'b00)
    //             length inside {[1:10]};
    //         else 
    //             length inside {[20:30]};
    //     }
    // endclass



    // class range;
    //     rand bit [1:0] pkt_type;
    //     rand int length;

    //     constraint c1{
    //         (pkt_type==2'b00) -> length inside {[1:10]}; 
    //         (pkt_type != 2'b00) -> length inside {[20:30]};      
    //     }
    // endclass

    class range;
        rand bit [1:0] mode;
        rand int size;
        constraint c1 {
            (mode == 2'b01) -> size inside {[0:63]};
            (mode != 2'b01) -> size inside {[64:127]};
        }
        
    endclass