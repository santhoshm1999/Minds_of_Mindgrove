package mul;

interface Ifc_mul;
        method Action give_inp(Bit#(16)a, Bit#(16) b);
        method Bit#(32) get_out();
endinterface

module mk_mul(Ifc_mul);

    Reg#(Bit#(16)) inp_A <- mkReg(0);
    Reg#(Bit#(16)) inp_B <- mkReg(0);
    Bit#(32) x = 0;

    function Bit#(32) mulint(Bit#(16) a, Bit#(16) b);
        Bit#(1) sign_A = a[0];
        Bit#(1) sign_B = b[0];
        Bit#(1) carry = 1'd0;
        Bit#(32)temp = 0;

        Bit#(1) sign = sign_A & sign_B;

        // Loop to perform binary addition
        a = abs(a);
        b = abs(b);
        for (int i = 0; i < 16; i = i + 1) 
        begin
        if(b[i] == 0)
        begin
            temp = temp + zeroExtend(a<<i);
        end
        //     if(b[0] & (1<< i) != 0)
        end
        if(sign == 1'b1)
            temp = temp & (1<<31);
        return temp; // Return the final sum
    endfunction : mulint

    method Action give_inp(Bit#(16)a, Bit#(16) b);
        inp_A <= a;
        inp_B <= b;
    endmethod 

    method get_out();
        return mulint(inp_A,inp_B);
    endmethod


    //     rule rl_add;
    //     give_inp(16'b1010101010101010 ,16'b0101010101010101);
    //     x <= get_out;
    //     $display("x %b",x);
    // endrule

endmodule

endpackage