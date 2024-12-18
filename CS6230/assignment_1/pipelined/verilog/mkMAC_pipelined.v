//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Tue Nov 26 15:50:56 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1
// RDY_get_B                      O     1
// RDY_get_C                      O     1
// RDY_get_select                 O     1
// output_MAC                     O    32
// RDY_output_MAC                 O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16
// get_B_b                        I    16
// get_C_c                        I    32
// get_select_select              I     1
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_get_C                       I     1
// EN_get_select                  I     1
// EN_output_MAC                  I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkMAC_pipelined(CLK,
		       RST_N,

		       get_A_a,
		       EN_get_A,
		       RDY_get_A,

		       get_B_b,
		       EN_get_B,
		       RDY_get_B,

		       get_C_c,
		       EN_get_C,
		       RDY_get_C,

		       get_select_select,
		       EN_get_select,
		       RDY_get_select,

		       EN_output_MAC,
		       output_MAC,
		       RDY_output_MAC);
  input  CLK;
  input  RST_N;

  // action method get_A
  input  [15 : 0] get_A_a;
  input  EN_get_A;
  output RDY_get_A;

  // action method get_B
  input  [15 : 0] get_B_b;
  input  EN_get_B;
  output RDY_get_B;

  // action method get_C
  input  [31 : 0] get_C_c;
  input  EN_get_C;
  output RDY_get_C;

  // action method get_select
  input  get_select_select;
  input  EN_get_select;
  output RDY_get_select;

  // actionvalue method output_MAC
  input  EN_output_MAC;
  output [31 : 0] output_MAC;
  output RDY_output_MAC;

  // signals for module outputs
  wire [31 : 0] output_MAC;
  wire RDY_get_A, RDY_get_B, RDY_get_C, RDY_get_select, RDY_output_MAC;

  // inlined wires
  wire [32 : 0] inpC_fifo_rv_port0__write_1,
		inpC_fifo_rv_port1__read,
		inpC_fifo_rv_port1__write_1,
		inpC_fifo_rv_port2__read,
		out_fifo_rv_port1__read,
		out_fifo_rv_port1__write_1,
		out_fifo_rv_port2__read;
  wire [16 : 0] inpA_fifo_rv_port0__write_1,
		inpA_fifo_rv_port1__read,
		inpA_fifo_rv_port1__write_1,
		inpA_fifo_rv_port2__read,
		inpB_fifo_rv_port1__read,
		inpB_fifo_rv_port1__write_1,
		inpB_fifo_rv_port2__read;
  wire [1 : 0] inpS_fifo_rv_port0__write_1,
	       inpS_fifo_rv_port1__read,
	       inpS_fifo_rv_port1__write_1,
	       inpS_fifo_rv_port2__read;
  wire out_fifo_rv_EN_port1__write;

  // register float_output
  reg [31 : 0] float_output;
  wire [31 : 0] float_output_D_IN;
  wire float_output_EN;

  // register got_output
  reg got_output;
  wire got_output_D_IN, got_output_EN;

  // register inpA_fifo_rv
  reg [16 : 0] inpA_fifo_rv;
  wire [16 : 0] inpA_fifo_rv_D_IN;
  wire inpA_fifo_rv_EN;

  // register inpB_fifo_rv
  reg [16 : 0] inpB_fifo_rv;
  wire [16 : 0] inpB_fifo_rv_D_IN;
  wire inpB_fifo_rv_EN;

  // register inpC_fifo_rv
  reg [32 : 0] inpC_fifo_rv;
  wire [32 : 0] inpC_fifo_rv_D_IN;
  wire inpC_fifo_rv_EN;

  // register inpS_fifo_rv
  reg [1 : 0] inpS_fifo_rv;
  wire [1 : 0] inpS_fifo_rv_D_IN;
  wire inpS_fifo_rv_EN;

  // register int_output
  reg [31 : 0] int_output;
  wire [31 : 0] int_output_D_IN;
  wire int_output_EN;

  // register out_fifo_rv
  reg [32 : 0] out_fifo_rv;
  wire [32 : 0] out_fifo_rv_D_IN;
  wire out_fifo_rv_EN;

  // register sel
  reg sel;
  wire sel_D_IN, sel_EN;

  // ports of submodule mac_float
  wire [31 : 0] mac_float_get_MAC_result, mac_float_get_input_c_c;
  wire [15 : 0] mac_float_get_input_a_a, mac_float_get_input_b_b;
  wire mac_float_EN_get_MAC_result,
       mac_float_EN_get_input_a,
       mac_float_EN_get_input_b,
       mac_float_EN_get_input_c,
       mac_float_EN_get_input_s,
       mac_float_RDY_get_MAC_result,
       mac_float_RDY_get_input_a,
       mac_float_RDY_get_input_b,
       mac_float_RDY_get_input_c;

  // ports of submodule mac_int
  wire [31 : 0] mac_int_get_C_c, mac_int_get_output;
  wire [15 : 0] mac_int_get_A_a, mac_int_get_B_b;
  wire mac_int_EN_get_A,
       mac_int_EN_get_B,
       mac_int_EN_get_C,
       mac_int_EN_get_output,
       mac_int_EN_get_select,
       mac_int_RDY_get_A,
       mac_int_RDY_get_B,
       mac_int_RDY_get_C,
       mac_int_RDY_get_output,
       mac_int_get_select_select;

  // rule scheduling signals
  wire CAN_FIRE_RL_call_MAC,
       CAN_FIRE_RL_get_output_from_floatMAC,
       CAN_FIRE_RL_get_output_from_intMAC,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_get_C,
       CAN_FIRE_get_select,
       CAN_FIRE_output_MAC,
       WILL_FIRE_RL_call_MAC,
       WILL_FIRE_RL_get_output_from_floatMAC,
       WILL_FIRE_RL_get_output_from_intMAC,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_get_C,
       WILL_FIRE_get_select,
       WILL_FIRE_output_MAC;

  // inputs to muxes for submodule ports
  wire [32 : 0] MUX_out_fifo_rv_port1__write_1__VAL_1,
		MUX_out_fifo_rv_port1__write_1__VAL_2;

  // remaining internal signals
  wire mac_float_RDY_get_input_a_AND_mac_float_RDY_ge_ETC___d19;

  // action method get_A
  assign RDY_get_A = !inpA_fifo_rv_port1__read[16] ;
  assign CAN_FIRE_get_A = !inpA_fifo_rv_port1__read[16] ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = !inpB_fifo_rv_port1__read[16] ;
  assign CAN_FIRE_get_B = !inpB_fifo_rv_port1__read[16] ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // action method get_C
  assign RDY_get_C = !inpC_fifo_rv_port1__read[32] ;
  assign CAN_FIRE_get_C = !inpC_fifo_rv_port1__read[32] ;
  assign WILL_FIRE_get_C = EN_get_C ;

  // action method get_select
  assign RDY_get_select = !inpS_fifo_rv_port1__read[1] ;
  assign CAN_FIRE_get_select = !inpS_fifo_rv_port1__read[1] ;
  assign WILL_FIRE_get_select = EN_get_select ;

  // actionvalue method output_MAC
  assign output_MAC = out_fifo_rv[31:0] ;
  assign RDY_output_MAC = out_fifo_rv[32] ;
  assign CAN_FIRE_output_MAC = out_fifo_rv[32] ;
  assign WILL_FIRE_output_MAC = EN_output_MAC ;

  // submodule mac_float
  mkPipelined_float mac_float(.CLK(CLK),
			      .RST_N(RST_N),
			      .get_input_a_a(mac_float_get_input_a_a),
			      .get_input_b_b(mac_float_get_input_b_b),
			      .get_input_c_c(mac_float_get_input_c_c),
			      .EN_get_input_a(mac_float_EN_get_input_a),
			      .EN_get_input_b(mac_float_EN_get_input_b),
			      .EN_get_input_s(mac_float_EN_get_input_s),
			      .EN_get_input_c(mac_float_EN_get_input_c),
			      .EN_get_MAC_result(mac_float_EN_get_MAC_result),
			      .RDY_get_input_a(mac_float_RDY_get_input_a),
			      .RDY_get_input_b(mac_float_RDY_get_input_b),
			      .RDY_get_input_s(),
			      .RDY_get_input_c(mac_float_RDY_get_input_c),
			      .get_MAC_result(mac_float_get_MAC_result),
			      .RDY_get_MAC_result(mac_float_RDY_get_MAC_result));

  // submodule mac_int
  mkintmul mac_int(.CLK(CLK),
		   .RST_N(RST_N),
		   .get_A_a(mac_int_get_A_a),
		   .get_B_b(mac_int_get_B_b),
		   .get_C_c(mac_int_get_C_c),
		   .get_select_select(mac_int_get_select_select),
		   .EN_get_A(mac_int_EN_get_A),
		   .EN_get_B(mac_int_EN_get_B),
		   .EN_get_C(mac_int_EN_get_C),
		   .EN_get_select(mac_int_EN_get_select),
		   .EN_get_output(mac_int_EN_get_output),
		   .RDY_get_A(mac_int_RDY_get_A),
		   .RDY_get_B(mac_int_RDY_get_B),
		   .RDY_get_C(mac_int_RDY_get_C),
		   .RDY_get_select(),
		   .get_output(mac_int_get_output),
		   .RDY_get_output(mac_int_RDY_get_output));

  // rule RL_get_output_from_intMAC
  assign CAN_FIRE_RL_get_output_from_intMAC =
	     mac_int_RDY_get_output && !out_fifo_rv_port1__read[32] && !sel ;
  assign WILL_FIRE_RL_get_output_from_intMAC =
	     CAN_FIRE_RL_get_output_from_intMAC ;

  // rule RL_get_output_from_floatMAC
  assign CAN_FIRE_RL_get_output_from_floatMAC =
	     mac_float_RDY_get_MAC_result && !out_fifo_rv_port1__read[32] &&
	     sel ;
  assign WILL_FIRE_RL_get_output_from_floatMAC =
	     CAN_FIRE_RL_get_output_from_floatMAC ;

  // rule RL_call_MAC
  assign CAN_FIRE_RL_call_MAC =
	     inpS_fifo_rv[1] && inpA_fifo_rv[16] && inpB_fifo_rv[16] &&
	     inpC_fifo_rv[32] &&
	     mac_float_RDY_get_input_a_AND_mac_float_RDY_ge_ETC___d19 ;
  assign WILL_FIRE_RL_call_MAC = CAN_FIRE_RL_call_MAC ;

  // inputs to muxes for submodule ports
  assign MUX_out_fifo_rv_port1__write_1__VAL_1 =
	     { 1'd1, mac_int_get_output } ;
  assign MUX_out_fifo_rv_port1__write_1__VAL_2 =
	     { 1'd1, mac_float_get_MAC_result } ;

  // inlined wires
  assign inpA_fifo_rv_port0__write_1 =
	     { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign inpA_fifo_rv_port1__read =
	     CAN_FIRE_RL_call_MAC ?
	       inpA_fifo_rv_port0__write_1 :
	       inpA_fifo_rv ;
  assign inpA_fifo_rv_port1__write_1 = { 1'd1, get_A_a } ;
  assign inpA_fifo_rv_port2__read =
	     EN_get_A ?
	       inpA_fifo_rv_port1__write_1 :
	       inpA_fifo_rv_port1__read ;
  assign inpB_fifo_rv_port1__read =
	     CAN_FIRE_RL_call_MAC ?
	       inpA_fifo_rv_port0__write_1 :
	       inpB_fifo_rv ;
  assign inpB_fifo_rv_port1__write_1 = { 1'd1, get_B_b } ;
  assign inpB_fifo_rv_port2__read =
	     EN_get_B ?
	       inpB_fifo_rv_port1__write_1 :
	       inpB_fifo_rv_port1__read ;
  assign inpC_fifo_rv_port0__write_1 =
	     { 1'd0,
	       32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign inpC_fifo_rv_port1__read =
	     CAN_FIRE_RL_call_MAC ?
	       inpC_fifo_rv_port0__write_1 :
	       inpC_fifo_rv ;
  assign inpC_fifo_rv_port1__write_1 = { 1'd1, get_C_c } ;
  assign inpC_fifo_rv_port2__read =
	     EN_get_C ?
	       inpC_fifo_rv_port1__write_1 :
	       inpC_fifo_rv_port1__read ;
  assign inpS_fifo_rv_port0__write_1 =
	     { 1'd0, 1'bx /* unspecified value */  } ;
  assign inpS_fifo_rv_port1__read =
	     CAN_FIRE_RL_call_MAC ?
	       inpS_fifo_rv_port0__write_1 :
	       inpS_fifo_rv ;
  assign inpS_fifo_rv_port1__write_1 = { 1'd1, get_select_select } ;
  assign inpS_fifo_rv_port2__read =
	     EN_get_select ?
	       inpS_fifo_rv_port1__write_1 :
	       inpS_fifo_rv_port1__read ;
  assign out_fifo_rv_port1__read =
	     EN_output_MAC ? inpC_fifo_rv_port0__write_1 : out_fifo_rv ;
  assign out_fifo_rv_EN_port1__write =
	     WILL_FIRE_RL_get_output_from_intMAC ||
	     WILL_FIRE_RL_get_output_from_floatMAC ;
  assign out_fifo_rv_port1__write_1 =
	     WILL_FIRE_RL_get_output_from_intMAC ?
	       MUX_out_fifo_rv_port1__write_1__VAL_1 :
	       MUX_out_fifo_rv_port1__write_1__VAL_2 ;
  assign out_fifo_rv_port2__read =
	     out_fifo_rv_EN_port1__write ?
	       out_fifo_rv_port1__write_1 :
	       out_fifo_rv_port1__read ;

  // register float_output
  assign float_output_D_IN = 32'h0 ;
  assign float_output_EN = 1'b0 ;

  // register got_output
  assign got_output_D_IN = 1'b0 ;
  assign got_output_EN = 1'b0 ;

  // register inpA_fifo_rv
  assign inpA_fifo_rv_D_IN = inpA_fifo_rv_port2__read ;
  assign inpA_fifo_rv_EN = 1'b1 ;

  // register inpB_fifo_rv
  assign inpB_fifo_rv_D_IN = inpB_fifo_rv_port2__read ;
  assign inpB_fifo_rv_EN = 1'b1 ;

  // register inpC_fifo_rv
  assign inpC_fifo_rv_D_IN = inpC_fifo_rv_port2__read ;
  assign inpC_fifo_rv_EN = 1'b1 ;

  // register inpS_fifo_rv
  assign inpS_fifo_rv_D_IN = inpS_fifo_rv_port2__read ;
  assign inpS_fifo_rv_EN = 1'b1 ;

  // register int_output
  assign int_output_D_IN = 32'h0 ;
  assign int_output_EN = 1'b0 ;

  // register out_fifo_rv
  assign out_fifo_rv_D_IN = out_fifo_rv_port2__read ;
  assign out_fifo_rv_EN = 1'b1 ;

  // register sel
  assign sel_D_IN = inpS_fifo_rv[0] ;
  assign sel_EN = CAN_FIRE_RL_call_MAC ;

  // submodule mac_float
  assign mac_float_get_input_a_a = inpA_fifo_rv[15:0] ;
  assign mac_float_get_input_b_b = inpB_fifo_rv[15:0] ;
  assign mac_float_get_input_c_c = inpC_fifo_rv[31:0] ;
  assign mac_float_EN_get_input_a = WILL_FIRE_RL_call_MAC && inpS_fifo_rv[0] ;
  assign mac_float_EN_get_input_b = WILL_FIRE_RL_call_MAC && inpS_fifo_rv[0] ;
  assign mac_float_EN_get_input_s = 1'b0 ;
  assign mac_float_EN_get_input_c = WILL_FIRE_RL_call_MAC && inpS_fifo_rv[0] ;
  assign mac_float_EN_get_MAC_result = CAN_FIRE_RL_get_output_from_floatMAC ;

  // submodule mac_int
  assign mac_int_get_A_a = inpA_fifo_rv[15:0] ;
  assign mac_int_get_B_b = inpB_fifo_rv[15:0] ;
  assign mac_int_get_C_c = inpC_fifo_rv[31:0] ;
  assign mac_int_get_select_select = 1'b0 ;
  assign mac_int_EN_get_A = WILL_FIRE_RL_call_MAC && !inpS_fifo_rv[0] ;
  assign mac_int_EN_get_B = WILL_FIRE_RL_call_MAC && !inpS_fifo_rv[0] ;
  assign mac_int_EN_get_C = WILL_FIRE_RL_call_MAC && !inpS_fifo_rv[0] ;
  assign mac_int_EN_get_select = 1'b0 ;
  assign mac_int_EN_get_output = CAN_FIRE_RL_get_output_from_intMAC ;

  // remaining internal signals
  assign mac_float_RDY_get_input_a_AND_mac_float_RDY_ge_ETC___d19 =
	     mac_float_RDY_get_input_a && mac_float_RDY_get_input_b &&
	     mac_float_RDY_get_input_c &&
	     mac_int_RDY_get_C &&
	     mac_int_RDY_get_B &&
	     mac_int_RDY_get_A ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        float_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	got_output <= `BSV_ASSIGNMENT_DELAY 1'd0;
	inpA_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  };
	inpB_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 16'bxxxxxxxxxxxxxxxx /* unspecified value */  };
	inpC_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0,
	      32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	inpS_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 1'bx /* unspecified value */  };
	int_output <= `BSV_ASSIGNMENT_DELAY 32'd0;
	out_fifo_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0,
	      32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	sel <= `BSV_ASSIGNMENT_DELAY 1'd0;
      end
    else
      begin
        if (float_output_EN)
	  float_output <= `BSV_ASSIGNMENT_DELAY float_output_D_IN;
	if (got_output_EN)
	  got_output <= `BSV_ASSIGNMENT_DELAY got_output_D_IN;
	if (inpA_fifo_rv_EN)
	  inpA_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpA_fifo_rv_D_IN;
	if (inpB_fifo_rv_EN)
	  inpB_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpB_fifo_rv_D_IN;
	if (inpC_fifo_rv_EN)
	  inpC_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpC_fifo_rv_D_IN;
	if (inpS_fifo_rv_EN)
	  inpS_fifo_rv <= `BSV_ASSIGNMENT_DELAY inpS_fifo_rv_D_IN;
	if (int_output_EN)
	  int_output <= `BSV_ASSIGNMENT_DELAY int_output_D_IN;
	if (out_fifo_rv_EN)
	  out_fifo_rv <= `BSV_ASSIGNMENT_DELAY out_fifo_rv_D_IN;
	if (sel_EN) sel <= `BSV_ASSIGNMENT_DELAY sel_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    float_output = 32'hAAAAAAAA;
    got_output = 1'h0;
    inpA_fifo_rv = 17'h0AAAA;
    inpB_fifo_rv = 17'h0AAAA;
    inpC_fifo_rv = 33'h0AAAAAAAA;
    inpS_fifo_rv = 2'h2;
    int_output = 32'hAAAAAAAA;
    out_fifo_rv = 33'h0AAAAAAAA;
    sel = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC_pipelined

