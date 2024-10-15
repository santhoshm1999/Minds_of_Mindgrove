package MAC_unpipelined;

typedef struct{
Bit#(1) sign;
Bit#(8) exp;
Bit#(23) mantissa;
} Float deriving(Bits, Eq);


interface Ifc_MAC_unpipelined;
	method Action get_inp_b(Float inp_B);
	method Action get_inp_c(Float inp_C);
endinterface: Ifc_MAC_unpipelined

(* synthesize *)
module mkUnpipelined (Ifc_MAC_unpipelined);

	Reg#(Float) inp_b <- mkReg(Float{sign:1'd0, exp:8'd0, mantissa: 23'd0});
	Reg#(Float) inp_c <- mkReg(Float{sign:1'd0, exp:8'd0, mantissa: 23'd0});
	Reg#(Float) result <- mkReg(Float{sign:1'd0, exp:8'd0, mantissa: 23'd0});
	Reg#(Float) temp <- mkReg(Float{sign:1'd0, exp:8'd0, mantissa: 23'd0});
	Reg#(Bool) got_b <- mkReg(False);
	Reg#(Bool) got_c <- mkReg(False);

	rule get_res(got_b && got_c);
		Bit#(1) tmp_sign;
		Bit#(8) tmp_exp;
		Bit#(23) tmp_mantissa;

		tmp_sign = inp_b.sign ^ inp_c.sign;
		tmp_exp = inp_b.exp ^ inp_c.exp;
		tmp_mantissa = inp_b.mantissa * inp_c.mantissa;

		result <= Float{sign:tmp_sign, exp:tmp_exp, mantissa:tmp_mantissa};
	endrule

	method Action get_inp_b(Float inp_B);
		inp_b <= inp_B;
		got_b <= True;
	endmethod

	method Action get_inp_c(Float inp_C);
		inp_c <= inp_C;
		got_c <= True;
	endmethod

endmodule: mkUnpipelined

endpackage
