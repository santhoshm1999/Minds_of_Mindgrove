//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Tue Nov 26 12:43:59 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_mac_a                  O     1
// RDY_get_mac_b                  O     1
// RDY_get_mac_c                  O     1
// RDY_get_s1_or_s2               O     1 const
// get_end_res                    O    32 reg
// RDY_get_end_res                O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_mac_a_a                    I    16 reg
// get_mac_b_b                    I    16 reg
// get_mac_c_c                    I    32 reg
// get_s1_or_s2_s1_s2             I     1 reg
// EN_get_mac_a                   I     1
// EN_get_mac_b                   I     1
// EN_get_mac_c                   I     1
// EN_get_s1_or_s2                I     1
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

module mkMAC(CLK,
	     RST_N,

	     get_mac_a_a,
	     EN_get_mac_a,
	     RDY_get_mac_a,

	     get_mac_b_b,
	     EN_get_mac_b,
	     RDY_get_mac_b,

	     get_mac_c_c,
	     EN_get_mac_c,
	     RDY_get_mac_c,

	     get_s1_or_s2_s1_s2,
	     EN_get_s1_or_s2,
	     RDY_get_s1_or_s2,

	     get_end_res,
	     RDY_get_end_res);
  input  CLK;
  input  RST_N;

  // action method get_mac_a
  input  [15 : 0] get_mac_a_a;
  input  EN_get_mac_a;
  output RDY_get_mac_a;

  // action method get_mac_b
  input  [15 : 0] get_mac_b_b;
  input  EN_get_mac_b;
  output RDY_get_mac_b;

  // action method get_mac_c
  input  [31 : 0] get_mac_c_c;
  input  EN_get_mac_c;
  output RDY_get_mac_c;

  // action method get_s1_or_s2
  input  get_s1_or_s2_s1_s2;
  input  EN_get_s1_or_s2;
  output RDY_get_s1_or_s2;

  // value method get_end_res
  output [31 : 0] get_end_res;
  output RDY_get_end_res;

  // signals for module outputs
  wire [31 : 0] get_end_res;
  wire RDY_get_end_res,
       RDY_get_mac_a,
       RDY_get_mac_b,
       RDY_get_mac_c,
       RDY_get_s1_or_s2;

  // register counter
  reg [2 : 0] counter;
  wire [2 : 0] counter_D_IN;
  wire counter_EN;

  // register end_res
  reg [31 : 0] end_res;
  wire [31 : 0] end_res_D_IN;
  wire end_res_EN;

  // register end_res_done
  reg end_res_done;
  wire end_res_done_D_IN, end_res_done_EN;

  // register float_inp_done
  reg float_inp_done;
  wire float_inp_done_D_IN, float_inp_done_EN;

  // register got_a
  reg got_a;
  wire got_a_D_IN, got_a_EN;

  // register got_b
  reg got_b;
  wire got_b_D_IN, got_b_EN;

  // register got_c
  reg got_c;
  wire got_c_D_IN, got_c_EN;

  // register got_si
  reg got_si;
  wire got_si_D_IN, got_si_EN;

  // register int_inp_done
  reg int_inp_done;
  wire int_inp_done_D_IN, int_inp_done_EN;

  // register mac_a
  reg [15 : 0] mac_a;
  wire [15 : 0] mac_a_D_IN;
  wire mac_a_EN;

  // register mac_b
  reg [15 : 0] mac_b;
  wire [15 : 0] mac_b_D_IN;
  wire mac_b_EN;

  // register mac_c
  reg [31 : 0] mac_c;
  wire [31 : 0] mac_c_D_IN;
  wire mac_c_EN;

  // register s1_or_s2
  reg s1_or_s2;
  wire s1_or_s2_D_IN, s1_or_s2_EN;

  // ports of submodule float_mac
  wire [31 : 0] float_mac_get_MAC_result, float_mac_get_input_c_c;
  wire [15 : 0] float_mac_get_input_a_a, float_mac_get_input_b_b;
  wire float_mac_EN_get_input_a,
       float_mac_EN_get_input_b,
       float_mac_EN_get_input_c,
       float_mac_EN_get_input_s,
       float_mac_RDY_get_MAC_result,
       float_mac_RDY_get_input_a,
       float_mac_RDY_get_input_b,
       float_mac_RDY_get_input_c;

  // ports of submodule int_mac
  wire [31 : 0] int_mac_get_C_c, int_mac_get_output;
  wire [15 : 0] int_mac_get_A_a, int_mac_get_B_b;
  wire int_mac_EN_get_A,
       int_mac_EN_get_B,
       int_mac_EN_get_C,
       int_mac_RDY_get_output;

  // rule scheduling signals
  wire CAN_FIRE_RL_deassert_signal,
       CAN_FIRE_RL_rl_get_mac_float_res,
       CAN_FIRE_RL_rl_get_mac_int_res,
       CAN_FIRE_RL_rl_put_mac_val,
       CAN_FIRE_get_mac_a,
       CAN_FIRE_get_mac_b,
       CAN_FIRE_get_mac_c,
       CAN_FIRE_get_s1_or_s2,
       WILL_FIRE_RL_deassert_signal,
       WILL_FIRE_RL_rl_get_mac_float_res,
       WILL_FIRE_RL_rl_get_mac_int_res,
       WILL_FIRE_RL_rl_put_mac_val,
       WILL_FIRE_get_mac_a,
       WILL_FIRE_get_mac_b,
       WILL_FIRE_get_mac_c,
       WILL_FIRE_get_s1_or_s2;

  // inputs to muxes for submodule ports
  wire [2 : 0] MUX_counter_write_1__VAL_1;
  wire MUX_counter_write_1__SEL_1,
       MUX_counter_write_1__SEL_2,
       MUX_end_res_write_1__SEL_1,
       MUX_float_inp_done_write_1__SEL_1,
       MUX_got_a_write_1__SEL_1,
       MUX_int_inp_done_write_1__SEL_1;

  // declarations used by system tasks
  // synopsys translate_off
  reg [31 : 0] v__h946;
  reg [31 : 0] v__h1065;
  // synopsys translate_on

  // action method get_mac_a
  assign RDY_get_mac_a = !got_a ;
  assign CAN_FIRE_get_mac_a = !got_a ;
  assign WILL_FIRE_get_mac_a = EN_get_mac_a ;

  // action method get_mac_b
  assign RDY_get_mac_b = !got_b ;
  assign CAN_FIRE_get_mac_b = !got_b ;
  assign WILL_FIRE_get_mac_b = EN_get_mac_b ;

  // action method get_mac_c
  assign RDY_get_mac_c = !got_c ;
  assign CAN_FIRE_get_mac_c = !got_c ;
  assign WILL_FIRE_get_mac_c = EN_get_mac_c ;

  // action method get_s1_or_s2
  assign RDY_get_s1_or_s2 = 1'd1 ;
  assign CAN_FIRE_get_s1_or_s2 = 1'd1 ;
  assign WILL_FIRE_get_s1_or_s2 = EN_get_s1_or_s2 ;

  // value method get_end_res
  assign get_end_res = end_res ;
  assign RDY_get_end_res = end_res_done ;

  // submodule float_mac
  mkUnpipelined_float float_mac(.CLK(CLK),
				.RST_N(RST_N),
				.get_input_a_a(float_mac_get_input_a_a),
				.get_input_b_b(float_mac_get_input_b_b),
				.get_input_c_c(float_mac_get_input_c_c),
				.EN_get_input_a(float_mac_EN_get_input_a),
				.EN_get_input_b(float_mac_EN_get_input_b),
				.EN_get_input_s(float_mac_EN_get_input_s),
				.EN_get_input_c(float_mac_EN_get_input_c),
				.RDY_get_input_a(float_mac_RDY_get_input_a),
				.RDY_get_input_b(float_mac_RDY_get_input_b),
				.RDY_get_input_s(),
				.RDY_get_input_c(float_mac_RDY_get_input_c),
				.get_MAC_result(float_mac_get_MAC_result),
				.RDY_get_MAC_result(float_mac_RDY_get_MAC_result));

  // submodule int_mac
  mkintmul int_mac(.CLK(CLK),
		   .RST_N(RST_N),
		   .get_A_a(int_mac_get_A_a),
		   .get_B_b(int_mac_get_B_b),
		   .get_C_c(int_mac_get_C_c),
		   .EN_get_A(int_mac_EN_get_A),
		   .EN_get_B(int_mac_EN_get_B),
		   .EN_get_C(int_mac_EN_get_C),
		   .RDY_get_A(),
		   .RDY_get_B(),
		   .RDY_get_C(),
		   .get_output(int_mac_get_output),
		   .RDY_get_output(int_mac_RDY_get_output));

  // rule RL_rl_put_mac_val
  assign CAN_FIRE_RL_rl_put_mac_val = MUX_counter_write_1__SEL_2 ;
  assign WILL_FIRE_RL_rl_put_mac_val = MUX_counter_write_1__SEL_2 ;

  // rule RL_rl_get_mac_int_res
  assign CAN_FIRE_RL_rl_get_mac_int_res = MUX_counter_write_1__SEL_1 ;
  assign WILL_FIRE_RL_rl_get_mac_int_res = MUX_counter_write_1__SEL_1 ;

  // rule RL_rl_get_mac_float_res
  assign CAN_FIRE_RL_rl_get_mac_float_res =
	     float_mac_RDY_get_MAC_result && float_inp_done && !end_res_done ;
  assign WILL_FIRE_RL_rl_get_mac_float_res =
	     CAN_FIRE_RL_rl_get_mac_float_res &&
	     !WILL_FIRE_RL_rl_get_mac_int_res ;

  // rule RL_deassert_signal
  assign CAN_FIRE_RL_deassert_signal = MUX_got_a_write_1__SEL_1 ;
  assign WILL_FIRE_RL_deassert_signal = MUX_got_a_write_1__SEL_1 ;

  // inputs to muxes for submodule ports
  assign MUX_counter_write_1__SEL_1 =
	     int_mac_RDY_get_output && int_inp_done && !end_res_done &&
	     counter != 3'd0 ;
  assign MUX_counter_write_1__SEL_2 =
	     float_mac_RDY_get_input_c && float_mac_RDY_get_input_b &&
	     float_mac_RDY_get_input_a &&
	     got_si &&
	     got_a &&
	     got_b &&
	     got_c &&
	     !int_inp_done &&
	     !float_inp_done ;
  assign MUX_end_res_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1 ;
  assign MUX_float_inp_done_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_put_mac_val && s1_or_s2 ;
  assign MUX_got_a_write_1__SEL_1 =
	     (int_inp_done || float_inp_done) && end_res_done ;
  assign MUX_int_inp_done_write_1__SEL_1 =
	     WILL_FIRE_RL_rl_put_mac_val && !s1_or_s2 ;
  assign MUX_counter_write_1__VAL_1 = counter - 3'd1 ;

  // register counter
  assign counter_D_IN =
	     WILL_FIRE_RL_rl_get_mac_int_res ?
	       MUX_counter_write_1__VAL_1 :
	       3'd1 ;
  assign counter_EN =
	     WILL_FIRE_RL_rl_get_mac_int_res || WILL_FIRE_RL_rl_put_mac_val ;

  // register end_res
  assign end_res_D_IN =
	     MUX_end_res_write_1__SEL_1 ?
	       int_mac_get_output :
	       float_mac_get_MAC_result ;
  assign end_res_EN =
	     WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1 ||
	     WILL_FIRE_RL_rl_get_mac_float_res ;

  // register end_res_done
  assign end_res_done_D_IN = !WILL_FIRE_RL_deassert_signal ;
  assign end_res_done_EN =
	     WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1 ||
	     WILL_FIRE_RL_deassert_signal ||
	     WILL_FIRE_RL_rl_get_mac_float_res ;

  // register float_inp_done
  assign float_inp_done_D_IN = MUX_float_inp_done_write_1__SEL_1 ;
  assign float_inp_done_EN =
	     WILL_FIRE_RL_rl_put_mac_val && s1_or_s2 ||
	     WILL_FIRE_RL_deassert_signal ;

  // register got_a
  assign got_a_D_IN = !WILL_FIRE_RL_deassert_signal ;
  assign got_a_EN = WILL_FIRE_RL_deassert_signal || EN_get_mac_a ;

  // register got_b
  assign got_b_D_IN = !WILL_FIRE_RL_deassert_signal ;
  assign got_b_EN = WILL_FIRE_RL_deassert_signal || EN_get_mac_b ;

  // register got_c
  assign got_c_D_IN = !WILL_FIRE_RL_deassert_signal ;
  assign got_c_EN = WILL_FIRE_RL_deassert_signal || EN_get_mac_c ;

  // register got_si
  assign got_si_D_IN = !WILL_FIRE_RL_deassert_signal ;
  assign got_si_EN = WILL_FIRE_RL_deassert_signal || EN_get_s1_or_s2 ;

  // register int_inp_done
  assign int_inp_done_D_IN = MUX_int_inp_done_write_1__SEL_1 ;
  assign int_inp_done_EN =
	     WILL_FIRE_RL_rl_put_mac_val && !s1_or_s2 ||
	     WILL_FIRE_RL_deassert_signal ;

  // register mac_a
  assign mac_a_D_IN = get_mac_a_a ;
  assign mac_a_EN = EN_get_mac_a ;

  // register mac_b
  assign mac_b_D_IN = get_mac_b_b ;
  assign mac_b_EN = EN_get_mac_b ;

  // register mac_c
  assign mac_c_D_IN = get_mac_c_c ;
  assign mac_c_EN = EN_get_mac_c ;

  // register s1_or_s2
  assign s1_or_s2_D_IN = get_s1_or_s2_s1_s2 ;
  assign s1_or_s2_EN = EN_get_s1_or_s2 ;

  // submodule float_mac
  assign float_mac_get_input_a_a = mac_a ;
  assign float_mac_get_input_b_b = mac_b ;
  assign float_mac_get_input_c_c = mac_c ;
  assign float_mac_EN_get_input_a = MUX_float_inp_done_write_1__SEL_1 ;
  assign float_mac_EN_get_input_b = MUX_float_inp_done_write_1__SEL_1 ;
  assign float_mac_EN_get_input_s = 1'b0 ;
  assign float_mac_EN_get_input_c = MUX_float_inp_done_write_1__SEL_1 ;

  // submodule int_mac
  assign int_mac_get_A_a = mac_a ;
  assign int_mac_get_B_b = mac_b ;
  assign int_mac_get_C_c = mac_c ;
  assign int_mac_EN_get_A = MUX_int_inp_done_write_1__SEL_1 ;
  assign int_mac_EN_get_B = MUX_int_inp_done_write_1__SEL_1 ;
  assign int_mac_EN_get_C = MUX_int_inp_done_write_1__SEL_1 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        counter <= `BSV_ASSIGNMENT_DELAY 3'b0;
	end_res <= `BSV_ASSIGNMENT_DELAY 32'd0;
	end_res_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	float_inp_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_a <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_b <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_c <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_si <= `BSV_ASSIGNMENT_DELAY 1'd0;
	int_inp_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mac_a <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mac_b <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mac_c <= `BSV_ASSIGNMENT_DELAY 32'd0;
	s1_or_s2 <= `BSV_ASSIGNMENT_DELAY 1'b0;
      end
    else
      begin
        if (counter_EN) counter <= `BSV_ASSIGNMENT_DELAY counter_D_IN;
	if (end_res_EN) end_res <= `BSV_ASSIGNMENT_DELAY end_res_D_IN;
	if (end_res_done_EN)
	  end_res_done <= `BSV_ASSIGNMENT_DELAY end_res_done_D_IN;
	if (float_inp_done_EN)
	  float_inp_done <= `BSV_ASSIGNMENT_DELAY float_inp_done_D_IN;
	if (got_a_EN) got_a <= `BSV_ASSIGNMENT_DELAY got_a_D_IN;
	if (got_b_EN) got_b <= `BSV_ASSIGNMENT_DELAY got_b_D_IN;
	if (got_c_EN) got_c <= `BSV_ASSIGNMENT_DELAY got_c_D_IN;
	if (got_si_EN) got_si <= `BSV_ASSIGNMENT_DELAY got_si_D_IN;
	if (int_inp_done_EN)
	  int_inp_done <= `BSV_ASSIGNMENT_DELAY int_inp_done_D_IN;
	if (mac_a_EN) mac_a <= `BSV_ASSIGNMENT_DELAY mac_a_D_IN;
	if (mac_b_EN) mac_b <= `BSV_ASSIGNMENT_DELAY mac_b_D_IN;
	if (mac_c_EN) mac_c <= `BSV_ASSIGNMENT_DELAY mac_c_D_IN;
	if (s1_or_s2_EN) s1_or_s2 <= `BSV_ASSIGNMENT_DELAY s1_or_s2_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    counter = 3'h2;
    end_res = 32'hAAAAAAAA;
    end_res_done = 1'h0;
    float_inp_done = 1'h0;
    got_a = 1'h0;
    got_b = 1'h0;
    got_c = 1'h0;
    got_si = 1'h0;
    int_inp_done = 1'h0;
    mac_a = 16'hAAAA;
    mac_b = 16'hAAAA;
    mac_c = 32'hAAAAAAAA;
    s1_or_s2 = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1)
	begin
	  v__h946 = $stime;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1)
	$display(v__h946, " Access Integer before add");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1)
	begin
	  v__h1065 = $stime;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_get_mac_int_res && counter == 3'd1)
	$display(v__h1065, " Acccess Integer after add");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_deassert_signal)
	$display("result: inrt: emd_w,:, end_res");
  end
  // synopsys translate_on
endmodule  // mkMAC

