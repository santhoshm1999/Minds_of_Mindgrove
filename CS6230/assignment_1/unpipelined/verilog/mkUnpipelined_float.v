//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Tue Nov 26 12:43:58 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_input_a                O     1
// RDY_get_input_b                O     1
// RDY_get_input_s                O     1 const
// RDY_get_input_c                O     1
// get_MAC_result                 O    32 reg
// RDY_get_MAC_result             O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_input_a_a                  I    16 reg
// get_input_b_b                  I    16 reg
// get_input_c_c                  I    32 reg
// EN_get_input_a                 I     1
// EN_get_input_b                 I     1
// EN_get_input_s                 I     1 unused
// EN_get_input_c                 I     1
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

module mkUnpipelined_float(CLK,
			   RST_N,

			   get_input_a_a,
			   EN_get_input_a,
			   RDY_get_input_a,

			   get_input_b_b,
			   EN_get_input_b,
			   RDY_get_input_b,

			   EN_get_input_s,
			   RDY_get_input_s,

			   get_input_c_c,
			   EN_get_input_c,
			   RDY_get_input_c,

			   get_MAC_result,
			   RDY_get_MAC_result);
  input  CLK;
  input  RST_N;

  // action method get_input_a
  input  [15 : 0] get_input_a_a;
  input  EN_get_input_a;
  output RDY_get_input_a;

  // action method get_input_b
  input  [15 : 0] get_input_b_b;
  input  EN_get_input_b;
  output RDY_get_input_b;

  // action method get_input_s
  input  EN_get_input_s;
  output RDY_get_input_s;

  // action method get_input_c
  input  [31 : 0] get_input_c_c;
  input  EN_get_input_c;
  output RDY_get_input_c;

  // value method get_MAC_result
  output [31 : 0] get_MAC_result;
  output RDY_get_MAC_result;

  // signals for module outputs
  wire [31 : 0] get_MAC_result;
  wire RDY_get_MAC_result,
       RDY_get_input_a,
       RDY_get_input_b,
       RDY_get_input_c,
       RDY_get_input_s;

  // register add_done
  reg add_done;
  wire add_done_D_IN, add_done_EN;

  // register add_started
  reg add_started;
  wire add_started_D_IN, add_started_EN;

  // register got_rg_a
  reg got_rg_a;
  wire got_rg_a_D_IN, got_rg_a_EN;

  // register got_rg_b
  reg got_rg_b;
  wire got_rg_b_D_IN, got_rg_b_EN;

  // register got_rg_c
  reg got_rg_c;
  wire got_rg_c_D_IN, got_rg_c_EN;

  // register got_rg_s
  reg got_rg_s;
  wire got_rg_s_D_IN, got_rg_s_EN;

  // register mac_completed
  reg mac_completed;
  wire mac_completed_D_IN, mac_completed_EN;

  // register mul_done
  reg mul_done;
  wire mul_done_D_IN, mul_done_EN;

  // register mul_started
  reg mul_started;
  wire mul_started_D_IN, mul_started_EN;

  // register rg_a
  reg [15 : 0] rg_a;
  wire [15 : 0] rg_a_D_IN;
  wire rg_a_EN;

  // register rg_b
  reg [15 : 0] rg_b;
  wire [15 : 0] rg_b_D_IN;
  wire rg_b_EN;

  // register rg_c
  reg [31 : 0] rg_c;
  wire [31 : 0] rg_c_D_IN;
  wire rg_c_EN;

  // register rg_mac_result
  reg [31 : 0] rg_mac_result;
  wire [31 : 0] rg_mac_result_D_IN;
  wire rg_mac_result_EN;

  // register rg_s
  reg [15 : 0] rg_s;
  wire [15 : 0] rg_s_D_IN;
  wire rg_s_EN;

  // ports of submodule add
  wire [31 : 0] add_get_inp_c_inp_C, add_get_inp_s_inp_S, add_get_result;
  wire add_EN_get_inp_c,
       add_EN_get_inp_s,
       add_RDY_get_inp_c,
       add_RDY_get_inp_s,
       add_RDY_get_result;

  // ports of submodule mul
  wire [15 : 0] mul_get_inp_a_inp_A, mul_get_inp_b_inp_B, mul_get_result;
  wire mul_EN_get_inp_a,
       mul_EN_get_inp_b,
       mul_RDY_get_inp_a,
       mul_RDY_get_inp_b,
       mul_RDY_get_result;

  // rule scheduling signals
  wire CAN_FIRE_RL_get_mul_result,
       CAN_FIRE_RL_rl_deassert_signals,
       CAN_FIRE_RL_rl_get_add_result,
       CAN_FIRE_RL_rl_put_add_val,
       CAN_FIRE_RL_rl_put_mul_val,
       CAN_FIRE_get_input_a,
       CAN_FIRE_get_input_b,
       CAN_FIRE_get_input_c,
       CAN_FIRE_get_input_s,
       WILL_FIRE_RL_get_mul_result,
       WILL_FIRE_RL_rl_deassert_signals,
       WILL_FIRE_RL_rl_get_add_result,
       WILL_FIRE_RL_rl_put_add_val,
       WILL_FIRE_RL_rl_put_mul_val,
       WILL_FIRE_get_input_a,
       WILL_FIRE_get_input_b,
       WILL_FIRE_get_input_c,
       WILL_FIRE_get_input_s;

  // inputs to muxes for submodule ports
  wire MUX_mul_done_write_1__SEL_1, MUX_mul_done_write_1__SEL_2;

  // declarations used by system tasks
  // synopsys translate_off
  reg [31 : 0] v__h764;
  reg [31 : 0] v__h593;
  reg [31 : 0] v__h922;
  // synopsys translate_on

  // action method get_input_a
  assign RDY_get_input_a = !got_rg_a ;
  assign CAN_FIRE_get_input_a = !got_rg_a ;
  assign WILL_FIRE_get_input_a = EN_get_input_a ;

  // action method get_input_b
  assign RDY_get_input_b = !got_rg_b ;
  assign CAN_FIRE_get_input_b = !got_rg_b ;
  assign WILL_FIRE_get_input_b = EN_get_input_b ;

  // action method get_input_s
  assign RDY_get_input_s = 1'd1 ;
  assign CAN_FIRE_get_input_s = 1'd1 ;
  assign WILL_FIRE_get_input_s = EN_get_input_s ;

  // action method get_input_c
  assign RDY_get_input_c = !got_rg_c ;
  assign CAN_FIRE_get_input_c = !got_rg_c ;
  assign WILL_FIRE_get_input_c = EN_get_input_c ;

  // value method get_MAC_result
  assign get_MAC_result = rg_mac_result ;
  assign RDY_get_MAC_result = mac_completed ;

  // submodule add
  mkUnpipelined_float_add add(.CLK(CLK),
			      .RST_N(RST_N),
			      .get_inp_c_inp_C(add_get_inp_c_inp_C),
			      .get_inp_s_inp_S(add_get_inp_s_inp_S),
			      .EN_get_inp_s(add_EN_get_inp_s),
			      .EN_get_inp_c(add_EN_get_inp_c),
			      .RDY_get_inp_s(add_RDY_get_inp_s),
			      .RDY_get_inp_c(add_RDY_get_inp_c),
			      .get_result(add_get_result),
			      .RDY_get_result(add_RDY_get_result));

  // submodule mul
  mkUnpipelined_float_mul mul(.CLK(CLK),
			      .RST_N(RST_N),
			      .get_inp_a_inp_A(mul_get_inp_a_inp_A),
			      .get_inp_b_inp_B(mul_get_inp_b_inp_B),
			      .EN_get_inp_a(mul_EN_get_inp_a),
			      .EN_get_inp_b(mul_EN_get_inp_b),
			      .RDY_get_inp_a(mul_RDY_get_inp_a),
			      .RDY_get_inp_b(mul_RDY_get_inp_b),
			      .get_result(mul_get_result),
			      .RDY_get_result(mul_RDY_get_result));

  // rule RL_rl_put_add_val
  assign CAN_FIRE_RL_rl_put_add_val =
	     add_RDY_get_inp_c && add_RDY_get_inp_s && got_rg_a && got_rg_b &&
	     got_rg_c &&
	     mul_done &&
	     !add_started ;
  assign WILL_FIRE_RL_rl_put_add_val = CAN_FIRE_RL_rl_put_add_val ;

  // rule RL_get_mul_result
  assign CAN_FIRE_RL_get_mul_result = MUX_mul_done_write_1__SEL_2 ;
  assign WILL_FIRE_RL_get_mul_result = MUX_mul_done_write_1__SEL_2 ;

  // rule RL_rl_put_mul_val
  assign CAN_FIRE_RL_rl_put_mul_val =
	     mul_RDY_get_inp_b && mul_RDY_get_inp_a && got_rg_a && got_rg_b &&
	     !mul_started ;
  assign WILL_FIRE_RL_rl_put_mul_val = CAN_FIRE_RL_rl_put_mul_val ;

  // rule RL_rl_get_add_result
  assign CAN_FIRE_RL_rl_get_add_result = add_RDY_get_result && add_started ;
  assign WILL_FIRE_RL_rl_get_add_result = CAN_FIRE_RL_rl_get_add_result ;

  // rule RL_rl_deassert_signals
  assign CAN_FIRE_RL_rl_deassert_signals = mac_completed ;
  assign WILL_FIRE_RL_rl_deassert_signals = MUX_mul_done_write_1__SEL_1 ;

  // inputs to muxes for submodule ports
  assign MUX_mul_done_write_1__SEL_1 =
	     mac_completed && !WILL_FIRE_RL_rl_get_add_result ;
  assign MUX_mul_done_write_1__SEL_2 = mul_RDY_get_result && mul_started ;

  // register add_done
  assign add_done_D_IN = 1'b0 ;
  assign add_done_EN = 1'b0 ;

  // register add_started
  assign add_started_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign add_started_EN =
	     WILL_FIRE_RL_rl_deassert_signals || WILL_FIRE_RL_rl_put_add_val ;

  // register got_rg_a
  assign got_rg_a_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign got_rg_a_EN = WILL_FIRE_RL_rl_deassert_signals || EN_get_input_a ;

  // register got_rg_b
  assign got_rg_b_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign got_rg_b_EN = WILL_FIRE_RL_rl_deassert_signals || EN_get_input_b ;

  // register got_rg_c
  assign got_rg_c_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign got_rg_c_EN = WILL_FIRE_RL_rl_deassert_signals || EN_get_input_c ;

  // register got_rg_s
  assign got_rg_s_D_IN = 1'b0 ;
  assign got_rg_s_EN = 1'b0 ;

  // register mac_completed
  assign mac_completed_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign mac_completed_EN =
	     WILL_FIRE_RL_rl_deassert_signals ||
	     WILL_FIRE_RL_rl_get_add_result ;

  // register mul_done
  assign mul_done_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign mul_done_EN =
	     WILL_FIRE_RL_rl_deassert_signals || WILL_FIRE_RL_get_mul_result ;

  // register mul_started
  assign mul_started_D_IN = !WILL_FIRE_RL_rl_deassert_signals ;
  assign mul_started_EN =
	     WILL_FIRE_RL_rl_deassert_signals || WILL_FIRE_RL_rl_put_mul_val ;

  // register rg_a
  assign rg_a_D_IN = get_input_a_a ;
  assign rg_a_EN = EN_get_input_a ;

  // register rg_b
  assign rg_b_D_IN = get_input_b_b ;
  assign rg_b_EN = EN_get_input_b ;

  // register rg_c
  assign rg_c_D_IN = get_input_c_c ;
  assign rg_c_EN = EN_get_input_c ;

  // register rg_mac_result
  assign rg_mac_result_D_IN = add_get_result ;
  assign rg_mac_result_EN = CAN_FIRE_RL_rl_get_add_result ;

  // register rg_s
  assign rg_s_D_IN = mul_get_result ;
  assign rg_s_EN = MUX_mul_done_write_1__SEL_2 ;

  // submodule add
  assign add_get_inp_c_inp_C = rg_c ;
  assign add_get_inp_s_inp_S = { rg_s, 16'd0 } ;
  assign add_EN_get_inp_s = CAN_FIRE_RL_rl_put_add_val ;
  assign add_EN_get_inp_c = CAN_FIRE_RL_rl_put_add_val ;

  // submodule mul
  assign mul_get_inp_a_inp_A = rg_a ;
  assign mul_get_inp_b_inp_B = rg_b ;
  assign mul_EN_get_inp_a = CAN_FIRE_RL_rl_put_mul_val ;
  assign mul_EN_get_inp_b = CAN_FIRE_RL_rl_put_mul_val ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        add_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	add_started <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_rg_a <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_rg_b <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_rg_c <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_rg_s <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mac_completed <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mul_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mul_started <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_a <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_b <= `BSV_ASSIGNMENT_DELAY 16'd0;
	rg_c <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_mac_result <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_s <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (add_done_EN) add_done <= `BSV_ASSIGNMENT_DELAY add_done_D_IN;
	if (add_started_EN)
	  add_started <= `BSV_ASSIGNMENT_DELAY add_started_D_IN;
	if (got_rg_a_EN) got_rg_a <= `BSV_ASSIGNMENT_DELAY got_rg_a_D_IN;
	if (got_rg_b_EN) got_rg_b <= `BSV_ASSIGNMENT_DELAY got_rg_b_D_IN;
	if (got_rg_c_EN) got_rg_c <= `BSV_ASSIGNMENT_DELAY got_rg_c_D_IN;
	if (got_rg_s_EN) got_rg_s <= `BSV_ASSIGNMENT_DELAY got_rg_s_D_IN;
	if (mac_completed_EN)
	  mac_completed <= `BSV_ASSIGNMENT_DELAY mac_completed_D_IN;
	if (mul_done_EN) mul_done <= `BSV_ASSIGNMENT_DELAY mul_done_D_IN;
	if (mul_started_EN)
	  mul_started <= `BSV_ASSIGNMENT_DELAY mul_started_D_IN;
	if (rg_a_EN) rg_a <= `BSV_ASSIGNMENT_DELAY rg_a_D_IN;
	if (rg_b_EN) rg_b <= `BSV_ASSIGNMENT_DELAY rg_b_D_IN;
	if (rg_c_EN) rg_c <= `BSV_ASSIGNMENT_DELAY rg_c_D_IN;
	if (rg_mac_result_EN)
	  rg_mac_result <= `BSV_ASSIGNMENT_DELAY rg_mac_result_D_IN;
	if (rg_s_EN) rg_s <= `BSV_ASSIGNMENT_DELAY rg_s_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    add_done = 1'h0;
    add_started = 1'h0;
    got_rg_a = 1'h0;
    got_rg_b = 1'h0;
    got_rg_c = 1'h0;
    got_rg_s = 1'h0;
    mac_completed = 1'h0;
    mul_done = 1'h0;
    mul_started = 1'h0;
    rg_a = 16'hAAAA;
    rg_b = 16'hAAAA;
    rg_c = 32'hAAAAAAAA;
    rg_mac_result = 32'hAAAAAAAA;
    rg_s = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_put_add_val)
	begin
	  v__h764 = $stime;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_put_add_val)
	$display(v__h764, " C: %b S: %b", rg_c, rg_s);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_put_mul_val)
	begin
	  v__h593 = $stime;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_put_mul_val)
	$display(v__h593, " A: %b  B: %b", rg_a, rg_b);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_deassert_signals)
	begin
	  v__h922 = $stime;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_deassert_signals)
	$display(v__h922, " Everything Done!");
  end
  // synopsys translate_on
endmodule  // mkUnpipelined_float
