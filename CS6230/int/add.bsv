// package add;

// interface Ifc_add;
//     // method ActionValue add_int;
//     method ActionValue #(Bit#(32)) add_int(Bit#(16)a,Bit#(16)b);
// endinterface

// module mk_add(Ifc_add);
//     method ActionValue #(Bit#(32)) add_int(Bit#(16) a, Bit#(16) b);
//         Bit#(32) sum;
//         Bit#(1) carry = 0;

//         // Loop to perform binary addition
//         for(Integer i=0; i<32; i=i+1)
//         begin
//             sum[i] = a[i] ^ b[i] ^ carry[i];
//             carry[i+1] = (a[i] & b[i]) | (a[i] ^ b[i]) & carry;
//         end
//         return sum; // Return the final sum
//     endmethod

// endmodule

// endpackage




package add;

interface Ifc_add;
        method Action give_inp(Bit#(32)a, Bit#(32) b);
        method Bit#(32) get_out();
endinterface

module mk_add(Ifc_add);

    Reg#(Bit#(32)) inp_A <- mkReg(0);
    Reg#(Bit#(32)) inp_B <- mkReg(0);

    function Bit#(32) addint(Bit#(32) a, Bit#(32) b);
        Bit#(32) sum;
        Bit#(33) carry;

        carry[0] = 1;
        // Loop to perform binary addition
        for(Integer i=0; i<32; i=i+1)
        begin
            sum[i] = a[i] ^ b[i] ^ carry[i];
            carry[i+1] = (a[i] & b[i]) | (a[i] ^ b[i]) & carry[i];
        end
        return sum; // Return the final sum
    endfunction

    method Action give_inp(Bit#(32)a, Bit#(32) b);
        inp_A <= a;
        inp_B <= b;
    endmethod 

    method get_out();
        return addint(inp_A,inp_B);
    endmethod

endmodule

endpackage