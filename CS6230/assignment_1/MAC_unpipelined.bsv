package MAC_unpipelined;

typedef struct{
Bit#(1)sign;
Bit#(8)exp;
Bit#(23) mantissa;
} Float;


interface Ifc_MAC_unpipelined;
method Action get_b(Float inp_B);
method Action get_c(Float inp_C);
endinterface: Ifc_MAC_unpipelined

(* synthesize *)
module mkUnpipelined (Ifc_MAC_unpipelined);

// Reg#(Bit#(32)) inp_b <- mkReg(0);
// Reg#(Bit#(32)) inp_c <- mkReg(0);
Reg#(Bool) got_b <- mkReg(False);
Reg#(Bool) got_c <- mkReg(False); 
Float result_inp = 0;
Reg#(Bit#(32)) result <- mkReg(0);
Float inp_b = 0;
Float inp_c = 0;

rule fp_prod(got_b && got_c);
	result_inp <= Bit(inp_b * inp_c);
endrule

method Action get_b(Float inp_B);
	inp_b <= Bit(inp_B);
	got_b <= True;
endmethod

method Action get_c(Float inp_C);
	inp_c <= Bit(inp_C);
	got_b <= True;
endmethod


endmodule: mkUnpipelined

endpackage
