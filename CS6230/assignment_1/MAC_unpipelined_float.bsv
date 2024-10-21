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
    method Action get_inp_a(Bf16 inp_A);
    method Action get_inp_b(Bf16 inp_b);
    // method Fp32 get_result(); // Method to retrieve the result
    method ActionValue#(Bf16) get_result(); // Method to retrieve the result
endinterface: Ifc_MAC_unpipelined_float

(* synthesize *)
module mkUnpipelined (Ifc_MAC_unpipelined_float);

    Reg#(Bf16) inp_a <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bf16) inp_b <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Bf16) result_mul <- mkReg(Bf16{sign:1'd0, exp:8'd0, mantissa: 7'd0});
    Reg#(Fp32) result_add <- mkReg(Fp32{sign:1'd0, exp:8'd0, mantissa: 23'd0});
    Reg#(Bit#(1)) tmp_sign <- mkReg(1'd0);
    Reg#(Bit#(8)) tmp_exp <- mkReg(8'd0);
    Reg#(Bit#(23)) tmp_mantissa <- mkReg(23'd0);
    Reg#(Bool) got_a <- mkReg(False);
    Reg#(Bool) got_b <- mkReg(False);
    Reg#(Bool) mul_done <- mkReg(False);
    Reg#(Bit#(1)) get_r <- mkReg(0);

    // Method to add two 8-bit numbers without using `+`
    function Bit#(8) add(Bit#(8) a, Bit#(8) b);
        Bit#(8) sum;
        Bit#(1) carry = 1'd0;
        
        // Loop to perform binary addition
        for (int i = 0; i < 8; i = i + 1) begin
            // Calculate the sum bit and carry
            Bit#(1) bit_a = a[i]; // Get the ith bit of a
            Bit#(1) bit_b = b[i]; // Get the ith bit of b
            sum[i] = bit_a ^ bit_b ^ carry; // Sum of the bits with carry
            carry = (bit_a & bit_b) | (carry & (bit_a ^ bit_b)); // Calculate carry
        end

        return sum; // Return the final sum
    endfunction

    // Method to increment an 8-bit number without using `+`
    function Bit#(8) increment(Bit#(8) a);
        Bit#(8) result = a;
        Bit#(1) carry = 1; // Start with carry of 1 to perform increment

        for (int i = 0; i < 8; i = i + 1) begin
            Bit#(1) bit_d = result[i];
            result[i] = bit_d ^ carry; // Add carry to current bit
            carry = bit_d & carry; // Calculate new carry
        end
        
        return result; // Return the incremented result
    endfunction

    function Fp32 bf16_to_fp32(Bf16 inp);
        Bit#(1) tmp_s = inp.sign;
        Bit#(8) tmp_e = inp.exp;
        Bit#(23) tmp_m = zeroExtend(inp.mantissa) << 16;

        return Fp32{sign:tmp_s, exp:tmp_e, mantissa:tmp_m};
    endfunction

    // Rule to compute the result when both inputs are available
    rule get_mul_res(got_a && got_b && !mul_done);
        // Retrieve inputs
        Bf16 a = inp_a;
        Bf16 b = inp_b;
		Bool return_bool = False;

        // Intermediate variables
        tmp_sign <= a.sign ^ b.sign; // Sign of the result

        // Handle zero case
        if (a.exp == 0 && a.mantissa == 0) begin
            result_mul <= Bf16{sign:b.sign, exp:b.exp, mantissa:b.mantissa};
            got_a <= False; // Reset input flags
            got_b <= False;
            return_bool = True; // Exit early
        end
        if (b.exp == 0 && b.mantissa == 0 && ! return_bool) begin
            result_mul <= Bf16{sign:a.sign, exp:a.exp, mantissa:a.mantissa};
            got_a <= False; // Reset input flags
            got_b <= False;
            return_bool = True; // Exit early
        end

		if (!return_bool) begin
			Bit#(8) tmp_exp = 8'd0;
	        Bit#(7) tmp_man;

			// Handle exponent addition (subtract the bias, typically 127 for float)
			tmp_exp = add(a.exp, b.exp); // Use custom add function
			tmp_exp = increment(tmp_exp); // Increment exponent after addition
			tmp_exp = increment(tmp_exp); // Simulating tmp_exp - 127 by adding a negative bias

			// Prepare mantissas for multiplication (add implicit leading 1 if normalized)
			Bit#(7) mantissa_a = (a.exp == 0) ? a.mantissa : (a.mantissa | (1 << 7)); // Add leading 1 if normalized
			Bit#(7) mantissa_b = (b.exp == 0) ? b.mantissa : (b.mantissa | (1 << 7)); // Add leading 1 if normalized

			// Replacing the multiplication of mantissas with a bitwise method
			Bit#(16) mantissa_product = 16'd0;
			for (int i = 0; i < 7; i = i + 1) begin
				if (mantissa_b[i] == 1) begin // Change to `1` for multiplication logic
					mantissa_product = mantissa_product | zeroExtend(mantissa_a << i); // Shift and accumulate
				end
			end


			// Normalization logic for mantissa
			if (mantissa_product[15] == 1) begin
				// Overflow in mantissa16
				tmp_man = mantissa_product[14:8]; // Shift right
				tmp_exp = increment(tmp_exp); // Increment exponent
			end else begin
				tmp_man = mantissa_product[13:7]; // No overflow
			end

			// Assign result
			result_mul <= Bf16{sign: tmp_sign, exp: tmp_exp, mantissa: tmp_man[6:0]};
            mul_done <= True;
			
			// Reset flags after result computation
			got_a <= False;
			got_b <= False;
		end
    endrule

    rule get_add_res(mul_done); 
        // result_add <= 32'd0;
        mul_done <= False;
    endrule

    // Method to set input A
    method Action get_inp_a(Bf16 inp_A);
        inp_a <= inp_A;
        got_a <= True;
    endmethod

    // Method to set input B
    method Action get_inp_b(Bf16 inp_B);
        inp_b <= inp_B;
        got_b <= True;
    endmethod

    // Method to get the result
    // method Fp32 get_result();
    method ActionValue#(Bf16) get_result();
        get_r <= 1;
        return result_mul;
    endmethod

endmodule: mkUnpipelined

endpackage
