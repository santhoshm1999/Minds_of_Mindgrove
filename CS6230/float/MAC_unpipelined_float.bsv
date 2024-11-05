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
    endfunction

    function Fp32 bf16_to_fp32(Bf16 inp);
        Bit#(1) tmp_s = inp.sign;
        Bit#(8) tmp_e = inp.exp;
        Bit#(23) tmp_m = zeroExtend(inp.mantissa) << 16;

        return Fp32{sign:tmp_s, exp:tmp_e, mantissa:tmp_m};
    endfunction

    function Bit#(7) rounding_mul_mantissa(Bit#(15) val1);
        Bit#(7) rounded_mantissa = 7'd0;
        if (val1[9] == 1'd0) begin
            rounded_mantissa = val1[14:8];
        end
        else begin
            // TODO: Check the condition and return below
            if (val1[11] != 1'd0 && val1[8:0] == 9'd0) begin
                rounded_mantissa = val1[14:8];
            end
            else begin
                Bit#(16) temp = addition(zeroExtend(val1[14:8]), 16'd1);
                rounded_mantissa = temp[6:0];
            end
        end
        return rounded_mantissa;
    endfunction

    function Bf16 multiplication(Bf16 a, Bf16 b);
        Bit#(1) sign_res = 0;
        Bit#(8) exp_res = 0;
        Bit#(7) mantissa_res = 7'd0;
        Bit#(16) fraction_mul = 16'd0;
        Bit#(15) fraction_mul_to_round = 15'd0;
        // Bit#(16) a_man = a.mantissa;
        // Bit#(7) b_man = b.mantissa;
        sign_res = a.sign ^ b.sign; // Sign of the result
        
        if ((a.exp == 0 &&  a.mantissa == 0) || (b.exp == 0 &&  b.mantissa == 0)) begin
            // return Bf16{sign: 1'd0, exp: 8'd0, mantissa: 7'd0};
            sign_res = 1'd0;
            exp_res = 8'd0;
            mantissa_res = 7'd0;
        end
        else if (a.exp == 8'b01111111 && a.mantissa == 0) begin
            exp_res = b.exp;
            mantissa_res = b.mantissa;
            // return Bf16{sign: sign_res, exp: exp_res, mantissa: mantissa_res};
        end
        else if (b.exp == 8'b01111111 && b.mantissa == 0) begin
            exp_res = a.exp;
            mantissa_res = a.mantissa;
            // return Bf16{sign:sign_res, exp:exp_res, mantissa:mantissa_res};
        end
        else begin
            Bit#(8) implicited_mantissa_a = {1, a.mantissa};
            Bit#(8) implicited_mantissa_b = {1, b.mantissa};
            for (Integer i=0; i<7; i=i+1) begin
                if (implicited_mantissa_b[i] == 1)begin
                    fraction_mul = addition(fraction_mul, zeroExtend(implicited_mantissa_a << i));
                end
            end
            if (fraction_mul[15] == 1'd1) begin
                Bit#(16) temp = addition(zeroExtend(exp_res), 16'd1);
                exp_res = temp[7:0];
                fraction_mul_to_round = fraction_mul[14:0];
            end
            else begin
                while(fraction_mul[14] != 1'd1) begin
                    fraction_mul = fraction_mul << 1'd1;
                    fraction_mul = fraction_mul & 16'hff;
                end
                fraction_mul_to_round = fraction_mul[14:0];
            end
            mantissa_res = rounding_mul_mantissa(fraction_mul_to_round);
        end
        return Bf16{sign:sign_res, exp:exp_res, mantissa:mantissa_res};
        
    endfunction

    // Rule to compute the result when both inputs are available
    rule get_mul_res(got_a && got_b && !mul_done);
        // Retrieve inputs
        Bf16 a = inp_a;
        Bf16 b = inp_b;

        // Intermediate variables
        result_mul <= multiplication(a, b);
        got_a <= False; // Reset input flags
        got_b <= False;
        mul_done <= True;
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
