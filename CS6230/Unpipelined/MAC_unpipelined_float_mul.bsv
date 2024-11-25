package MAC_unpipelined_float_mul;

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

interface Ifc_MAC_unpipelined_float_mul;
    // method Action mul_start_point(Bool start);
    method Action get_inp_a(Bit#(16) inp_A);
    method Action get_inp_b(Bit#(16) inp_B);
    method Bit#(16) get_result(); // Method to retrieve the result
endinterface: Ifc_MAC_unpipelined_float_mul

(* synthesize *)
module mkUnpipelined_float_mul (Ifc_MAC_unpipelined_float_mul);

    Reg#(Bf16) a <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bf16) b <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bf16) result_mul <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bit#(1)) tmp_sign <- mkReg(1'd0);
    Reg#(Bit#(8)) tmp_exp <- mkReg(8'd0);
    Reg#(Bit#(16)) tmp_a <- mkReg(16'd0);
    Reg#(Bit#(8)) tmp_a_a <- mkReg(8'd0);
    Reg#(Bit#(8)) tmp_b <- mkReg(8'd0);
    Reg#(Bit#(4)) mul_count <- mkReg(4'd0);
    Reg#(Bool) got_a <- mkReg(False);
    Reg#(Bool) got_b <- mkReg(False);
    Reg#(Bool) sign_done <- mkReg(False);
    Reg#(Bool) exp_done <- mkReg(False);
    Reg#(Bool) mantissa_done <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bool) result_concatenated <- mkReg(False);
    Reg#(Bool) pack_done <- mkReg(False);
    Reg#(Bool) mul_start <- mkReg(False);
    Reg#(Bool) handle_zero <- mkReg(False);
    Reg#(Bit#(1)) get_r <- mkReg(0);
    Reg#(Bit#(16)) tmp_fraction <- mkReg(0);
    Reg#(Bit#(15)) exp_mantissa <- mkReg(0);
    Reg#(Bit#(8)) exp_res <- mkReg(0);
    Reg#(Bit#(16)) end_result <- mkReg(0);

    function Bit#(8) add_exponents(Bit#(8) exp_a, Bit#(8) exp_b);
	Bit#(8) outp_inter = 8'b0;
	Bit#(8) outp = 8'b0;
	Bit#(8) bias = 8'd127;
	Bit#(1) carry = 1'b0;
    Bit#(8) complimented_bias = 8'b10000001;
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
		outp[i] = outp_inter[i] ^ complimented_bias[i] ^ carry;
		carry = (outp_inter[i] & complimented_bias[i]) | (outp_inter[i] ^ complimented_bias[i]) & carry;
	end

	return outp;
    endfunction:add_exponents

    // Method to add two 8-bit numbers without using `+`
    function Bit#(16) addition(Bit#(16) val_a, Bit#(16) val_b);
        Bit#(16) sum = 16'd0;
        Bit#(1) carry = 1'd0;

        sum[0] = val_a[0] ^ val_b[0];
        carry = val_a[0] & val_b[0];
        
        // Loop to perform binary addition
        for (Integer i = 1; i < 16; i = i + 1) begin
            // Calculate the sum bit and carry
            sum[i] = val_a[i] ^ val_b[i] ^ carry; // Sum of the bits with carry
            carry = (val_a[i] & val_b[i]) | (carry & (val_a[i] ^ val_b[i])); // Calculate carry
            // $display(" carry %b  sum %b", carry, sum);
        end

        return sum; // Return the final sum
    endfunction:addition

    function Bit#(15) rounding_mantissa(Bit#(16) val, Bit#(8) exp);
	    Bit#(7) rounded_mantissa = 7'd0;
	    Bit#(1) round_bit = 1'd0;
	    Bit#(16) temp = 16'd0;

	    if (val[15] == 1'd1) begin
		    exp = addition(zeroExtend(exp), 16'd1)[7:0];
		    round_bit = val[7];
		    if (round_bit == 1'd0) begin
			    rounded_mantissa = val[14:8];
		    end
		    else begin
			    if (val[6:0] == 7'd0 && val[8] == 1'd0) begin
				    rounded_mantissa = val[14:8];
			    end
			    else begin
				    temp = addition(zeroExtend(val[15:8]), 16'b1);
				    if(temp[8] == 1'd1) begin
					    exp = addition(zeroExtend(exp), 16'b1)[7:0];
					    rounded_mantissa = temp[7:1];
				    end
				    else begin
					    rounded_mantissa = temp[6:0];
				    end
			    end
		    end

	    end
	    else begin
		    round_bit = val[6];
		    if (round_bit == 1'd0) begin
			    rounded_mantissa = val[13:7];
		    end
		    else begin
			    if (val[5:0] == 6'd0 && val[7] == 1'd0) begin
				    rounded_mantissa = val[13:7];
			    end
			    else begin
				    temp = addition(zeroExtend(val[15:7]), 16'd1);
				    if (temp[8] == 1) begin
					    exp = addition(zeroExtend(exp), 16'd1)[7:0];
					    rounded_mantissa = temp[7:1];
				    end
				    else begin
					    rounded_mantissa = temp[6:0];
				    end
			    end
		    end
	    end
	    return {exp, rounded_mantissa};

    endfunction:rounding_mantissa


    rule rl_get_sign(got_a && got_b && !mul_done && !sign_done);
        if ((a.exp == 8'd0 && a.mantissa == 7'd0) || (b.exp == 8'd0 && b.mantissa == 7'd0)) begin
            handle_zero <= True;
        end
        else begin
            tmp_sign <= a.sign ^ b.sign ;
            tmp_a_a <= {1'b1, a.mantissa};
            tmp_b <= {1'b1, b.mantissa};
            sign_done <= True;
        end
    endrule

    rule rl_add_exp(got_a && got_b && !mul_done && sign_done && !exp_done && mul_count == 4'd0 && !handle_zero);
        tmp_exp <= add_exponents(a.exp, b.exp);
        $display($stime,"  a.exp: %b   b.exp: %b", a.exp, b.exp);
        $display($stime,"  a.mantissa: %b   b.mantissa: %b ", a.mantissa, b.mantissa);
        tmp_a <= zeroExtend(tmp_a_a);
        mul_count <= 8;
        exp_done <= True;
    endrule

    rule rl_mul_mantissa(got_a && got_b && !mul_done && sign_done && exp_done && mul_count != 0 && !handle_zero);

        $display($stime," tmp_fraction %b ", tmp_fraction);
        $display($stime," tmp_a         %b ", tmp_a);
        $display("********************************");

        if (tmp_b[0] == 1) begin
            tmp_fraction <= addition(zeroExtend(tmp_a), tmp_fraction);
        end
        tmp_a <= tmp_a << 1;
        tmp_b <= tmp_b >> 1;
        mul_count <= mul_count - 1; 
    endrule


    rule rl_round_mantissa(got_a && got_b && !mul_done && sign_done && exp_done && mul_count == 0 && !mantissa_done && !handle_zero);
        $display($stime," tmp_fraction %b ", tmp_fraction);
        $display($stime," tmp_exp       %b ", tmp_exp);
        exp_mantissa <= rounding_mantissa(tmp_fraction, tmp_exp);
        mantissa_done <= True;
    endrule

    rule rl_handling_zero ( handle_zero );
        result_mul <= Bf16{sign: 1'd0, exp: 8'd0, mantissa: 7'd0};
        handle_zero <= False;
        result_concatenated <= True;
    endrule

    // Rule to compute the result when both inputs are available
    rule rl_get_mul_res(got_a && got_b && !mul_done && mantissa_done && !handle_zero);
        
        // Intermediate variables
        $display($stime," MUL: sign %b exp: %b mantissa %b",tmp_sign, exp_mantissa[14:7], exp_mantissa[6:0]);
        result_mul <= Bf16{sign: tmp_sign, exp: exp_mantissa[14:7], mantissa: exp_mantissa[6:0]};
        mul_done <= True;
        result_concatenated <= True;
    endrule

    rule rl_pack_res(result_concatenated);
        end_result <= pack(result_mul);
        pack_done <= True;
    endrule

    rule reset_signals(pack_done);
        got_a <= False;
        got_b <= False;
        sign_done <= False;
        exp_done <= False;
        mantissa_done <= False;
        result_concatenated <= False;
        mul_count <= 4'd8;
    endrule


    // Method to set input A
    method Action get_inp_a(Bit#(16) inp_A) if(!got_a);
        a <= Bf16{sign:inp_A[15], exp:inp_A[14:7], mantissa:inp_A[6:0]};
        got_a <= True;
	pack_done <= False;
	result_concatenated <= False;
    endmethod

    // Method to set input B
    method Action get_inp_b(Bit#(16) inp_B) if(!got_b);
        b <= Bf16{sign:inp_B[15], exp:inp_B[14:7], mantissa:inp_B[6:0]};
        got_b <= True;
	mul_start <= False;
    endmethod

    // Method to get the result
    method Bit#(16) get_result() if(pack_done);
        return end_result;
    endmethod

endmodule: mkUnpipelined_float_mul

endpackage: MAC_unpipelined_float_mul