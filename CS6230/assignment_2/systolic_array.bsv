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

method Action inp_b1(Bit#(16) b1);
method Action inp_b2(Bit#(16) b2);
method Action inp_b3(Bit#(16) b3);
method Action inp_b4(Bit#(16) b4);

endinterface

endpackage : systolic_array