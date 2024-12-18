//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Tue Nov 26 12:43:46 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1 const
// RDY_get_B                      O     1 const
// RDY_get_C                      O     1 const
// get_output                     O    32 reg
// RDY_get_output                 O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16
// get_B_b                        I    16
// get_C_c                        I    32 reg
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_get_C                       I     1
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

module mkintmul(CLK,
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

		get_output,
		RDY_get_output);
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

  // value method get_output
  output [31 : 0] get_output;
  output RDY_get_output;

  // signals for module outputs
  wire [31 : 0] get_output;
  wire RDY_get_A, RDY_get_B, RDY_get_C, RDY_get_output;

  // register add_done
  reg add_done;
  wire add_done_D_IN, add_done_EN;

  // register add_out
  reg [31 : 0] add_out;
  wire [31 : 0] add_out_D_IN;
  wire add_out_EN;

  // register counter
  reg [4 : 0] counter;
  wire [4 : 0] counter_D_IN;
  wire counter_EN;

  // register finish
  reg finish;
  wire finish_D_IN, finish_EN;

  // register got_A
  reg got_A;
  wire got_A_D_IN, got_A_EN;

  // register got_B
  reg got_B;
  wire got_B_D_IN, got_B_EN;

  // register got_C
  reg got_C;
  wire got_C_D_IN, got_C_EN;

  // register got_result
  reg got_result;
  wire got_result_D_IN, got_result_EN;

  // register inpA
  reg [15 : 0] inpA;
  wire [15 : 0] inpA_D_IN;
  wire inpA_EN;

  // register inpB
  reg [15 : 0] inpB;
  wire [15 : 0] inpB_D_IN;
  wire inpB_EN;

  // register inpC
  reg [31 : 0] inpC;
  wire [31 : 0] inpC_D_IN;
  wire inpC_EN;

  // register mul_done
  reg mul_done;
  wire mul_done_D_IN, mul_done_EN;

  // register mul_out
  reg [31 : 0] mul_out;
  wire [31 : 0] mul_out_D_IN;
  wire mul_out_EN;

  // register prepmul
  reg prepmul;
  wire prepmul_D_IN, prepmul_EN;

  // register select
  reg select;
  wire select_D_IN, select_EN;

  // register temp
  reg [15 : 0] temp;
  wire [15 : 0] temp_D_IN;
  wire temp_EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_finished,
       CAN_FIRE_RL_rl_add,
       CAN_FIRE_RL_rl_done,
       CAN_FIRE_RL_rl_mul,
       CAN_FIRE_RL_rl_multiply,
       CAN_FIRE_get_A,
       CAN_FIRE_get_B,
       CAN_FIRE_get_C,
       WILL_FIRE_RL_finished,
       WILL_FIRE_RL_rl_add,
       WILL_FIRE_RL_rl_done,
       WILL_FIRE_RL_rl_mul,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_get_C;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_inpA_write_1__VAL_2,
		MUX_inpB_write_1__VAL_2,
		MUX_temp_write_1__VAL_1;
  wire [4 : 0] MUX_counter_write_1__VAL_2;
  wire MUX_temp_write_1__SEL_1;

  // remaining internal signals
  wire [29 : 0] mul_out_78_BIT_29_87_XOR_inpC_80_BIT_29_88_90__ETC___d512;
  wire [27 : 0] mul_out_78_BIT_27_95_XOR_inpC_80_BIT_27_96_98__ETC___d511;
  wire [25 : 0] mul_out_78_BIT_25_03_XOR_inpC_80_BIT_25_04_06__ETC___d510;
  wire [23 : 0] mul_out_78_BIT_23_11_XOR_inpC_80_BIT_23_12_14__ETC___d509;
  wire [21 : 0] mul_out_78_BIT_21_19_XOR_inpC_80_BIT_21_20_22__ETC___d508;
  wire [19 : 0] mul_out_78_BIT_19_27_XOR_inpC_80_BIT_19_28_30__ETC___d507;
  wire [17 : 0] mul_out_78_BIT_17_35_XOR_inpC_80_BIT_17_36_38__ETC___d506;
  wire [15 : 0] INV_inpA__q1,
		mul_out_78_BIT_15_43_XOR_inpC_80_BIT_15_44_46__ETC___d505,
		temp_5_BIT_15_6_XOR_INV_inpA_7_8_BIT_15_9_XOR__ETC___d161,
		temp_5_BIT_15_6_XOR_inpA_7_BIT_15_62_63_XOR_te_ETC___d259;
  wire [13 : 0] mul_out_78_BIT_13_51_XOR_inpC_80_BIT_13_52_54__ETC___d504,
		temp_5_BIT_13_5_XOR_INV_inpA_7_8_BIT_13_1_XOR__ETC___d160,
		temp_5_BIT_13_5_XOR_inpA_7_BIT_13_67_69_XOR_te_ETC___d258;
  wire [11 : 0] mul_out_78_BIT_11_59_XOR_inpC_80_BIT_11_60_62__ETC___d503,
		temp_5_BIT_11_3_XOR_INV_inpA_7_8_BIT_11_3_XOR__ETC___d159,
		temp_5_BIT_11_3_XOR_inpA_7_BIT_11_73_75_XOR_te_ETC___d257;
  wire [9 : 0] mul_out_78_BIT_9_67_XOR_inpC_80_BIT_9_68_70_XO_ETC___d502,
	       temp_5_BIT_9_1_XOR_INV_inpA_7_8_BIT_9_5_XOR_IN_ETC___d158,
	       temp_5_BIT_9_1_XOR_inpA_7_BIT_9_79_81_XOR_temp_ETC___d256;
  wire [7 : 0] mul_out_78_BIT_7_75_XOR_inpC_80_BIT_7_76_78_XO_ETC___d501,
	       temp_5_BIT_7_9_XOR_INV_inpA_7_8_BIT_7_7_XOR_IN_ETC___d157,
	       temp_5_BIT_7_9_XOR_inpA_7_BIT_7_85_87_XOR_temp_ETC___d255;
  wire [5 : 0] mul_out_78_BIT_5_83_XOR_inpC_80_BIT_5_84_86_XO_ETC___d500,
	       temp_5_BIT_5_7_XOR_INV_inpA_7_8_BIT_5_9_XOR_IN_ETC___d156,
	       temp_5_BIT_5_7_XOR_inpA_7_BIT_5_91_93_XOR_temp_ETC___d254;
  wire [3 : 0] mul_out_78_BIT_3_91_XOR_inpC_80_BIT_3_92_94_XO_ETC___d499,
	       temp_5_BIT_3_5_XOR_INV_inpA_7_8_BIT_3_1_XOR_IN_ETC___d155,
	       temp_5_BIT_3_5_XOR_inpA_7_BIT_3_97_99_XOR_temp_ETC___d253;
  wire x__h10280,
       x__h10341,
       x__h10446,
       x__h10551,
       x__h10656,
       x__h10761,
       x__h10866,
       x__h10971,
       x__h11076,
       x__h11181,
       x__h1121,
       x__h11286,
       x__h11391,
       x__h11496,
       x__h11601,
       x__h11706,
       x__h11811,
       x__h11916,
       x__h12021,
       x__h12126,
       x__h12231,
       x__h12336,
       x__h12441,
       x__h12546,
       x__h12651,
       x__h12756,
       x__h12861,
       x__h12966,
       x__h13071,
       x__h13176,
       x__h13281,
       x__h13386,
       x__h13531,
       x__h13588,
       x__h13645,
       x__h13702,
       x__h13759,
       x__h13816,
       x__h13873,
       x__h13930,
       x__h13987,
       x__h14044,
       x__h14101,
       x__h14158,
       x__h14215,
       x__h14272,
       x__h14329,
       x__h14386,
       x__h14443,
       x__h14500,
       x__h14557,
       x__h14614,
       x__h14671,
       x__h14728,
       x__h14785,
       x__h14842,
       x__h14899,
       x__h14956,
       x__h15013,
       x__h15070,
       x__h15127,
       x__h15184,
       x__h3983,
       x__h4029,
       x__h4086,
       x__h4132,
       x__h4189,
       x__h4235,
       x__h4292,
       x__h4338,
       x__h4395,
       x__h4441,
       x__h4498,
       x__h4544,
       x__h4601,
       x__h4647,
       x__h4704,
       x__h4750,
       x__h4807,
       x__h4853,
       x__h4910,
       x__h4956,
       x__h5013,
       x__h5059,
       x__h5116,
       x__h5162,
       x__h5219,
       x__h5265,
       x__h5322,
       x__h5368,
       x__h6751,
       x__h6810,
       x__h6915,
       x__h7020,
       x__h7125,
       x__h7230,
       x__h7335,
       x__h7440,
       x__h7545,
       x__h7650,
       x__h7755,
       x__h7860,
       x__h7965,
       x__h8070,
       x__h8175,
       x__h8320,
       x__h8377,
       x__h8434,
       x__h8491,
       x__h8548,
       x__h8605,
       x__h8662,
       x__h8719,
       x__h8776,
       x__h8833,
       x__h8890,
       x__h8947,
       x__h9004,
       x__h9061,
       y__h10281,
       y__h10342,
       y__h10447,
       y__h10552,
       y__h10657,
       y__h10762,
       y__h10867,
       y__h10972,
       y__h11077,
       y__h11182,
       y__h1122,
       y__h1124,
       y__h11287,
       y__h11392,
       y__h11497,
       y__h11602,
       y__h11707,
       y__h11812,
       y__h11917,
       y__h12022,
       y__h12127,
       y__h12232,
       y__h12337,
       y__h12442,
       y__h12547,
       y__h12652,
       y__h12757,
       y__h12862,
       y__h12967,
       y__h13072,
       y__h13177,
       y__h13282,
       y__h13387,
       y__h13532,
       y__h13589,
       y__h13646,
       y__h13703,
       y__h13760,
       y__h13817,
       y__h13874,
       y__h13931,
       y__h13988,
       y__h14045,
       y__h14102,
       y__h14159,
       y__h14216,
       y__h14273,
       y__h14330,
       y__h14387,
       y__h14444,
       y__h14501,
       y__h14558,
       y__h14615,
       y__h14672,
       y__h14729,
       y__h14786,
       y__h14843,
       y__h14900,
       y__h14957,
       y__h15014,
       y__h15071,
       y__h15128,
       y__h15185,
       y__h1601,
       y__h1707,
       y__h1810,
       y__h1913,
       y__h2016,
       y__h2119,
       y__h2222,
       y__h2325,
       y__h2428,
       y__h2531,
       y__h2634,
       y__h2737,
       y__h2840,
       y__h2943,
       y__h3984,
       y__h3986,
       y__h4030,
       y__h4087,
       y__h4089,
       y__h4133,
       y__h4190,
       y__h4192,
       y__h4236,
       y__h4293,
       y__h4295,
       y__h4339,
       y__h4396,
       y__h4398,
       y__h4442,
       y__h4499,
       y__h4501,
       y__h4545,
       y__h4602,
       y__h4604,
       y__h4648,
       y__h4705,
       y__h4707,
       y__h4751,
       y__h4808,
       y__h4810,
       y__h4854,
       y__h4911,
       y__h4913,
       y__h4957,
       y__h5014,
       y__h5016,
       y__h5060,
       y__h5117,
       y__h5119,
       y__h5163,
       y__h5220,
       y__h5222,
       y__h5266,
       y__h5323,
       y__h5325,
       y__h5369,
       y__h6752,
       y__h6811,
       y__h6916,
       y__h7021,
       y__h7126,
       y__h7231,
       y__h7336,
       y__h7441,
       y__h7546,
       y__h7651,
       y__h7756,
       y__h7861,
       y__h7966,
       y__h8071,
       y__h8176,
       y__h8321,
       y__h8378,
       y__h8435,
       y__h8492,
       y__h8549,
       y__h8606,
       y__h8663,
       y__h8720,
       y__h8777,
       y__h8834,
       y__h8891,
       y__h8948,
       y__h9005,
       y__h9062;

  // action method get_A
  assign RDY_get_A = 1'd1 ;
  assign CAN_FIRE_get_A = 1'd1 ;
  assign WILL_FIRE_get_A = EN_get_A ;

  // action method get_B
  assign RDY_get_B = 1'd1 ;
  assign CAN_FIRE_get_B = 1'd1 ;
  assign WILL_FIRE_get_B = EN_get_B ;

  // action method get_C
  assign RDY_get_C = 1'd1 ;
  assign CAN_FIRE_get_C = 1'd1 ;
  assign WILL_FIRE_get_C = EN_get_C ;

  // value method get_output
  assign get_output = add_out ;
  assign RDY_get_output = got_result ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply =
	     got_A && got_B && got_C && counter != 5'd0 && finish ;
  assign WILL_FIRE_RL_rl_multiply = CAN_FIRE_RL_rl_multiply ;

  // rule RL_rl_mul
  assign CAN_FIRE_RL_rl_mul =
	     !mul_done && counter == 5'd0 && !add_done && !got_result ;
  assign WILL_FIRE_RL_rl_mul = CAN_FIRE_RL_rl_mul ;

  // rule RL_rl_add
  assign CAN_FIRE_RL_rl_add = mul_done && !add_done && !got_result ;
  assign WILL_FIRE_RL_rl_add = CAN_FIRE_RL_rl_add ;

  // rule RL_rl_done
  assign CAN_FIRE_RL_rl_done = add_done && !got_result ;
  assign WILL_FIRE_RL_rl_done = CAN_FIRE_RL_rl_done ;

  // rule RL_finished
  assign CAN_FIRE_RL_finished = got_result ;
  assign WILL_FIRE_RL_finished = got_result ;

  // inputs to muxes for submodule ports
  assign MUX_temp_write_1__SEL_1 = WILL_FIRE_RL_rl_multiply && inpB[0] ;
  assign MUX_counter_write_1__VAL_2 = counter - 5'd1 ;
  assign MUX_inpA_write_1__VAL_2 = { inpA[14:0], 1'd0 } ;
  assign MUX_inpB_write_1__VAL_2 = { 1'd0, inpB[15:1] } ;
  assign MUX_temp_write_1__VAL_1 =
	     (counter == 5'd1) ?
	       temp_5_BIT_15_6_XOR_INV_inpA_7_8_BIT_15_9_XOR__ETC___d161 :
	       temp_5_BIT_15_6_XOR_inpA_7_BIT_15_62_63_XOR_te_ETC___d259 ;

  // register add_done
  assign add_done_D_IN = !WILL_FIRE_RL_rl_done ;
  assign add_done_EN = WILL_FIRE_RL_rl_done || WILL_FIRE_RL_rl_add ;

  // register add_out
  assign add_out_D_IN =
	     { x__h10280 ^ y__h10281,
	       x__h13531 ^ y__h13532,
	       mul_out_78_BIT_29_87_XOR_inpC_80_BIT_29_88_90__ETC___d512 } ;
  assign add_out_EN = CAN_FIRE_RL_rl_add ;

  // register counter
  assign counter_D_IN =
	     WILL_FIRE_RL_rl_done ? 5'd9 : MUX_counter_write_1__VAL_2 ;
  assign counter_EN = WILL_FIRE_RL_rl_multiply || WILL_FIRE_RL_rl_done ;

  // register finish
  assign finish_D_IN = !WILL_FIRE_RL_rl_mul ;
  assign finish_EN = WILL_FIRE_RL_rl_mul || got_result ;

  // register got_A
  assign got_A_D_IN = !got_result ;
  assign got_A_EN = got_result || EN_get_A ;

  // register got_B
  assign got_B_D_IN = !got_result ;
  assign got_B_EN = got_result || EN_get_B ;

  // register got_C
  assign got_C_D_IN = !got_result ;
  assign got_C_EN = got_result || EN_get_C ;

  // register got_result
  assign got_result_D_IN = !got_result ;
  assign got_result_EN = got_result || WILL_FIRE_RL_rl_done ;

  // register inpA
  assign inpA_D_IN = EN_get_A ? get_A_a : MUX_inpA_write_1__VAL_2 ;
  assign inpA_EN = EN_get_A || WILL_FIRE_RL_rl_multiply ;

  // register inpB
  assign inpB_D_IN = EN_get_B ? get_B_b : MUX_inpB_write_1__VAL_2 ;
  assign inpB_EN = EN_get_B || WILL_FIRE_RL_rl_multiply ;

  // register inpC
  assign inpC_D_IN = get_C_c ;
  assign inpC_EN = EN_get_C ;

  // register mul_done
  assign mul_done_D_IN = !got_result ;
  assign mul_done_EN = got_result || WILL_FIRE_RL_rl_mul ;

  // register mul_out
  assign mul_out_D_IN = { {16{temp[15]}}, temp } ;
  assign mul_out_EN = CAN_FIRE_RL_rl_mul ;

  // register prepmul
  assign prepmul_D_IN = 1'b0 ;
  assign prepmul_EN = 1'b0 ;

  // register select
  assign select_D_IN = 1'b0 ;
  assign select_EN = 1'b0 ;

  // register temp
  assign temp_D_IN =
	     MUX_temp_write_1__SEL_1 ? MUX_temp_write_1__VAL_1 : 16'd0 ;
  assign temp_EN =
	     WILL_FIRE_RL_rl_multiply && inpB[0] || WILL_FIRE_RL_rl_mul ;

  // remaining internal signals
  assign INV_inpA__q1 = ~inpA ;
  assign mul_out_78_BIT_11_59_XOR_inpC_80_BIT_11_60_62__ETC___d503 =
	     { x__h14614 ^ y__h14615,
	       x__h14671 ^ y__h14672,
	       mul_out_78_BIT_9_67_XOR_inpC_80_BIT_9_68_70_XO_ETC___d502 } ;
  assign mul_out_78_BIT_13_51_XOR_inpC_80_BIT_13_52_54__ETC___d504 =
	     { x__h14500 ^ y__h14501,
	       x__h14557 ^ y__h14558,
	       mul_out_78_BIT_11_59_XOR_inpC_80_BIT_11_60_62__ETC___d503 } ;
  assign mul_out_78_BIT_15_43_XOR_inpC_80_BIT_15_44_46__ETC___d505 =
	     { x__h14386 ^ y__h14387,
	       x__h14443 ^ y__h14444,
	       mul_out_78_BIT_13_51_XOR_inpC_80_BIT_13_52_54__ETC___d504 } ;
  assign mul_out_78_BIT_17_35_XOR_inpC_80_BIT_17_36_38__ETC___d506 =
	     { x__h14272 ^ y__h14273,
	       x__h14329 ^ y__h14330,
	       mul_out_78_BIT_15_43_XOR_inpC_80_BIT_15_44_46__ETC___d505 } ;
  assign mul_out_78_BIT_19_27_XOR_inpC_80_BIT_19_28_30__ETC___d507 =
	     { x__h14158 ^ y__h14159,
	       x__h14215 ^ y__h14216,
	       mul_out_78_BIT_17_35_XOR_inpC_80_BIT_17_36_38__ETC___d506 } ;
  assign mul_out_78_BIT_21_19_XOR_inpC_80_BIT_21_20_22__ETC___d508 =
	     { x__h14044 ^ y__h14045,
	       x__h14101 ^ y__h14102,
	       mul_out_78_BIT_19_27_XOR_inpC_80_BIT_19_28_30__ETC___d507 } ;
  assign mul_out_78_BIT_23_11_XOR_inpC_80_BIT_23_12_14__ETC___d509 =
	     { x__h13930 ^ y__h13931,
	       x__h13987 ^ y__h13988,
	       mul_out_78_BIT_21_19_XOR_inpC_80_BIT_21_20_22__ETC___d508 } ;
  assign mul_out_78_BIT_25_03_XOR_inpC_80_BIT_25_04_06__ETC___d510 =
	     { x__h13816 ^ y__h13817,
	       x__h13873 ^ y__h13874,
	       mul_out_78_BIT_23_11_XOR_inpC_80_BIT_23_12_14__ETC___d509 } ;
  assign mul_out_78_BIT_27_95_XOR_inpC_80_BIT_27_96_98__ETC___d511 =
	     { x__h13702 ^ y__h13703,
	       x__h13759 ^ y__h13760,
	       mul_out_78_BIT_25_03_XOR_inpC_80_BIT_25_04_06__ETC___d510 } ;
  assign mul_out_78_BIT_29_87_XOR_inpC_80_BIT_29_88_90__ETC___d512 =
	     { x__h13588 ^ y__h13589,
	       x__h13645 ^ y__h13646,
	       mul_out_78_BIT_27_95_XOR_inpC_80_BIT_27_96_98__ETC___d511 } ;
  assign mul_out_78_BIT_3_91_XOR_inpC_80_BIT_3_92_94_XO_ETC___d499 =
	     { x__h15070 ^ y__h15071,
	       x__h15127 ^ y__h15128,
	       x__h15184 ^ y__h15185,
	       mul_out[0] ^ inpC[0] } ;
  assign mul_out_78_BIT_5_83_XOR_inpC_80_BIT_5_84_86_XO_ETC___d500 =
	     { x__h14956 ^ y__h14957,
	       x__h15013 ^ y__h15014,
	       mul_out_78_BIT_3_91_XOR_inpC_80_BIT_3_92_94_XO_ETC___d499 } ;
  assign mul_out_78_BIT_7_75_XOR_inpC_80_BIT_7_76_78_XO_ETC___d501 =
	     { x__h14842 ^ y__h14843,
	       x__h14899 ^ y__h14900,
	       mul_out_78_BIT_5_83_XOR_inpC_80_BIT_5_84_86_XO_ETC___d500 } ;
  assign mul_out_78_BIT_9_67_XOR_inpC_80_BIT_9_68_70_XO_ETC___d502 =
	     { x__h14728 ^ y__h14729,
	       x__h14785 ^ y__h14786,
	       mul_out_78_BIT_7_75_XOR_inpC_80_BIT_7_76_78_XO_ETC___d501 } ;
  assign temp_5_BIT_11_3_XOR_INV_inpA_7_8_BIT_11_3_XOR__ETC___d159 =
	     { x__h4338 ^ y__h4339,
	       x__h4441 ^ y__h4442,
	       temp_5_BIT_9_1_XOR_INV_inpA_7_8_BIT_9_5_XOR_IN_ETC___d158 } ;
  assign temp_5_BIT_11_3_XOR_inpA_7_BIT_11_73_75_XOR_te_ETC___d257 =
	     { x__h8491 ^ y__h8492,
	       x__h8548 ^ y__h8549,
	       temp_5_BIT_9_1_XOR_inpA_7_BIT_9_79_81_XOR_temp_ETC___d256 } ;
  assign temp_5_BIT_13_5_XOR_INV_inpA_7_8_BIT_13_1_XOR__ETC___d160 =
	     { x__h4132 ^ y__h4133,
	       x__h4235 ^ y__h4236,
	       temp_5_BIT_11_3_XOR_INV_inpA_7_8_BIT_11_3_XOR__ETC___d159 } ;
  assign temp_5_BIT_13_5_XOR_inpA_7_BIT_13_67_69_XOR_te_ETC___d258 =
	     { x__h8377 ^ y__h8378,
	       x__h8434 ^ y__h8435,
	       temp_5_BIT_11_3_XOR_inpA_7_BIT_11_73_75_XOR_te_ETC___d257 } ;
  assign temp_5_BIT_15_6_XOR_INV_inpA_7_8_BIT_15_9_XOR__ETC___d161 =
	     { x__h1121 ^ y__h1122,
	       x__h4029 ^ y__h4030,
	       temp_5_BIT_13_5_XOR_INV_inpA_7_8_BIT_13_1_XOR__ETC___d160 } ;
  assign temp_5_BIT_15_6_XOR_inpA_7_BIT_15_62_63_XOR_te_ETC___d259 =
	     { x__h6751 ^ y__h6752,
	       x__h8320 ^ y__h8321,
	       temp_5_BIT_13_5_XOR_inpA_7_BIT_13_67_69_XOR_te_ETC___d258 } ;
  assign temp_5_BIT_3_5_XOR_INV_inpA_7_8_BIT_3_1_XOR_IN_ETC___d155 =
	     { x__h5162 ^ y__h5163,
	       x__h5265 ^ y__h5266,
	       x__h5368 ^ y__h5369,
	       temp[0] ^ ~INV_inpA__q1[0] } ;
  assign temp_5_BIT_3_5_XOR_inpA_7_BIT_3_97_99_XOR_temp_ETC___d253 =
	     { x__h8947 ^ y__h8948,
	       x__h9004 ^ y__h9005,
	       x__h9061 ^ y__h9062,
	       temp[0] ^ inpA[0] } ;
  assign temp_5_BIT_5_7_XOR_INV_inpA_7_8_BIT_5_9_XOR_IN_ETC___d156 =
	     { x__h4956 ^ y__h4957,
	       x__h5059 ^ y__h5060,
	       temp_5_BIT_3_5_XOR_INV_inpA_7_8_BIT_3_1_XOR_IN_ETC___d155 } ;
  assign temp_5_BIT_5_7_XOR_inpA_7_BIT_5_91_93_XOR_temp_ETC___d254 =
	     { x__h8833 ^ y__h8834,
	       x__h8890 ^ y__h8891,
	       temp_5_BIT_3_5_XOR_inpA_7_BIT_3_97_99_XOR_temp_ETC___d253 } ;
  assign temp_5_BIT_7_9_XOR_INV_inpA_7_8_BIT_7_7_XOR_IN_ETC___d157 =
	     { x__h4750 ^ y__h4751,
	       x__h4853 ^ y__h4854,
	       temp_5_BIT_5_7_XOR_INV_inpA_7_8_BIT_5_9_XOR_IN_ETC___d156 } ;
  assign temp_5_BIT_7_9_XOR_inpA_7_BIT_7_85_87_XOR_temp_ETC___d255 =
	     { x__h8719 ^ y__h8720,
	       x__h8776 ^ y__h8777,
	       temp_5_BIT_5_7_XOR_inpA_7_BIT_5_91_93_XOR_temp_ETC___d254 } ;
  assign temp_5_BIT_9_1_XOR_INV_inpA_7_8_BIT_9_5_XOR_IN_ETC___d158 =
	     { x__h4544 ^ y__h4545,
	       x__h4647 ^ y__h4648,
	       temp_5_BIT_7_9_XOR_INV_inpA_7_8_BIT_7_7_XOR_IN_ETC___d157 } ;
  assign temp_5_BIT_9_1_XOR_inpA_7_BIT_9_79_81_XOR_temp_ETC___d256 =
	     { x__h8605 ^ y__h8606,
	       x__h8662 ^ y__h8663,
	       temp_5_BIT_7_9_XOR_inpA_7_BIT_7_85_87_XOR_temp_ETC___d255 } ;
  assign x__h10280 = mul_out[31] ^ inpC[31] ;
  assign x__h10341 = mul_out[30] & inpC[30] ;
  assign x__h10446 = mul_out[29] & inpC[29] ;
  assign x__h10551 = mul_out[28] & inpC[28] ;
  assign x__h10656 = mul_out[27] & inpC[27] ;
  assign x__h10761 = mul_out[26] & inpC[26] ;
  assign x__h10866 = mul_out[25] & inpC[25] ;
  assign x__h10971 = mul_out[24] & inpC[24] ;
  assign x__h11076 = mul_out[23] & inpC[23] ;
  assign x__h11181 = mul_out[22] & inpC[22] ;
  assign x__h1121 = temp[15] ^ y__h1124 ;
  assign x__h11286 = mul_out[21] & inpC[21] ;
  assign x__h11391 = mul_out[20] & inpC[20] ;
  assign x__h11496 = mul_out[19] & inpC[19] ;
  assign x__h11601 = mul_out[18] & inpC[18] ;
  assign x__h11706 = mul_out[17] & inpC[17] ;
  assign x__h11811 = mul_out[16] & inpC[16] ;
  assign x__h11916 = mul_out[15] & inpC[15] ;
  assign x__h12021 = mul_out[14] & inpC[14] ;
  assign x__h12126 = mul_out[13] & inpC[13] ;
  assign x__h12231 = mul_out[12] & inpC[12] ;
  assign x__h12336 = mul_out[11] & inpC[11] ;
  assign x__h12441 = mul_out[10] & inpC[10] ;
  assign x__h12546 = mul_out[9] & inpC[9] ;
  assign x__h12651 = mul_out[8] & inpC[8] ;
  assign x__h12756 = mul_out[7] & inpC[7] ;
  assign x__h12861 = mul_out[6] & inpC[6] ;
  assign x__h12966 = mul_out[5] & inpC[5] ;
  assign x__h13071 = mul_out[4] & inpC[4] ;
  assign x__h13176 = mul_out[3] & inpC[3] ;
  assign x__h13281 = mul_out[2] & inpC[2] ;
  assign x__h13386 = mul_out[1] & inpC[1] ;
  assign x__h13531 = mul_out[30] ^ inpC[30] ;
  assign x__h13588 = mul_out[29] ^ inpC[29] ;
  assign x__h13645 = mul_out[28] ^ inpC[28] ;
  assign x__h13702 = mul_out[27] ^ inpC[27] ;
  assign x__h13759 = mul_out[26] ^ inpC[26] ;
  assign x__h13816 = mul_out[25] ^ inpC[25] ;
  assign x__h13873 = mul_out[24] ^ inpC[24] ;
  assign x__h13930 = mul_out[23] ^ inpC[23] ;
  assign x__h13987 = mul_out[22] ^ inpC[22] ;
  assign x__h14044 = mul_out[21] ^ inpC[21] ;
  assign x__h14101 = mul_out[20] ^ inpC[20] ;
  assign x__h14158 = mul_out[19] ^ inpC[19] ;
  assign x__h14215 = mul_out[18] ^ inpC[18] ;
  assign x__h14272 = mul_out[17] ^ inpC[17] ;
  assign x__h14329 = mul_out[16] ^ inpC[16] ;
  assign x__h14386 = mul_out[15] ^ inpC[15] ;
  assign x__h14443 = mul_out[14] ^ inpC[14] ;
  assign x__h14500 = mul_out[13] ^ inpC[13] ;
  assign x__h14557 = mul_out[12] ^ inpC[12] ;
  assign x__h14614 = mul_out[11] ^ inpC[11] ;
  assign x__h14671 = mul_out[10] ^ inpC[10] ;
  assign x__h14728 = mul_out[9] ^ inpC[9] ;
  assign x__h14785 = mul_out[8] ^ inpC[8] ;
  assign x__h14842 = mul_out[7] ^ inpC[7] ;
  assign x__h14899 = mul_out[6] ^ inpC[6] ;
  assign x__h14956 = mul_out[5] ^ inpC[5] ;
  assign x__h15013 = mul_out[4] ^ inpC[4] ;
  assign x__h15070 = mul_out[3] ^ inpC[3] ;
  assign x__h15127 = mul_out[2] ^ inpC[2] ;
  assign x__h15184 = mul_out[1] ^ inpC[1] ;
  assign x__h3983 = temp[14] & y__h3986 ;
  assign x__h4029 = temp[14] ^ y__h3986 ;
  assign x__h4086 = temp[13] & y__h4089 ;
  assign x__h4132 = temp[13] ^ y__h4089 ;
  assign x__h4189 = temp[12] & y__h4192 ;
  assign x__h4235 = temp[12] ^ y__h4192 ;
  assign x__h4292 = temp[11] & y__h4295 ;
  assign x__h4338 = temp[11] ^ y__h4295 ;
  assign x__h4395 = temp[10] & y__h4398 ;
  assign x__h4441 = temp[10] ^ y__h4398 ;
  assign x__h4498 = temp[9] & y__h4501 ;
  assign x__h4544 = temp[9] ^ y__h4501 ;
  assign x__h4601 = temp[8] & y__h4604 ;
  assign x__h4647 = temp[8] ^ y__h4604 ;
  assign x__h4704 = temp[7] & y__h4707 ;
  assign x__h4750 = temp[7] ^ y__h4707 ;
  assign x__h4807 = temp[6] & y__h4810 ;
  assign x__h4853 = temp[6] ^ y__h4810 ;
  assign x__h4910 = temp[5] & y__h4913 ;
  assign x__h4956 = temp[5] ^ y__h4913 ;
  assign x__h5013 = temp[4] & y__h5016 ;
  assign x__h5059 = temp[4] ^ y__h5016 ;
  assign x__h5116 = temp[3] & y__h5119 ;
  assign x__h5162 = temp[3] ^ y__h5119 ;
  assign x__h5219 = temp[2] & y__h5222 ;
  assign x__h5265 = temp[2] ^ y__h5222 ;
  assign x__h5322 = temp[1] & y__h5325 ;
  assign x__h5368 = temp[1] ^ y__h5325 ;
  assign x__h6751 = temp[15] ^ inpA[15] ;
  assign x__h6810 = temp[14] & inpA[14] ;
  assign x__h6915 = temp[13] & inpA[13] ;
  assign x__h7020 = temp[12] & inpA[12] ;
  assign x__h7125 = temp[11] & inpA[11] ;
  assign x__h7230 = temp[10] & inpA[10] ;
  assign x__h7335 = temp[9] & inpA[9] ;
  assign x__h7440 = temp[8] & inpA[8] ;
  assign x__h7545 = temp[7] & inpA[7] ;
  assign x__h7650 = temp[6] & inpA[6] ;
  assign x__h7755 = temp[5] & inpA[5] ;
  assign x__h7860 = temp[4] & inpA[4] ;
  assign x__h7965 = temp[3] & inpA[3] ;
  assign x__h8070 = temp[2] & inpA[2] ;
  assign x__h8175 = temp[1] & inpA[1] ;
  assign x__h8320 = temp[14] ^ inpA[14] ;
  assign x__h8377 = temp[13] ^ inpA[13] ;
  assign x__h8434 = temp[12] ^ inpA[12] ;
  assign x__h8491 = temp[11] ^ inpA[11] ;
  assign x__h8548 = temp[10] ^ inpA[10] ;
  assign x__h8605 = temp[9] ^ inpA[9] ;
  assign x__h8662 = temp[8] ^ inpA[8] ;
  assign x__h8719 = temp[7] ^ inpA[7] ;
  assign x__h8776 = temp[6] ^ inpA[6] ;
  assign x__h8833 = temp[5] ^ inpA[5] ;
  assign x__h8890 = temp[4] ^ inpA[4] ;
  assign x__h8947 = temp[3] ^ inpA[3] ;
  assign x__h9004 = temp[2] ^ inpA[2] ;
  assign x__h9061 = temp[1] ^ inpA[1] ;
  assign y__h10281 = x__h10341 | y__h10342 ;
  assign y__h10342 = x__h13531 & y__h13532 ;
  assign y__h10447 = x__h13588 & y__h13589 ;
  assign y__h10552 = x__h13645 & y__h13646 ;
  assign y__h10657 = x__h13702 & y__h13703 ;
  assign y__h10762 = x__h13759 & y__h13760 ;
  assign y__h10867 = x__h13816 & y__h13817 ;
  assign y__h10972 = x__h13873 & y__h13874 ;
  assign y__h11077 = x__h13930 & y__h13931 ;
  assign y__h11182 = x__h13987 & y__h13988 ;
  assign y__h1122 = x__h3983 | y__h3984 ;
  assign y__h1124 = INV_inpA__q1[15] ^ y__h1601 ;
  assign y__h11287 = x__h14044 & y__h14045 ;
  assign y__h11392 = x__h14101 & y__h14102 ;
  assign y__h11497 = x__h14158 & y__h14159 ;
  assign y__h11602 = x__h14215 & y__h14216 ;
  assign y__h11707 = x__h14272 & y__h14273 ;
  assign y__h11812 = x__h14329 & y__h14330 ;
  assign y__h11917 = x__h14386 & y__h14387 ;
  assign y__h12022 = x__h14443 & y__h14444 ;
  assign y__h12127 = x__h14500 & y__h14501 ;
  assign y__h12232 = x__h14557 & y__h14558 ;
  assign y__h12337 = x__h14614 & y__h14615 ;
  assign y__h12442 = x__h14671 & y__h14672 ;
  assign y__h12547 = x__h14728 & y__h14729 ;
  assign y__h12652 = x__h14785 & y__h14786 ;
  assign y__h12757 = x__h14842 & y__h14843 ;
  assign y__h12862 = x__h14899 & y__h14900 ;
  assign y__h12967 = x__h14956 & y__h14957 ;
  assign y__h13072 = x__h15013 & y__h15014 ;
  assign y__h13177 = x__h15070 & y__h15071 ;
  assign y__h13282 = x__h15127 & y__h15128 ;
  assign y__h13387 = x__h15184 & y__h15185 ;
  assign y__h13532 = x__h10446 | y__h10447 ;
  assign y__h13589 = x__h10551 | y__h10552 ;
  assign y__h13646 = x__h10656 | y__h10657 ;
  assign y__h13703 = x__h10761 | y__h10762 ;
  assign y__h13760 = x__h10866 | y__h10867 ;
  assign y__h13817 = x__h10971 | y__h10972 ;
  assign y__h13874 = x__h11076 | y__h11077 ;
  assign y__h13931 = x__h11181 | y__h11182 ;
  assign y__h13988 = x__h11286 | y__h11287 ;
  assign y__h14045 = x__h11391 | y__h11392 ;
  assign y__h14102 = x__h11496 | y__h11497 ;
  assign y__h14159 = x__h11601 | y__h11602 ;
  assign y__h14216 = x__h11706 | y__h11707 ;
  assign y__h14273 = x__h11811 | y__h11812 ;
  assign y__h14330 = x__h11916 | y__h11917 ;
  assign y__h14387 = x__h12021 | y__h12022 ;
  assign y__h14444 = x__h12126 | y__h12127 ;
  assign y__h14501 = x__h12231 | y__h12232 ;
  assign y__h14558 = x__h12336 | y__h12337 ;
  assign y__h14615 = x__h12441 | y__h12442 ;
  assign y__h14672 = x__h12546 | y__h12547 ;
  assign y__h14729 = x__h12651 | y__h12652 ;
  assign y__h14786 = x__h12756 | y__h12757 ;
  assign y__h14843 = x__h12861 | y__h12862 ;
  assign y__h14900 = x__h12966 | y__h12967 ;
  assign y__h14957 = x__h13071 | y__h13072 ;
  assign y__h15014 = x__h13176 | y__h13177 ;
  assign y__h15071 = x__h13281 | y__h13282 ;
  assign y__h15128 = x__h13386 | y__h13387 ;
  assign y__h15185 = mul_out[0] & inpC[0] ;
  assign y__h1601 = INV_inpA__q1[14] & y__h1707 ;
  assign y__h1707 = INV_inpA__q1[13] & y__h1810 ;
  assign y__h1810 = INV_inpA__q1[12] & y__h1913 ;
  assign y__h1913 = INV_inpA__q1[11] & y__h2016 ;
  assign y__h2016 = INV_inpA__q1[10] & y__h2119 ;
  assign y__h2119 = INV_inpA__q1[9] & y__h2222 ;
  assign y__h2222 = INV_inpA__q1[8] & y__h2325 ;
  assign y__h2325 = INV_inpA__q1[7] & y__h2428 ;
  assign y__h2428 = INV_inpA__q1[6] & y__h2531 ;
  assign y__h2531 = INV_inpA__q1[5] & y__h2634 ;
  assign y__h2634 = INV_inpA__q1[4] & y__h2737 ;
  assign y__h2737 = INV_inpA__q1[3] & y__h2840 ;
  assign y__h2840 = INV_inpA__q1[2] & y__h2943 ;
  assign y__h2943 = INV_inpA__q1[1] & INV_inpA__q1[0] ;
  assign y__h3984 = x__h4029 & y__h4030 ;
  assign y__h3986 = INV_inpA__q1[14] ^ y__h1707 ;
  assign y__h4030 = x__h4086 | y__h4087 ;
  assign y__h4087 = x__h4132 & y__h4133 ;
  assign y__h4089 = INV_inpA__q1[13] ^ y__h1810 ;
  assign y__h4133 = x__h4189 | y__h4190 ;
  assign y__h4190 = x__h4235 & y__h4236 ;
  assign y__h4192 = INV_inpA__q1[12] ^ y__h1913 ;
  assign y__h4236 = x__h4292 | y__h4293 ;
  assign y__h4293 = x__h4338 & y__h4339 ;
  assign y__h4295 = INV_inpA__q1[11] ^ y__h2016 ;
  assign y__h4339 = x__h4395 | y__h4396 ;
  assign y__h4396 = x__h4441 & y__h4442 ;
  assign y__h4398 = INV_inpA__q1[10] ^ y__h2119 ;
  assign y__h4442 = x__h4498 | y__h4499 ;
  assign y__h4499 = x__h4544 & y__h4545 ;
  assign y__h4501 = INV_inpA__q1[9] ^ y__h2222 ;
  assign y__h4545 = x__h4601 | y__h4602 ;
  assign y__h4602 = x__h4647 & y__h4648 ;
  assign y__h4604 = INV_inpA__q1[8] ^ y__h2325 ;
  assign y__h4648 = x__h4704 | y__h4705 ;
  assign y__h4705 = x__h4750 & y__h4751 ;
  assign y__h4707 = INV_inpA__q1[7] ^ y__h2428 ;
  assign y__h4751 = x__h4807 | y__h4808 ;
  assign y__h4808 = x__h4853 & y__h4854 ;
  assign y__h4810 = INV_inpA__q1[6] ^ y__h2531 ;
  assign y__h4854 = x__h4910 | y__h4911 ;
  assign y__h4911 = x__h4956 & y__h4957 ;
  assign y__h4913 = INV_inpA__q1[5] ^ y__h2634 ;
  assign y__h4957 = x__h5013 | y__h5014 ;
  assign y__h5014 = x__h5059 & y__h5060 ;
  assign y__h5016 = INV_inpA__q1[4] ^ y__h2737 ;
  assign y__h5060 = x__h5116 | y__h5117 ;
  assign y__h5117 = x__h5162 & y__h5163 ;
  assign y__h5119 = INV_inpA__q1[3] ^ y__h2840 ;
  assign y__h5163 = x__h5219 | y__h5220 ;
  assign y__h5220 = x__h5265 & y__h5266 ;
  assign y__h5222 = INV_inpA__q1[2] ^ y__h2943 ;
  assign y__h5266 = x__h5322 | y__h5323 ;
  assign y__h5323 = x__h5368 & y__h5369 ;
  assign y__h5325 = INV_inpA__q1[1] ^ INV_inpA__q1[0] ;
  assign y__h5369 = temp[0] & ~INV_inpA__q1[0] ;
  assign y__h6752 = x__h6810 | y__h6811 ;
  assign y__h6811 = x__h8320 & y__h8321 ;
  assign y__h6916 = x__h8377 & y__h8378 ;
  assign y__h7021 = x__h8434 & y__h8435 ;
  assign y__h7126 = x__h8491 & y__h8492 ;
  assign y__h7231 = x__h8548 & y__h8549 ;
  assign y__h7336 = x__h8605 & y__h8606 ;
  assign y__h7441 = x__h8662 & y__h8663 ;
  assign y__h7546 = x__h8719 & y__h8720 ;
  assign y__h7651 = x__h8776 & y__h8777 ;
  assign y__h7756 = x__h8833 & y__h8834 ;
  assign y__h7861 = x__h8890 & y__h8891 ;
  assign y__h7966 = x__h8947 & y__h8948 ;
  assign y__h8071 = x__h9004 & y__h9005 ;
  assign y__h8176 = x__h9061 & y__h9062 ;
  assign y__h8321 = x__h6915 | y__h6916 ;
  assign y__h8378 = x__h7020 | y__h7021 ;
  assign y__h8435 = x__h7125 | y__h7126 ;
  assign y__h8492 = x__h7230 | y__h7231 ;
  assign y__h8549 = x__h7335 | y__h7336 ;
  assign y__h8606 = x__h7440 | y__h7441 ;
  assign y__h8663 = x__h7545 | y__h7546 ;
  assign y__h8720 = x__h7650 | y__h7651 ;
  assign y__h8777 = x__h7755 | y__h7756 ;
  assign y__h8834 = x__h7860 | y__h7861 ;
  assign y__h8891 = x__h7965 | y__h7966 ;
  assign y__h8948 = x__h8070 | y__h8071 ;
  assign y__h9005 = x__h8175 | y__h8176 ;
  assign y__h9062 = temp[0] & inpA[0] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        add_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	add_out <= `BSV_ASSIGNMENT_DELAY 32'd0;
	counter <= `BSV_ASSIGNMENT_DELAY 5'd9;
	finish <= `BSV_ASSIGNMENT_DELAY 1'd1;
	got_A <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_B <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_C <= `BSV_ASSIGNMENT_DELAY 1'd0;
	got_result <= `BSV_ASSIGNMENT_DELAY 1'd0;
	inpA <= `BSV_ASSIGNMENT_DELAY 16'd0;
	inpB <= `BSV_ASSIGNMENT_DELAY 16'd0;
	inpC <= `BSV_ASSIGNMENT_DELAY 32'd0;
	mul_done <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mul_out <= `BSV_ASSIGNMENT_DELAY 32'd0;
	prepmul <= `BSV_ASSIGNMENT_DELAY 1'd0;
	select <= `BSV_ASSIGNMENT_DELAY 1'd0;
	temp <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (add_done_EN) add_done <= `BSV_ASSIGNMENT_DELAY add_done_D_IN;
	if (add_out_EN) add_out <= `BSV_ASSIGNMENT_DELAY add_out_D_IN;
	if (counter_EN) counter <= `BSV_ASSIGNMENT_DELAY counter_D_IN;
	if (finish_EN) finish <= `BSV_ASSIGNMENT_DELAY finish_D_IN;
	if (got_A_EN) got_A <= `BSV_ASSIGNMENT_DELAY got_A_D_IN;
	if (got_B_EN) got_B <= `BSV_ASSIGNMENT_DELAY got_B_D_IN;
	if (got_C_EN) got_C <= `BSV_ASSIGNMENT_DELAY got_C_D_IN;
	if (got_result_EN)
	  got_result <= `BSV_ASSIGNMENT_DELAY got_result_D_IN;
	if (inpA_EN) inpA <= `BSV_ASSIGNMENT_DELAY inpA_D_IN;
	if (inpB_EN) inpB <= `BSV_ASSIGNMENT_DELAY inpB_D_IN;
	if (inpC_EN) inpC <= `BSV_ASSIGNMENT_DELAY inpC_D_IN;
	if (mul_done_EN) mul_done <= `BSV_ASSIGNMENT_DELAY mul_done_D_IN;
	if (mul_out_EN) mul_out <= `BSV_ASSIGNMENT_DELAY mul_out_D_IN;
	if (prepmul_EN) prepmul <= `BSV_ASSIGNMENT_DELAY prepmul_D_IN;
	if (select_EN) select <= `BSV_ASSIGNMENT_DELAY select_D_IN;
	if (temp_EN) temp <= `BSV_ASSIGNMENT_DELAY temp_D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    add_done = 1'h0;
    add_out = 32'hAAAAAAAA;
    counter = 5'h0A;
    finish = 1'h0;
    got_A = 1'h0;
    got_B = 1'h0;
    got_C = 1'h0;
    got_result = 1'h0;
    inpA = 16'hAAAA;
    inpB = 16'hAAAA;
    inpC = 32'hAAAAAAAA;
    mul_done = 1'h0;
    mul_out = 32'hAAAAAAAA;
    prepmul = 1'h0;
    select = 1'h0;
    temp = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkintmul

