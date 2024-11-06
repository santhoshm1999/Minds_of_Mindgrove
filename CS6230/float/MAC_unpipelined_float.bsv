package MAC_unpipelined_float;

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

interface Ifc_MAC_unpipelined_float;
    method Action get_inp_a(Bit#(16) inp_A);
    method Action get_inp_b(Bit#(16) inp_B);
    method Bf16 get_result(); // Method to retrieve the result
endinterface: Ifc_MAC_unpipelined_float

(* synthesize *)
module mkUnpipelined (Ifc_MAC_unpipelined_float);

    Reg#(Bf16) a <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bf16) b <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bf16) result_mul <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Fp32) result_add <- mkReg(Fp32{sign:1'd0, exp:8'd0, mantissa: 23'd0});
    Reg#(Bit#(1)) tmp_sign <- mkReg(1'd0);
    Reg#(Bit#(8)) tmp_exp <- mkReg(8'd0);
    Reg#(Bit#(16)) tmp_mantissa <- mkReg(16'd0);
    Reg#(Bit#(8)) tmp_a <- mkReg(8'd0);
    Reg#(Bit#(8)) tmp_b <- mkReg(8'd0);
    Reg#(Bit#(4)) mul_count <- mkReg(4'd0);
    Reg#(Bool) got_a <- mkReg(False);
    Reg#(Bool) got_b <- mkReg(False);
    Reg#(Bool) sign_done <- mkReg(False);
    Reg#(Bool) exp_done <- mkReg(False);
    Reg#(Bool) mantissa_done <- mkReg(False);
    Reg#(Bool) adj_exp_done <- mkReg(False);
    Reg#(Bool) round_done <- mkReg(False);
    Reg#(Bool) helper <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) result_concatenated <- mkReg(False);
    Reg#(Bit#(1)) get_r <- mkReg(0);
    Reg#(Bit#(7)) mantissa_res <- mkReg(7'd0);
    Reg#(Bit#(24)) tmp_res <- mkReg(24'd0);
    Reg#(Bit#(8)) exp_res <- mkReg(8'd0);

    function Bit#(8) add_exponents(Bit#(8) exp_a, Bit#(8) exp_b);
	Bit#(8) outp_inter = 8'b0;
	Bit#(8) outp = 8'b0;
	Bit#(8) bias = 8'd127;
	Bit#(1) carry = 1'b0;
	outp_inter[0] = exp_a[0] ^ exp_b[0];
	carry = exp_a[0] & exp_b[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp_inter[i] = exp_a[i] ^ exp_b[i] ^ carry;
		carry = (exp_a[i] & exp_b[i]) | (exp_a[i] ^ exp_b[i]) & carry;
	end
	
	carry = 1'b0;
	outp[0] = outp_inter[0] ^ bias[0];
	carry = outp_inter[0] & bias[0];
	for(Integer i = 1; i < 8; i = i + 1)
	begin
		outp[i] = outp_inter[i] ^ bias[i] ^ carry;
		carry = (outp_inter[i] & bias[i]) | (outp_inter[i] ^ bias[i]) & carry;
	end

	return outp;
    endfunction:add_exponents

    // Method to add two 8-bit numbers without using `+`
    function Bit#(16) addition(Bit#(16) val_a, Bit#(16) val_b);
        Bit#(16) sum = 16'd0;
        Bit#(1) carry = 1'd0;
        
        // Loop to perform binary addition
        for (Integer i = 0; i < 14; i = i + 1) begin
            // Calculate the sum bit and carry
            Bit#(1) bit_a = val_a[i]; // Get the ith bit of a
            Bit#(1) bit_b = val_b[i]; // Get the ith bit of b
            sum[i] = bit_a ^ bit_b ^ carry; // Sum of the bits with carry
            carry = (bit_a & bit_b) | (carry & (bit_a ^ bit_b)); // Calculate carry
        end

        return sum; // Return the final sum
    endfunction:addition

    // function Fp32 bf16_to_fp32(Bf16 inp);
    //     Bit#(1) tmp_s = inp.sign;
    //     Bit#(8) tmp_e = inp.exp;
    //     Bit#(23) tmp_m = zeroExtend(inp.mantissa) << 16;

    //     return Fp32{sign:tmp_s, exp:tmp_e, mantissa:tmp_m};
    // endfunction:bf16_to_fp32

    function Bit#(7) rounding_mul_mantissa(Bit#(15) val1);
        Bit#(7) rounded_mantissa = 7'd0;
        if (val1[8] == 1'd0) begin
            rounded_mantissa = val1[14:8];
        end
        else begin
            // TODO: Check the condition and return below
            if (val1[9] != 1'd0 && val1[7:0] == 8'd0) begin
                rounded_mantissa = val1[14:8];
            end
            else begin
                Bit#(16) temp = addition(zeroExtend(val1[14:8]), 16'd1);
                rounded_mantissa = temp[6:0];
            end
        end
        return rounded_mantissa;
    endfunction:rounding_mul_mantissa

    function Bit#(24) adjust_exponent(Bit#(8) exp, Bit#(16) mantissa);
        Bit#(16) fraction_mul = 16'd0;
        Bit#(16) adjusted_fraction = 16'd0;
        Bit#(8) exp_res_adj = 8'd0;
        // Bit#(16) a_man = a.mantissa;
        // Bit#(7) b_man = b.mantissa;

        if (mantissa[15] == 1'd1) begin
            Bit#(16) temp = addition(zeroExtend(exp_res_adj), 16'd1);
            exp_res_adj = temp[7:0];
            adjusted_fraction = mantissa;
        end
        else begin
            // while((mantissa[15] == 1'd0) && (mantissa[14] != 1'd1)) begin
                mantissa = mantissa << 1'd1;
                mantissa = mantissa & 16'hff;
                exp_res_adj = exp_res_adj - 1;
            // end
            adjusted_fraction = mantissa;
        end
        // mantissa_res = rounding_mul_mantissa(adjusted_fraction);
        return {exp_res_adj, adjusted_fraction};
        
    endfunction:adjust_exponent

    rule rl_get_sign(got_a && got_b && !mul_done && !sign_done);
        tmp_sign <= a.sign ^ b.sign ;
        sign_done <= True;
    endrule

    rule rl_add_exp(got_a && got_b && !mul_done && sign_done && !exp_done && mul_count == 4'd0);
        tmp_exp <= add_exponents(a.exp, b.exp);
        tmp_a <= {1,a.mantissa};
        tmp_b <= {1,b.mantissa};
        exp_done <= True;
        mul_count <= 8;
    endrule

    rule rl_mul_mantissa(got_a && got_b && !mul_done && sign_done && exp_done && mul_count != 0);
        if (tmp_b[0] == 1) begin
            tmp_mantissa <= addition(zeroExtend(tmp_a), tmp_mantissa);
        end
        tmp_a <= tmp_a << 1;
        tmp_b <= tmp_b >> 1;
        mul_count <= mul_count - 1; 
    endrule

    rule rl_adjust_exp(got_a && got_b && !mul_done && sign_done && exp_done && mul_count == 0 && !mantissa_done && !adj_exp_done);
        tmp_res <= adjust_exponent(tmp_exp, tmp_mantissa);
        mantissa_done <= True;
        adj_exp_done <= True;
    endrule

    rule rl_adjust_exp_helper(got_a && got_b && !mul_done && sign_done && exp_done && mul_count == 0 && !mantissa_done && adj_exp_done && ((tmp_res[15] == 1) || (tmp_res[15:14] != 2'b01)));
        tmp_mantissa <= tmp_res[15:0];
        tmp_exp <= tmp_res[23:16];
        adj_exp_done <= False;
        helper <= True;
    endrule

    rule rl_round_mantissa(got_a && got_b && !mul_done && sign_done && exp_done && mul_count == 0 && mantissa_done && adj_exp_done && helper && !round_done);
        mantissa_res <= rounding_mul_mantissa(tmp_res[14:0]);
        exp_res <= tmp_res[23:16];
        round_done <= True;
    endrule

    // Rule to compute the result when both inputs are available
    rule get_mul_res(got_a && got_b && !mul_done && round_done);
        
        // Intermediate variables
        result_mul <= Bf16{sign: tmp_sign, exp: exp_res, mantissa: mantissa_res};
        result_concatenated <= True;
        mul_done <= True;
        sign_done <= False;
        exp_done <= False;
        mantissa_done <= True;
    endrule

    rule get_add_res(mul_done); 
        // result_add <= 32'd0;
        mul_done <= False;
    endrule

    // Method to set input A
    method Action get_inp_a(Bit#(16) inp_A);
        a <= Bf16{sign:inp_A[15], exp:inp_A[14:7], mantissa:inp_A[6:0]};
        got_a <= True;
    endmethod

    // Method to set input B
    method Action get_inp_b(Bit#(16) inp_B);
        b <= Bf16{sign:inp_B[15], exp:inp_B[14:7], mantissa:inp_B[6:0]};
        got_b <= True;
    endmethod

    // Method to get the result
    // method Fp32 get_result();
    method Bf16 get_result() if(result_concatenated == True && mul_done == True);
        return result_mul;
    endmethod

endmodule: mkUnpipelined

endpackage
