package MAC_types;
	
	typedef struct {
		Bit#(1) sign;
		Bit#(8) exp;
		Bit#(7) mantissa;
	} Bf16 deriving (Bits, Eq);


	typedef struct {
	    Bit#(1) sign;
	    Bit#(8) exp;
	    Bit#(23) mantissa;
	} Fp32 deriving (Bits, Eq);

endpackage:MAC_types
