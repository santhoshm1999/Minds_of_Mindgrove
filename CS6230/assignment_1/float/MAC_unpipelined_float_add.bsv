package MAC_unpipelined_float_add;

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

interface Ifc_MAC_unpipelined_float_add;
	// method Action add_start(Bool start);
	method Action get_inp_s(Bit#(32) inp_S);
	method Action get_inp_c(Bit#(32) inp_C);
	method Bit#(32) get_result(); // Method to retrieve the result
endinterface: Ifc_MAC_unpipelined_float_add

(* synthesize *)
module mkUnpipelined_float_add (Ifc_MAC_unpipelined_float_add);

    Reg#(Fp32) s <- mkReg(Fp32{sign:1'd0, exp:8'd0, mantissa: 23'd0});
    Reg#(Fp32) c <- mkReg(Fp32{sign:1'd0, exp:8'd0, mantissa: 23'd0});
    Reg#(Bit#(32)) end_result <- mkReg(0);
    Reg#(Bit#(1)) tmp_sign <- mkReg(1'd0);
    Reg#(Bit#(8)) tmp_exp <- mkReg(8'd0);
    Reg#(Bool) addition_start <- mkReg(False);
    Reg#(Bool) got_s <- mkReg(False);
    Reg#(Bool) got_c <- mkReg(False);
    Reg#(Bool) handle_zero <- mkReg(False);
    Reg#(Bool) input_zero <- mkReg(False);
    Reg#(Bit#(1)) input_no <- mkReg(1'b0);
    Reg#(Bool) swap_done <- mkReg(False);
    Reg#(Bool) sign_done <- mkReg(False);
    Reg#(Bool) cmp_exp_done <- mkReg(False);
    Reg#(Bool) mantissa_done <- mkReg(False);
    Reg#(Bool) adj_exp_done <- mkReg(False);
    Reg#(Bool) align_man_done <- mkReg(False);
    Reg#(Bool) calc_fraction_done <- mkReg(False);
    Reg#(Bool) add_done <- mkReg(False);
    Reg#(Bool) result_concatenated <- mkReg(False);
    Reg#(Bool) pack_done <- mkReg(False);
    Reg#(Bit#(8)) exp_diff <- mkReg(8'd0);
    Reg#(Bit#(1)) get_r <- mkReg(0);
    Reg#(Bit#(23)) mantissa_res <- mkReg(23'd0);
    Reg#(Bit#(24)) tmp_res <- mkReg(24'd0);
    Reg#(Bit#(8)) exp_res <- mkReg(8'd0);
    Reg#(Bit#(50)) temp_s <- mkReg(50'd0);
    Reg#(Bit#(50)) temp_c <- mkReg(50'd0);
    Reg#(Bit#(50)) temp_man <- mkReg(50'd0);
    Reg#(Bit#(2)) add_or_sub <- mkReg(2'b00);
    Reg#(Bit#(31)) exp_mantissa <- mkReg(31'd0);

    function Bit#(8) twos_compliment(Bit#(8) a);
	    Bit#(8) new_a = 8'd0;
	    Bit#(8) out = 8'd0;
	    Bit#(8) b = 8'd1;
	    Bit#(1) carry = 1'b0;
	    for(Integer i = 0; i < 8; i = i + 1) begin
		    if(a[i] == 0) begin
			    new_a[i] = 1;
		    end
		    else begin
			    new_a[i] = 0;
		    end
	    end
	    for(Integer i = 0; i < 8; i = i + 1) begin
		    out[i] = new_a[i] ^ b[i] ^ carry;
		    carry = (new_a[i] & b[i]) | (new_a[i] ^ b[i]) & carry;
	    end
	    return out;
    endfunction:twos_compliment

    function Bit#(50) add_mantissa(Bit#(50) a, Bit#(50) b);
	    Bit#(1) carry = 1'b0;
	    Bit#(50) out = 50'd0;
	    out[0] = a[0] ^ b[0];
	    carry = a[0] & b[0];
	    for(Integer i = 1; i < 50; i = i + 1) begin
		    out[i] = a[i] ^ b[i] ^ carry;
		    carry = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
	    end
	    return out;

    endfunction:add_mantissa

    function Bit#(50) sub_mantissa(Bit#(50) a, Bit#(50) b);
	    Bit#(1) carry = 1'b0;
	    Bit#(50) out = 50'd0;
	    Bit#(50) new_b = add_mantissa((b ^ 1), 1);
	    out[0] = a[0] ^ new_b[0];
	    carry = a[0] & new_b[0];
	    for(Integer i = 1; i < 50; i = i + 1) begin
		    out[i] = a[i] ^ new_b[i] ^ carry;
		    carry = (a[i] & new_b[i]) | (a[i] ^ new_b[i]) & carry;
	    end
	    return out;

    endfunction:sub_mantissa



    function Bit#(8) add_exponents(Bit#(8) exp_a, Bit#(8) exp_b);
	Bit#(8) out = 8'd0;
	Bit#(1) carry = 1'b0;

	out[0] = exp_a[0] ^ exp_b[0];
	carry = exp_a[0] & exp_b[0];
	
	for(Integer i = 1; i < 8; i = i + 1) begin
		out[i] = exp_a[i] ^ exp_b[i] ^ carry;
		carry = (exp_a[i] & exp_b[i]) | (exp_a[i] ^ exp_b[i]) & carry;
	end	
	return out;
    endfunction:add_exponents


    function Bit#(31) rounding_mantissa(Bit#(50) val, Bit#(8) exp);
	    Bit#(23) rounded_mantissa = 23'd0;
	    Bit#(1) round_bit = 1'd0;
	    Bit#(50) temp = 50'd0;

	    if (val[49] == 1'b1) begin
		    exp = add_exponents(exp, 8'd1);
		    round_bit = val[25];
		    if (round_bit == 1'd0) begin
			    rounded_mantissa = val[48:26];
		    end
		    else begin
			    if (val[24:0] == 25'd0 && val[26] == 1'd0) begin
				    rounded_mantissa = val[48:26];
			    end
			    else begin
				    temp = add_mantissa(zeroExtend(val[49:26]), 50'b1);
				    if(temp[24] == 1'd1) begin
					    exp = add_exponents(exp, 8'b1);
					    rounded_mantissa = temp[23:1];
				    end
				    else begin
					    rounded_mantissa = temp[22:0];
				    end
			    end
		    end
	    end
	    else begin
		    round_bit = val[24];
		    if (round_bit == 1'd0) begin
			    rounded_mantissa = val[47:25];
		    end
		    else begin
			    if (val[23:0] == 24'd0 && val[25] == 1'd0) begin
				    rounded_mantissa = val[47:25];
			    end
			    else begin
				    temp = add_mantissa(zeroExtend(val[49:25]), 50'd1);
				    if (temp[24] == 1) begin
					    exp = add_exponents(exp, 8'd1);
					    rounded_mantissa = temp[23:1];
				    end
				    else begin
					    rounded_mantissa = temp[22:0];
				    end
			    end
		    end
	    end
	    return {exp, rounded_mantissa};

    endfunction:rounding_mantissa


    rule rl_swap(got_s && got_c && !swap_done && !handle_zero && !input_zero);
	if ((s.exp == 0 && s.mantissa == 0 && c.exp == 0 && c.mantissa == 0) || ((s.exp == c.exp) && (s.mantissa == c.mantissa) && (s.sign != c.sign))) begin
            handle_zero <= True;
     	end
     	else if (s.exp == 0 && s.mantissa == 0)  begin
	    input_zero <= True;
	    input_no <= 0;
	end
        else if(c.exp == 0 && c.mantissa == 0) begin
            input_zero <= True;
     	    input_no <= 1;
        end
        else begin
            if (s.exp < c.exp) begin
                s <= c;
                c <= s;
            end
	    else if(s.exp == c.exp) begin
	        if(s.mantissa < c.mantissa) begin
	            s <= c;
	    	c <= s;
	        end
	    end
        end
        swap_done <= True;
    endrule

    rule rl_get_sign(got_s && got_c && swap_done && !add_done && !sign_done && !handle_zero && !input_zero);
	$display($stime, " After Swapping s: %b c: %b", s, c);
        tmp_sign <= s.sign ;
	tmp_exp <= s.exp;
        sign_done <= True;
    endrule

    rule rl_cmp_exp(got_s && got_c && swap_done && sign_done && !cmp_exp_done && !add_done &&  !(handle_zero || input_zero));
	    exp_diff <= add_exponents(tmp_exp, twos_compliment(c.exp));
	    temp_s <= {2'b01, s.mantissa, 25'd0};
	    temp_c <= {2'b01, c.mantissa, 25'd0};
	    cmp_exp_done <= True;
    endrule

    rule rl_align_exp(got_s && got_c && swap_done && sign_done && cmp_exp_done && !align_man_done && !add_done && !(handle_zero || input_zero));
	    $display($stime, "i s_mantissa new %b", temp_s);
	    $display($stime, "i c_mantissa new %b", temp_c);
	    $display($stime, "i Exponent difference %d", exp_diff);
	    temp_c <= temp_c >> exp_diff;
	    if(s.sign == c.sign) begin
		    add_or_sub <= 1;
	    end
	    else begin
		    add_or_sub <= 2;
	    end
	    align_man_done <= True;
    endrule

    rule rl_add_or_sub_exp(got_s && got_c && swap_done && sign_done && cmp_exp_done && align_man_done && !calc_fraction_done && !add_done && !(handle_zero || input_zero));
	    $display($stime, " shifted mantissa of c %b", temp_c);
	    if (add_or_sub == 1) begin
		    temp_man <= add_mantissa(temp_s , temp_c);
	    $display($stime, " Adding the mantissa");
	    end
	    else if(add_or_sub == 2) begin
		    temp_man <= sub_mantissa(temp_s, temp_c);
	    $display($stime, " Subtracting the mantissa");
	    end
	    add_or_sub <= 0;
	    calc_fraction_done <= True;
    endrule

    rule rl_adj_exp(got_s && got_c && swap_done && sign_done && cmp_exp_done && align_man_done && calc_fraction_done && !adj_exp_done && !add_done && !(handle_zero || input_zero));
	    $display($stime, " calculated mantissa c %b", temp_man);
	    if(temp_man[48] == 1'b1) begin
		    adj_exp_done <= True;
	    end
	    else begin
			if(temp_man[49] == 1'b1) begin
				tmp_exp <= add_exponents(tmp_exp, 8'b1);
				temp_man <= temp_man >> 1;
			end
			else begin
				// adding 2's compliment of 1 with exponent to reduce it by 1
				tmp_exp <= add_exponents(tmp_exp, 8'b11111111);
				temp_man <= temp_man << 1;
			end
	    end
    endrule

    rule rl_adj_mantissa(got_s && got_c && swap_done && sign_done && cmp_exp_done && align_man_done && calc_fraction_done && adj_exp_done && !mantissa_done && !add_done && !(handle_zero || input_zero));
	    $display($stime, " mantissa: %b", temp_man);
	    exp_mantissa <= rounding_mantissa(temp_man, tmp_exp);
	    mantissa_done <= True;
    endrule

    rule rl_assemble_result(got_s && got_c && swap_done && sign_done && cmp_exp_done && align_man_done && calc_fraction_done && adj_exp_done && mantissa_done && !add_done && !(handle_zero || input_zero));
	    $display($stime, " End Result sign:%b exp: %b mantissa: %b ", tmp_sign, exp_mantissa[30:23], exp_mantissa[22:0]);
	    end_result <= {tmp_sign, exp_mantissa};
	    pack_done <= True;
	    add_done <= True;
    endrule

    rule rl_handle_zero_val(handle_zero || input_zero); 
	    if (handle_zero) begin
		    end_result <= 32'd0;
	    end
	    else if(input_zero) begin
		    if (input_no == 0) begin
			    end_result <= pack(c);
		    end
		    else begin
			    end_result <= pack(s);
		    end
	    end
	    pack_done <= True;
	    add_done <= True;
    endrule

    rule rl_deassert_signals(add_done);
	    got_s <= False;
	    got_c <= False;
	    swap_done <= False;
	    sign_done <= False;
	    cmp_exp_done <= False;
	    align_man_done <= False;
	    calc_fraction_done <= False;
	    adj_exp_done <= False;
	    mantissa_done <= False;
	    // add_done <= False;
	    handle_zero <= False;
	    input_zero <= False;
	    add_or_sub <= 0;
	    addition_start <= False;
    endrule

    // method Action add_start(Bool start) if(!addition_start);
    //         addition_start <= start;
    //         pack_done <= False;
    // endmethod

    // Method to set input A
    method Action get_inp_s(Bit#(32) inp_S) if(!got_s && !add_done);
	    pack_done <= False;
	    s <= Fp32{sign:inp_S[31], exp:inp_S[30:23], mantissa:inp_S[22:0]};
	    got_s <= True;
    endmethod

    // Method to set input B
    method Action get_inp_c(Bit#(32) inp_C) if(!got_c && !add_done);
	    c <= Fp32{sign:inp_C[31], exp:inp_C[30:23], mantissa:inp_C[22:0]};
	    got_c <= True;
    endmethod

    // Method to get the result
    method Bit#(32) get_result() if(pack_done);
        return end_result;
    endmethod

endmodule: mkUnpipelined_float_add

endpackage: MAC_unpipelined_float_add
