package systolic_array


import FIFO::*;
import SpecialFIFOs::*;

import MAC_pipelined :: *;


interface Ifc_systolic_array;
method Action inp_a1(Bit#(16) a1);
method Action inp_a2(Bit#(16) a2);
method Action inp_a3(Bit#(16) a3);
method Action inp_a4(Bit#(16) a4);

method Action inp_b1(Bit#(16) b1);
method Action inp_b2(Bit#(16) b2);
method Action inp_b3(Bit#(16) b3);
method Action inp_b4(Bit#(16) b4);

method Action inp_c1(Bit#(32) c1);
method Action inp_c2(Bit#(32) c2);
method Action inp_c3(Bit#(32) c3);
method Action inp_c4(Bit#(32) c4);

method Action inp_s1(Bit#(32) s1);
method Action inp_s2(Bit#(32) s2);
method Action inp_s3(Bit#(32) s3);
method Action inp_s4(Bit#(32) s4);

method ActionValue#(Bit#(32)) out_r1();
method ActionValue#(Bit#(32)) out_r2();
method ActionValue#(Bit#(32)) out_r3();
method ActionValue#(Bit#(32)) out_r4();

endinterface: Ifc_systolic_array

(*synthesize*)
module mkSystolic(Ifc_systolic_array);
    FIFO#(16) fifo_a1 <-mkPipelineFIFO();
    FIFO#(16) fifo_a2 <-mkPipelineFIFO();
    FIFO#(16) fifo_a3 <-mkPipelineFIFO();
    FIFO#(16) fifo_a4 <-mkPipelineFIFO();

    FIFO#(16) fifo_b1 <-mkPipelineFIFO();
    FIFO#(16) fifo_b2 <-mkPipelineFIFO();
    FIFO#(16) fifo_b3 <-mkPipelineFIFO();
    FIFO#(16) fifo_b4 <-mkPipelineFIFO();

    FIFO#(32) fifo_c1 <-mkPipelineFIFO();
    FIFO#(32) fifo_c2 <-mkPipelineFIFO();
    FIFO#(32) fifo_c3 <-mkPipelineFIFO();
    FIFO#(32) fifo_c4 <-mkPipelineFIFO();

    FIFO#(32) fifo_s1 <-mkPipelineFIFO();
    FIFO#(32) fifo_s2 <-mkPipelineFIFO();
    FIFO#(32) fifo_s3 <-mkPipelineFIFO();
    FIFO#(32) fifo_s4 <-mkPipelineFIFO();



method Action inp_a1(Bit#(16) a1);
    fifo_a1.enq(a1);
endmethod
method Action inp_a2(Bit#(16) a2);
    fifo_a2.enq(a2);
endmethod
method Action inp_a3(Bit#(16) a3);
    fifo_a3.enq(a3);
endmethod
method Action inp_a4(Bit#(16) a4);
    fifo_a4.enq(a4);
endmethod
method Action inp_b1(Bit#(16) b1);
    fifo_b1.enq(b1);
endmethod
method Action inp_b2(Bit#(16) b2);
    fifo_b2.enq(b2);
endmethod
method Action inp_b3(Bit#(16) b3);
    fifo_b3.enq(b3);
endmethod
method Action inp_b4(Bit#(16) b4);
    fifo_b4.enq(b4);
endmethod
method Action inp_c1(Bit#(32) c1);
    fifo_c1.enq(c1);
endmethod
method Action inp_c2(Bit#(32) c2);
    fifo_c2.enq(c2);
endmethod
method Action inp_c3(Bit#(32) c3);
    fifo_c3.enq(c3);
endmethod
method Action inp_c4(Bit#(32) c4);
    fifo_c4.enq(c4);
endmethod
method Action inp_s1(Bit#(32) s1);
    fifo_s1.enq(s1);
endmethod
method Action inp_s2(Bit#(32) s2);
    fifo_s2.enq(s2);
endmethod
method Action inp_s3(Bit#(32) s3);
    fifo_s3.enq(s3);
endmethod
method Action inp_s4(Bit#(32) s4);
    fifo_s4.enq(s4);
endmethod

endmodule:mkSystolic

endpackage : systolic_array