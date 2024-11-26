package MAC_pipelined;


import FIFO::*;
import SpecialFIFOs::*;

import MAC_pipelined_float ::*;
import MAC_pipelined_int ::*;


interface Ifc_MAC_pipelined;
    method Action get_A(Bit#(16) a);
    method Action get_B(Bit#(16) b);
    method Action get_C(Bit#(32) c);
    method Action get_select(Bit#(1) select);
    method ActionValue#(Bit#(32)) output_MAC();
endinterface

(*synthesize*)
module mkMAC_pipelined(Ifc_MAC_pipelined);

    FIFO#(Bit#(16)) inpA_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(16)) inpB_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32)) inpC_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(1))  inpS_fifo <- mkPipelineFIFO();
    FIFO#(Bit#(32)) out_fifo  <- mkPipelineFIFO();
    
    Reg#(Bit#(32)) int_output <- mkReg(0);
    Reg#(Bit#(1)) sel <- mkReg(0);
    Reg#(Bit#(32)) float_output <- mkReg(0); 
    Reg#(Bool) got_output <- mkReg(False);
    
    Ifc_MAC_pipelined_int  mac_int   <- mkintmul;
    Ifc_MAC_pipelined_float mac_float <- mkPipelined_float;
    
    rule call_MAC;
        Bit#(16) inp_A = inpA_fifo.first();
        Bit#(16) inp_B = inpB_fifo.first();
        Bit#(32) inp_C = inpC_fifo.first();
        Bit#(1)  inp_S = inpS_fifo.first();
        
    	if(inp_S == 1'd0)
    	begin
    		mac_int.get_A(inp_A);
    		mac_int.get_B(inp_B);
    		mac_int.get_C(inp_C);
    	end
    	else
    	begin
    		mac_float.get_input_a(inp_A);
    		mac_float.get_input_b(inp_B);
    		mac_float.get_input_c(inp_C);
    	end
    	sel <= inp_S;
    	inpA_fifo.deq();
    	inpB_fifo.deq();
    	inpC_fifo.deq();
    	inpS_fifo.deq();
    endrule
    
    rule get_output_from_intMAC(sel == 1'd0);
        Bit#(32) temp <- mac_int.get_output();
    	out_fifo.enq(temp);
    endrule
    
    rule get_output_from_floatMAC(sel == 1'd1);
        Bit#(32) temp <- mac_float.get_MAC_result();
	out_fifo.enq(temp);
    endrule

    method Action get_A(Bit#(16) a);
        inpA_fifo.enq(a);
    endmethod

    method Action get_B(Bit#(16) b);
        inpB_fifo.enq(b);
    endmethod
    
    method Action get_C(Bit#(32) c);
        inpC_fifo.enq(c);
    endmethod

    method Action get_select(Bit#(1) select);
        inpS_fifo.enq(select);
    endmethod 

    method ActionValue#(Bit#(32)) output_MAC();
      	Bit#(32) out = out_fifo.first();
	out_fifo.deq();
	return out;
    endmethod 

endmodule

endpackage