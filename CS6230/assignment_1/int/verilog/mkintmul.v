//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sun Nov 24 18:42:09 IST 2024
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_A                      O     1 const
// RDY_get_B                      O     1 const
// RDY_get_C                      O     1 const
// RDY_get_select                 O     1 const
// get_output                     O    32 reg
// RDY_get_output                 O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_A_a                        I    16
// get_B_b                        I    16
// get_C_c                        I    32 reg
// get_select_select              I     1 reg
// EN_get_A                       I     1
// EN_get_B                       I     1
// EN_get_C                       I     1
// EN_get_select                  I     1
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

		get_select_select,
		EN_get_select,
		RDY_get_select,

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

  // action method get_select
  input  get_select_select;
  input  EN_get_select;
  output RDY_get_select;

  // value method get_output
  output [31 : 0] get_output;
  output RDY_get_output;

  // signals for module outputs
  wire [31 : 0] get_output;
  wire RDY_get_A, RDY_get_B, RDY_get_C, RDY_get_output, RDY_get_select;

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

  // register got_select
  reg got_select;
  wire got_select_D_IN, got_select_EN;

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
       CAN_FIRE_get_select,
       WILL_FIRE_RL_finished,
       WILL_FIRE_RL_rl_add,
       WILL_FIRE_RL_rl_done,
       WILL_FIRE_RL_rl_mul,
       WILL_FIRE_RL_rl_multiply,
       WILL_FIRE_get_A,
       WILL_FIRE_get_B,
       WILL_FIRE_get_C,
       WILL_FIRE_get_select;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_inpA_write_1__VAL_2,
		MUX_inpB_write_1__VAL_2,
		MUX_temp_write_1__VAL_1;
  wire [4 : 0] MUX_counter_write_1__VAL_2;
  wire MUX_temp_write_1__SEL_1;

  // remaining internal signals
  wire [29 : 0] mul_out_80_BIT_29_89_XOR_inpC_82_BIT_29_90_92__ETC___d514;
  wire [27 : 0] mul_out_80_BIT_27_97_XOR_inpC_82_BIT_27_98_00__ETC___d513;
  wire [25 : 0] mul_out_80_BIT_25_05_XOR_inpC_82_BIT_25_06_08__ETC___d512;
  wire [23 : 0] mul_out_80_BIT_23_13_XOR_inpC_82_BIT_23_14_16__ETC___d511;
  wire [21 : 0] mul_out_80_BIT_21_21_XOR_inpC_82_BIT_21_22_24__ETC___d510;
  wire [19 : 0] mul_out_80_BIT_19_29_XOR_inpC_82_BIT_19_30_32__ETC___d509;
  wire [17 : 0] mul_out_80_BIT_17_37_XOR_inpC_82_BIT_17_38_40__ETC___d508;
  wire [15 : 0] INV_inpA__q1,
		mul_out_80_BIT_15_45_XOR_inpC_82_BIT_15_46_48__ETC___d507,
		temp_7_BIT_15_8_XOR_INV_inpA_9_0_BIT_15_1_XOR__ETC___d163,
		temp_7_BIT_15_8_XOR_inpA_9_BIT_15_64_65_XOR_te_ETC___d261;
  wire [13 : 0] mul_out_80_BIT_13_53_XOR_inpC_82_BIT_13_54_56__ETC___d506,
		temp_7_BIT_13_7_XOR_INV_inpA_9_0_BIT_13_3_XOR__ETC___d162,
		temp_7_BIT_13_7_XOR_inpA_9_BIT_13_69_71_XOR_te_ETC___d260;
  wire [11 : 0] mul_out_80_BIT_11_61_XOR_inpC_82_BIT_11_62_64__ETC___d505,
		temp_7_BIT_11_5_XOR_INV_inpA_9_0_BIT_11_5_XOR__ETC___d161,
		temp_7_BIT_11_5_XOR_inpA_9_BIT_11_75_77_XOR_te_ETC___d259;
  wire [9 : 0] mul_out_80_BIT_9_69_XOR_inpC_82_BIT_9_70_72_XO_ETC___d504,
	       temp_7_BIT_9_3_XOR_INV_inpA_9_0_BIT_9_7_XOR_IN_ETC___d160,
	       temp_7_BIT_9_3_XOR_inpA_9_BIT_9_81_83_XOR_temp_ETC___d258;
  wire [7 : 0] mul_out_80_BIT_7_77_XOR_inpC_82_BIT_7_78_80_XO_ETC___d503,
	       temp_7_BIT_7_1_XOR_INV_inpA_9_0_BIT_7_9_XOR_IN_ETC___d159,
	       temp_7_BIT_7_1_XOR_inpA_9_BIT_7_87_89_XOR_temp_ETC___d257;
  wire [5 : 0] mul_out_80_BIT_5_85_XOR_inpC_82_BIT_5_86_88_XO_ETC___d502,
	       temp_7_BIT_5_9_XOR_INV_inpA_9_0_BIT_5_1_XOR_IN_ETC___d158,
	       temp_7_BIT_5_9_XOR_inpA_9_BIT_5_93_95_XOR_temp_ETC___d256;
  wire [3 : 0] mul_out_80_BIT_3_93_XOR_inpC_82_BIT_3_94_96_XO_ETC___d501,
	       temp_7_BIT_3_7_XOR_INV_inpA_9_0_BIT_3_3_XOR_IN_ETC___d157,
	       temp_7_BIT_3_7_XOR_inpA_9_BIT_3_99_01_XOR_temp_ETC___d255;
  wire x__h10314,
       x__h10375,
       x__h10480,
       x__h10585,
       x__h10690,
       x__h10795,
       x__h10900,
       x__h11005,
       x__h11110,
       x__h11215,
       x__h11320,
       x__h11425,
       x__h11530,
       x__h1155,
       x__h11635,
       x__h11740,
       x__h11845,
       x__h11950,
       x__h12055,
       x__h12160,
       x__h12265,
       x__h12370,
       x__h12475,
       x__h12580,
       x__h12685,
       x__h12790,
       x__h12895,
       x__h13000,
       x__h13105,
       x__h13210,
       x__h13315,
       x__h13420,
       x__h13565,
       x__h13622,
       x__h13679,
       x__h13736,
       x__h13793,
       x__h13850,
       x__h13907,
       x__h13964,
       x__h14021,
       x__h14078,
       x__h14135,
       x__h14192,
       x__h14249,
       x__h14306,
       x__h14363,
       x__h14420,
       x__h14477,
       x__h14534,
       x__h14591,
       x__h14648,
       x__h14705,
       x__h14762,
       x__h14819,
       x__h14876,
       x__h14933,
       x__h14990,
       x__h15047,
       x__h15104,
       x__h15161,
       x__h15218,
       x__h4017,
       x__h4063,
       x__h4120,
       x__h4166,
       x__h4223,
       x__h4269,
       x__h4326,
       x__h4372,
       x__h4429,
       x__h4475,
       x__h4532,
       x__h4578,
       x__h4635,
       x__h4681,
       x__h4738,
       x__h4784,
       x__h4841,
       x__h4887,
       x__h4944,
       x__h4990,
       x__h5047,
       x__h5093,
       x__h5150,
       x__h5196,
       x__h5253,
       x__h5299,
       x__h5356,
       x__h5402,
       x__h6785,
       x__h6844,
       x__h6949,
       x__h7054,
       x__h7159,
       x__h7264,
       x__h7369,
       x__h7474,
       x__h7579,
       x__h7684,
       x__h7789,
       x__h7894,
       x__h7999,
       x__h8104,
       x__h8209,
       x__h8354,
       x__h8411,
       x__h8468,
       x__h8525,
       x__h8582,
       x__h8639,
       x__h8696,
       x__h8753,
       x__h8810,
       x__h8867,
       x__h8924,
       x__h8981,
       x__h9038,
       x__h9095,
       y__h10315,
       y__h10376,
       y__h10481,
       y__h10586,
       y__h10691,
       y__h10796,
       y__h10901,
       y__h11006,
       y__h11111,
       y__h11216,
       y__h11321,
       y__h11426,
       y__h11531,
       y__h1156,
       y__h1158,
       y__h11636,
       y__h11741,
       y__h11846,
       y__h11951,
       y__h12056,
       y__h12161,
       y__h12266,
       y__h12371,
       y__h12476,
       y__h12581,
       y__h12686,
       y__h12791,
       y__h12896,
       y__h13001,
       y__h13106,
       y__h13211,
       y__h13316,
       y__h13421,
       y__h13566,
       y__h13623,
       y__h13680,
       y__h13737,
       y__h13794,
       y__h13851,
       y__h13908,
       y__h13965,
       y__h14022,
       y__h14079,
       y__h14136,
       y__h14193,
       y__h14250,
       y__h14307,
       y__h14364,
       y__h14421,
       y__h14478,
       y__h14535,
       y__h14592,
       y__h14649,
       y__h14706,
       y__h14763,
       y__h14820,
       y__h14877,
       y__h14934,
       y__h14991,
       y__h15048,
       y__h15105,
       y__h15162,
       y__h15219,
       y__h1635,
       y__h1741,
       y__h1844,
       y__h1947,
       y__h2050,
       y__h2153,
       y__h2256,
       y__h2359,
       y__h2462,
       y__h2565,
       y__h2668,
       y__h2771,
       y__h2874,
       y__h2977,
       y__h4018,
       y__h4020,
       y__h4064,
       y__h4121,
       y__h4123,
       y__h4167,
       y__h4224,
       y__h4226,
       y__h4270,
       y__h4327,
       y__h4329,
       y__h4373,
       y__h4430,
       y__h4432,
       y__h4476,
       y__h4533,
       y__h4535,
       y__h4579,
       y__h4636,
       y__h4638,
       y__h4682,
       y__h4739,
       y__h4741,
       y__h4785,
       y__h4842,
       y__h4844,
       y__h4888,
       y__h4945,
       y__h4947,
       y__h4991,
       y__h5048,
       y__h5050,
       y__h5094,
       y__h5151,
       y__h5153,
       y__h5197,
       y__h5254,
       y__h5256,
       y__h5300,
       y__h5357,
       y__h5359,
       y__h5403,
       y__h6786,
       y__h6845,
       y__h6950,
       y__h7055,
       y__h7160,
       y__h7265,
       y__h7370,
       y__h7475,
       y__h7580,
       y__h7685,
       y__h7790,
       y__h7895,
       y__h8000,
       y__h8105,
       y__h8210,
       y__h8355,
       y__h8412,
       y__h8469,
       y__h8526,
       y__h8583,
       y__h8640,
       y__h8697,
       y__h8754,
       y__h8811,
       y__h8868,
       y__h8925,
       y__h8982,
       y__h9039,
       y__h9096;

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

  // action method get_select
  assign RDY_get_select = 1'd1 ;
  assign CAN_FIRE_get_select = 1'd1 ;
  assign WILL_FIRE_get_select = EN_get_select ;

  // value method get_output
  assign get_output = add_out ;
  assign RDY_get_output = 1'd1 ;

  // rule RL_rl_multiply
  assign CAN_FIRE_RL_rl_multiply =
	     got_A && got_B && got_C && got_select && counter != 5'd0 &&
	     finish ;
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
	       temp_7_BIT_15_8_XOR_INV_inpA_9_0_BIT_15_1_XOR__ETC___d163 :
	       temp_7_BIT_15_8_XOR_inpA_9_BIT_15_64_65_XOR_te_ETC___d261 ;

  // register add_done
  assign add_done_D_IN = !WILL_FIRE_RL_rl_done ;
  assign add_done_EN = WILL_FIRE_RL_rl_done || WILL_FIRE_RL_rl_add ;

  // register add_out
  assign add_out_D_IN =
	     { x__h10314 ^ y__h10315,
	       x__h13565 ^ y__h13566,
	       mul_out_80_BIT_29_89_XOR_inpC_82_BIT_29_90_92__ETC___d514 } ;
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

  // register got_select
  assign got_select_D_IN = !got_result ;
  assign got_select_EN = got_result || EN_get_select ;

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
  assign select_D_IN = get_select_select ;
  assign select_EN = EN_get_select ;

  // register temp
  assign temp_D_IN =
	     MUX_temp_write_1__SEL_1 ? MUX_temp_write_1__VAL_1 : 16'd0 ;
  assign temp_EN =
	     WILL_FIRE_RL_rl_multiply && inpB[0] || WILL_FIRE_RL_rl_mul ;

  // remaining internal signals
  assign INV_inpA__q1 = ~inpA ;
  assign mul_out_80_BIT_11_61_XOR_inpC_82_BIT_11_62_64__ETC___d505 =
	     { x__h14648 ^ y__h14649,
	       x__h14705 ^ y__h14706,
	       mul_out_80_BIT_9_69_XOR_inpC_82_BIT_9_70_72_XO_ETC___d504 } ;
  assign mul_out_80_BIT_13_53_XOR_inpC_82_BIT_13_54_56__ETC___d506 =
	     { x__h14534 ^ y__h14535,
	       x__h14591 ^ y__h14592,
	       mul_out_80_BIT_11_61_XOR_inpC_82_BIT_11_62_64__ETC___d505 } ;
  assign mul_out_80_BIT_15_45_XOR_inpC_82_BIT_15_46_48__ETC___d507 =
	     { x__h14420 ^ y__h14421,
	       x__h14477 ^ y__h14478,
	       mul_out_80_BIT_13_53_XOR_inpC_82_BIT_13_54_56__ETC___d506 } ;
  assign mul_out_80_BIT_17_37_XOR_inpC_82_BIT_17_38_40__ETC___d508 =
	     { x__h14306 ^ y__h14307,
	       x__h14363 ^ y__h14364,
	       mul_out_80_BIT_15_45_XOR_inpC_82_BIT_15_46_48__ETC___d507 } ;
  assign mul_out_80_BIT_19_29_XOR_inpC_82_BIT_19_30_32__ETC___d509 =
	     { x__h14192 ^ y__h14193,
	       x__h14249 ^ y__h14250,
	       mul_out_80_BIT_17_37_XOR_inpC_82_BIT_17_38_40__ETC___d508 } ;
  assign mul_out_80_BIT_21_21_XOR_inpC_82_BIT_21_22_24__ETC___d510 =
	     { x__h14078 ^ y__h14079,
	       x__h14135 ^ y__h14136,
	       mul_out_80_BIT_19_29_XOR_inpC_82_BIT_19_30_32__ETC___d509 } ;
  assign mul_out_80_BIT_23_13_XOR_inpC_82_BIT_23_14_16__ETC___d511 =
	     { x__h13964 ^ y__h13965,
	       x__h14021 ^ y__h14022,
	       mul_out_80_BIT_21_21_XOR_inpC_82_BIT_21_22_24__ETC___d510 } ;
  assign mul_out_80_BIT_25_05_XOR_inpC_82_BIT_25_06_08__ETC___d512 =
	     { x__h13850 ^ y__h13851,
	       x__h13907 ^ y__h13908,
	       mul_out_80_BIT_23_13_XOR_inpC_82_BIT_23_14_16__ETC___d511 } ;
  assign mul_out_80_BIT_27_97_XOR_inpC_82_BIT_27_98_00__ETC___d513 =
	     { x__h13736 ^ y__h13737,
	       x__h13793 ^ y__h13794,
	       mul_out_80_BIT_25_05_XOR_inpC_82_BIT_25_06_08__ETC___d512 } ;
  assign mul_out_80_BIT_29_89_XOR_inpC_82_BIT_29_90_92__ETC___d514 =
	     { x__h13622 ^ y__h13623,
	       x__h13679 ^ y__h13680,
	       mul_out_80_BIT_27_97_XOR_inpC_82_BIT_27_98_00__ETC___d513 } ;
  assign mul_out_80_BIT_3_93_XOR_inpC_82_BIT_3_94_96_XO_ETC___d501 =
	     { x__h15104 ^ y__h15105,
	       x__h15161 ^ y__h15162,
	       x__h15218 ^ y__h15219,
	       mul_out[0] ^ inpC[0] } ;
  assign mul_out_80_BIT_5_85_XOR_inpC_82_BIT_5_86_88_XO_ETC___d502 =
	     { x__h14990 ^ y__h14991,
	       x__h15047 ^ y__h15048,
	       mul_out_80_BIT_3_93_XOR_inpC_82_BIT_3_94_96_XO_ETC___d501 } ;
  assign mul_out_80_BIT_7_77_XOR_inpC_82_BIT_7_78_80_XO_ETC___d503 =
	     { x__h14876 ^ y__h14877,
	       x__h14933 ^ y__h14934,
	       mul_out_80_BIT_5_85_XOR_inpC_82_BIT_5_86_88_XO_ETC___d502 } ;
  assign mul_out_80_BIT_9_69_XOR_inpC_82_BIT_9_70_72_XO_ETC___d504 =
	     { x__h14762 ^ y__h14763,
	       x__h14819 ^ y__h14820,
	       mul_out_80_BIT_7_77_XOR_inpC_82_BIT_7_78_80_XO_ETC___d503 } ;
  assign temp_7_BIT_11_5_XOR_INV_inpA_9_0_BIT_11_5_XOR__ETC___d161 =
	     { x__h4372 ^ y__h4373,
	       x__h4475 ^ y__h4476,
	       temp_7_BIT_9_3_XOR_INV_inpA_9_0_BIT_9_7_XOR_IN_ETC___d160 } ;
  assign temp_7_BIT_11_5_XOR_inpA_9_BIT_11_75_77_XOR_te_ETC___d259 =
	     { x__h8525 ^ y__h8526,
	       x__h8582 ^ y__h8583,
	       temp_7_BIT_9_3_XOR_inpA_9_BIT_9_81_83_XOR_temp_ETC___d258 } ;
  assign temp_7_BIT_13_7_XOR_INV_inpA_9_0_BIT_13_3_XOR__ETC___d162 =
	     { x__h4166 ^ y__h4167,
	       x__h4269 ^ y__h4270,
	       temp_7_BIT_11_5_XOR_INV_inpA_9_0_BIT_11_5_XOR__ETC___d161 } ;
  assign temp_7_BIT_13_7_XOR_inpA_9_BIT_13_69_71_XOR_te_ETC___d260 =
	     { x__h8411 ^ y__h8412,
	       x__h8468 ^ y__h8469,
	       temp_7_BIT_11_5_XOR_inpA_9_BIT_11_75_77_XOR_te_ETC___d259 } ;
  assign temp_7_BIT_15_8_XOR_INV_inpA_9_0_BIT_15_1_XOR__ETC___d163 =
	     { x__h1155 ^ y__h1156,
	       x__h4063 ^ y__h4064,
	       temp_7_BIT_13_7_XOR_INV_inpA_9_0_BIT_13_3_XOR__ETC___d162 } ;
  assign temp_7_BIT_15_8_XOR_inpA_9_BIT_15_64_65_XOR_te_ETC___d261 =
	     { x__h6785 ^ y__h6786,
	       x__h8354 ^ y__h8355,
	       temp_7_BIT_13_7_XOR_inpA_9_BIT_13_69_71_XOR_te_ETC___d260 } ;
  assign temp_7_BIT_3_7_XOR_INV_inpA_9_0_BIT_3_3_XOR_IN_ETC___d157 =
	     { x__h5196 ^ y__h5197,
	       x__h5299 ^ y__h5300,
	       x__h5402 ^ y__h5403,
	       temp[0] ^ ~INV_inpA__q1[0] } ;
  assign temp_7_BIT_3_7_XOR_inpA_9_BIT_3_99_01_XOR_temp_ETC___d255 =
	     { x__h8981 ^ y__h8982,
	       x__h9038 ^ y__h9039,
	       x__h9095 ^ y__h9096,
	       temp[0] ^ inpA[0] } ;
  assign temp_7_BIT_5_9_XOR_INV_inpA_9_0_BIT_5_1_XOR_IN_ETC___d158 =
	     { x__h4990 ^ y__h4991,
	       x__h5093 ^ y__h5094,
	       temp_7_BIT_3_7_XOR_INV_inpA_9_0_BIT_3_3_XOR_IN_ETC___d157 } ;
  assign temp_7_BIT_5_9_XOR_inpA_9_BIT_5_93_95_XOR_temp_ETC___d256 =
	     { x__h8867 ^ y__h8868,
	       x__h8924 ^ y__h8925,
	       temp_7_BIT_3_7_XOR_inpA_9_BIT_3_99_01_XOR_temp_ETC___d255 } ;
  assign temp_7_BIT_7_1_XOR_INV_inpA_9_0_BIT_7_9_XOR_IN_ETC___d159 =
	     { x__h4784 ^ y__h4785,
	       x__h4887 ^ y__h4888,
	       temp_7_BIT_5_9_XOR_INV_inpA_9_0_BIT_5_1_XOR_IN_ETC___d158 } ;
  assign temp_7_BIT_7_1_XOR_inpA_9_BIT_7_87_89_XOR_temp_ETC___d257 =
	     { x__h8753 ^ y__h8754,
	       x__h8810 ^ y__h8811,
	       temp_7_BIT_5_9_XOR_inpA_9_BIT_5_93_95_XOR_temp_ETC___d256 } ;
  assign temp_7_BIT_9_3_XOR_INV_inpA_9_0_BIT_9_7_XOR_IN_ETC___d160 =
	     { x__h4578 ^ y__h4579,
	       x__h4681 ^ y__h4682,
	       temp_7_BIT_7_1_XOR_INV_inpA_9_0_BIT_7_9_XOR_IN_ETC___d159 } ;
  assign temp_7_BIT_9_3_XOR_inpA_9_BIT_9_81_83_XOR_temp_ETC___d258 =
	     { x__h8639 ^ y__h8640,
	       x__h8696 ^ y__h8697,
	       temp_7_BIT_7_1_XOR_inpA_9_BIT_7_87_89_XOR_temp_ETC___d257 } ;
  assign x__h10314 = mul_out[31] ^ inpC[31] ;
  assign x__h10375 = mul_out[30] & inpC[30] ;
  assign x__h10480 = mul_out[29] & inpC[29] ;
  assign x__h10585 = mul_out[28] & inpC[28] ;
  assign x__h10690 = mul_out[27] & inpC[27] ;
  assign x__h10795 = mul_out[26] & inpC[26] ;
  assign x__h10900 = mul_out[25] & inpC[25] ;
  assign x__h11005 = mul_out[24] & inpC[24] ;
  assign x__h11110 = mul_out[23] & inpC[23] ;
  assign x__h11215 = mul_out[22] & inpC[22] ;
  assign x__h11320 = mul_out[21] & inpC[21] ;
  assign x__h11425 = mul_out[20] & inpC[20] ;
  assign x__h11530 = mul_out[19] & inpC[19] ;
  assign x__h1155 = temp[15] ^ y__h1158 ;
  assign x__h11635 = mul_out[18] & inpC[18] ;
  assign x__h11740 = mul_out[17] & inpC[17] ;
  assign x__h11845 = mul_out[16] & inpC[16] ;
  assign x__h11950 = mul_out[15] & inpC[15] ;
  assign x__h12055 = mul_out[14] & inpC[14] ;
  assign x__h12160 = mul_out[13] & inpC[13] ;
  assign x__h12265 = mul_out[12] & inpC[12] ;
  assign x__h12370 = mul_out[11] & inpC[11] ;
  assign x__h12475 = mul_out[10] & inpC[10] ;
  assign x__h12580 = mul_out[9] & inpC[9] ;
  assign x__h12685 = mul_out[8] & inpC[8] ;
  assign x__h12790 = mul_out[7] & inpC[7] ;
  assign x__h12895 = mul_out[6] & inpC[6] ;
  assign x__h13000 = mul_out[5] & inpC[5] ;
  assign x__h13105 = mul_out[4] & inpC[4] ;
  assign x__h13210 = mul_out[3] & inpC[3] ;
  assign x__h13315 = mul_out[2] & inpC[2] ;
  assign x__h13420 = mul_out[1] & inpC[1] ;
  assign x__h13565 = mul_out[30] ^ inpC[30] ;
  assign x__h13622 = mul_out[29] ^ inpC[29] ;
  assign x__h13679 = mul_out[28] ^ inpC[28] ;
  assign x__h13736 = mul_out[27] ^ inpC[27] ;
  assign x__h13793 = mul_out[26] ^ inpC[26] ;
  assign x__h13850 = mul_out[25] ^ inpC[25] ;
  assign x__h13907 = mul_out[24] ^ inpC[24] ;
  assign x__h13964 = mul_out[23] ^ inpC[23] ;
  assign x__h14021 = mul_out[22] ^ inpC[22] ;
  assign x__h14078 = mul_out[21] ^ inpC[21] ;
  assign x__h14135 = mul_out[20] ^ inpC[20] ;
  assign x__h14192 = mul_out[19] ^ inpC[19] ;
  assign x__h14249 = mul_out[18] ^ inpC[18] ;
  assign x__h14306 = mul_out[17] ^ inpC[17] ;
  assign x__h14363 = mul_out[16] ^ inpC[16] ;
  assign x__h14420 = mul_out[15] ^ inpC[15] ;
  assign x__h14477 = mul_out[14] ^ inpC[14] ;
  assign x__h14534 = mul_out[13] ^ inpC[13] ;
  assign x__h14591 = mul_out[12] ^ inpC[12] ;
  assign x__h14648 = mul_out[11] ^ inpC[11] ;
  assign x__h14705 = mul_out[10] ^ inpC[10] ;
  assign x__h14762 = mul_out[9] ^ inpC[9] ;
  assign x__h14819 = mul_out[8] ^ inpC[8] ;
  assign x__h14876 = mul_out[7] ^ inpC[7] ;
  assign x__h14933 = mul_out[6] ^ inpC[6] ;
  assign x__h14990 = mul_out[5] ^ inpC[5] ;
  assign x__h15047 = mul_out[4] ^ inpC[4] ;
  assign x__h15104 = mul_out[3] ^ inpC[3] ;
  assign x__h15161 = mul_out[2] ^ inpC[2] ;
  assign x__h15218 = mul_out[1] ^ inpC[1] ;
  assign x__h4017 = temp[14] & y__h4020 ;
  assign x__h4063 = temp[14] ^ y__h4020 ;
  assign x__h4120 = temp[13] & y__h4123 ;
  assign x__h4166 = temp[13] ^ y__h4123 ;
  assign x__h4223 = temp[12] & y__h4226 ;
  assign x__h4269 = temp[12] ^ y__h4226 ;
  assign x__h4326 = temp[11] & y__h4329 ;
  assign x__h4372 = temp[11] ^ y__h4329 ;
  assign x__h4429 = temp[10] & y__h4432 ;
  assign x__h4475 = temp[10] ^ y__h4432 ;
  assign x__h4532 = temp[9] & y__h4535 ;
  assign x__h4578 = temp[9] ^ y__h4535 ;
  assign x__h4635 = temp[8] & y__h4638 ;
  assign x__h4681 = temp[8] ^ y__h4638 ;
  assign x__h4738 = temp[7] & y__h4741 ;
  assign x__h4784 = temp[7] ^ y__h4741 ;
  assign x__h4841 = temp[6] & y__h4844 ;
  assign x__h4887 = temp[6] ^ y__h4844 ;
  assign x__h4944 = temp[5] & y__h4947 ;
  assign x__h4990 = temp[5] ^ y__h4947 ;
  assign x__h5047 = temp[4] & y__h5050 ;
  assign x__h5093 = temp[4] ^ y__h5050 ;
  assign x__h5150 = temp[3] & y__h5153 ;
  assign x__h5196 = temp[3] ^ y__h5153 ;
  assign x__h5253 = temp[2] & y__h5256 ;
  assign x__h5299 = temp[2] ^ y__h5256 ;
  assign x__h5356 = temp[1] & y__h5359 ;
  assign x__h5402 = temp[1] ^ y__h5359 ;
  assign x__h6785 = temp[15] ^ inpA[15] ;
  assign x__h6844 = temp[14] & inpA[14] ;
  assign x__h6949 = temp[13] & inpA[13] ;
  assign x__h7054 = temp[12] & inpA[12] ;
  assign x__h7159 = temp[11] & inpA[11] ;
  assign x__h7264 = temp[10] & inpA[10] ;
  assign x__h7369 = temp[9] & inpA[9] ;
  assign x__h7474 = temp[8] & inpA[8] ;
  assign x__h7579 = temp[7] & inpA[7] ;
  assign x__h7684 = temp[6] & inpA[6] ;
  assign x__h7789 = temp[5] & inpA[5] ;
  assign x__h7894 = temp[4] & inpA[4] ;
  assign x__h7999 = temp[3] & inpA[3] ;
  assign x__h8104 = temp[2] & inpA[2] ;
  assign x__h8209 = temp[1] & inpA[1] ;
  assign x__h8354 = temp[14] ^ inpA[14] ;
  assign x__h8411 = temp[13] ^ inpA[13] ;
  assign x__h8468 = temp[12] ^ inpA[12] ;
  assign x__h8525 = temp[11] ^ inpA[11] ;
  assign x__h8582 = temp[10] ^ inpA[10] ;
  assign x__h8639 = temp[9] ^ inpA[9] ;
  assign x__h8696 = temp[8] ^ inpA[8] ;
  assign x__h8753 = temp[7] ^ inpA[7] ;
  assign x__h8810 = temp[6] ^ inpA[6] ;
  assign x__h8867 = temp[5] ^ inpA[5] ;
  assign x__h8924 = temp[4] ^ inpA[4] ;
  assign x__h8981 = temp[3] ^ inpA[3] ;
  assign x__h9038 = temp[2] ^ inpA[2] ;
  assign x__h9095 = temp[1] ^ inpA[1] ;
  assign y__h10315 = x__h10375 | y__h10376 ;
  assign y__h10376 = x__h13565 & y__h13566 ;
  assign y__h10481 = x__h13622 & y__h13623 ;
  assign y__h10586 = x__h13679 & y__h13680 ;
  assign y__h10691 = x__h13736 & y__h13737 ;
  assign y__h10796 = x__h13793 & y__h13794 ;
  assign y__h10901 = x__h13850 & y__h13851 ;
  assign y__h11006 = x__h13907 & y__h13908 ;
  assign y__h11111 = x__h13964 & y__h13965 ;
  assign y__h11216 = x__h14021 & y__h14022 ;
  assign y__h11321 = x__h14078 & y__h14079 ;
  assign y__h11426 = x__h14135 & y__h14136 ;
  assign y__h11531 = x__h14192 & y__h14193 ;
  assign y__h1156 = x__h4017 | y__h4018 ;
  assign y__h1158 = INV_inpA__q1[15] ^ y__h1635 ;
  assign y__h11636 = x__h14249 & y__h14250 ;
  assign y__h11741 = x__h14306 & y__h14307 ;
  assign y__h11846 = x__h14363 & y__h14364 ;
  assign y__h11951 = x__h14420 & y__h14421 ;
  assign y__h12056 = x__h14477 & y__h14478 ;
  assign y__h12161 = x__h14534 & y__h14535 ;
  assign y__h12266 = x__h14591 & y__h14592 ;
  assign y__h12371 = x__h14648 & y__h14649 ;
  assign y__h12476 = x__h14705 & y__h14706 ;
  assign y__h12581 = x__h14762 & y__h14763 ;
  assign y__h12686 = x__h14819 & y__h14820 ;
  assign y__h12791 = x__h14876 & y__h14877 ;
  assign y__h12896 = x__h14933 & y__h14934 ;
  assign y__h13001 = x__h14990 & y__h14991 ;
  assign y__h13106 = x__h15047 & y__h15048 ;
  assign y__h13211 = x__h15104 & y__h15105 ;
  assign y__h13316 = x__h15161 & y__h15162 ;
  assign y__h13421 = x__h15218 & y__h15219 ;
  assign y__h13566 = x__h10480 | y__h10481 ;
  assign y__h13623 = x__h10585 | y__h10586 ;
  assign y__h13680 = x__h10690 | y__h10691 ;
  assign y__h13737 = x__h10795 | y__h10796 ;
  assign y__h13794 = x__h10900 | y__h10901 ;
  assign y__h13851 = x__h11005 | y__h11006 ;
  assign y__h13908 = x__h11110 | y__h11111 ;
  assign y__h13965 = x__h11215 | y__h11216 ;
  assign y__h14022 = x__h11320 | y__h11321 ;
  assign y__h14079 = x__h11425 | y__h11426 ;
  assign y__h14136 = x__h11530 | y__h11531 ;
  assign y__h14193 = x__h11635 | y__h11636 ;
  assign y__h14250 = x__h11740 | y__h11741 ;
  assign y__h14307 = x__h11845 | y__h11846 ;
  assign y__h14364 = x__h11950 | y__h11951 ;
  assign y__h14421 = x__h12055 | y__h12056 ;
  assign y__h14478 = x__h12160 | y__h12161 ;
  assign y__h14535 = x__h12265 | y__h12266 ;
  assign y__h14592 = x__h12370 | y__h12371 ;
  assign y__h14649 = x__h12475 | y__h12476 ;
  assign y__h14706 = x__h12580 | y__h12581 ;
  assign y__h14763 = x__h12685 | y__h12686 ;
  assign y__h14820 = x__h12790 | y__h12791 ;
  assign y__h14877 = x__h12895 | y__h12896 ;
  assign y__h14934 = x__h13000 | y__h13001 ;
  assign y__h14991 = x__h13105 | y__h13106 ;
  assign y__h15048 = x__h13210 | y__h13211 ;
  assign y__h15105 = x__h13315 | y__h13316 ;
  assign y__h15162 = x__h13420 | y__h13421 ;
  assign y__h15219 = mul_out[0] & inpC[0] ;
  assign y__h1635 = INV_inpA__q1[14] & y__h1741 ;
  assign y__h1741 = INV_inpA__q1[13] & y__h1844 ;
  assign y__h1844 = INV_inpA__q1[12] & y__h1947 ;
  assign y__h1947 = INV_inpA__q1[11] & y__h2050 ;
  assign y__h2050 = INV_inpA__q1[10] & y__h2153 ;
  assign y__h2153 = INV_inpA__q1[9] & y__h2256 ;
  assign y__h2256 = INV_inpA__q1[8] & y__h2359 ;
  assign y__h2359 = INV_inpA__q1[7] & y__h2462 ;
  assign y__h2462 = INV_inpA__q1[6] & y__h2565 ;
  assign y__h2565 = INV_inpA__q1[5] & y__h2668 ;
  assign y__h2668 = INV_inpA__q1[4] & y__h2771 ;
  assign y__h2771 = INV_inpA__q1[3] & y__h2874 ;
  assign y__h2874 = INV_inpA__q1[2] & y__h2977 ;
  assign y__h2977 = INV_inpA__q1[1] & INV_inpA__q1[0] ;
  assign y__h4018 = x__h4063 & y__h4064 ;
  assign y__h4020 = INV_inpA__q1[14] ^ y__h1741 ;
  assign y__h4064 = x__h4120 | y__h4121 ;
  assign y__h4121 = x__h4166 & y__h4167 ;
  assign y__h4123 = INV_inpA__q1[13] ^ y__h1844 ;
  assign y__h4167 = x__h4223 | y__h4224 ;
  assign y__h4224 = x__h4269 & y__h4270 ;
  assign y__h4226 = INV_inpA__q1[12] ^ y__h1947 ;
  assign y__h4270 = x__h4326 | y__h4327 ;
  assign y__h4327 = x__h4372 & y__h4373 ;
  assign y__h4329 = INV_inpA__q1[11] ^ y__h2050 ;
  assign y__h4373 = x__h4429 | y__h4430 ;
  assign y__h4430 = x__h4475 & y__h4476 ;
  assign y__h4432 = INV_inpA__q1[10] ^ y__h2153 ;
  assign y__h4476 = x__h4532 | y__h4533 ;
  assign y__h4533 = x__h4578 & y__h4579 ;
  assign y__h4535 = INV_inpA__q1[9] ^ y__h2256 ;
  assign y__h4579 = x__h4635 | y__h4636 ;
  assign y__h4636 = x__h4681 & y__h4682 ;
  assign y__h4638 = INV_inpA__q1[8] ^ y__h2359 ;
  assign y__h4682 = x__h4738 | y__h4739 ;
  assign y__h4739 = x__h4784 & y__h4785 ;
  assign y__h4741 = INV_inpA__q1[7] ^ y__h2462 ;
  assign y__h4785 = x__h4841 | y__h4842 ;
  assign y__h4842 = x__h4887 & y__h4888 ;
  assign y__h4844 = INV_inpA__q1[6] ^ y__h2565 ;
  assign y__h4888 = x__h4944 | y__h4945 ;
  assign y__h4945 = x__h4990 & y__h4991 ;
  assign y__h4947 = INV_inpA__q1[5] ^ y__h2668 ;
  assign y__h4991 = x__h5047 | y__h5048 ;
  assign y__h5048 = x__h5093 & y__h5094 ;
  assign y__h5050 = INV_inpA__q1[4] ^ y__h2771 ;
  assign y__h5094 = x__h5150 | y__h5151 ;
  assign y__h5151 = x__h5196 & y__h5197 ;
  assign y__h5153 = INV_inpA__q1[3] ^ y__h2874 ;
  assign y__h5197 = x__h5253 | y__h5254 ;
  assign y__h5254 = x__h5299 & y__h5300 ;
  assign y__h5256 = INV_inpA__q1[2] ^ y__h2977 ;
  assign y__h5300 = x__h5356 | y__h5357 ;
  assign y__h5357 = x__h5402 & y__h5403 ;
  assign y__h5359 = INV_inpA__q1[1] ^ INV_inpA__q1[0] ;
  assign y__h5403 = temp[0] & ~INV_inpA__q1[0] ;
  assign y__h6786 = x__h6844 | y__h6845 ;
  assign y__h6845 = x__h8354 & y__h8355 ;
  assign y__h6950 = x__h8411 & y__h8412 ;
  assign y__h7055 = x__h8468 & y__h8469 ;
  assign y__h7160 = x__h8525 & y__h8526 ;
  assign y__h7265 = x__h8582 & y__h8583 ;
  assign y__h7370 = x__h8639 & y__h8640 ;
  assign y__h7475 = x__h8696 & y__h8697 ;
  assign y__h7580 = x__h8753 & y__h8754 ;
  assign y__h7685 = x__h8810 & y__h8811 ;
  assign y__h7790 = x__h8867 & y__h8868 ;
  assign y__h7895 = x__h8924 & y__h8925 ;
  assign y__h8000 = x__h8981 & y__h8982 ;
  assign y__h8105 = x__h9038 & y__h9039 ;
  assign y__h8210 = x__h9095 & y__h9096 ;
  assign y__h8355 = x__h6949 | y__h6950 ;
  assign y__h8412 = x__h7054 | y__h7055 ;
  assign y__h8469 = x__h7159 | y__h7160 ;
  assign y__h8526 = x__h7264 | y__h7265 ;
  assign y__h8583 = x__h7369 | y__h7370 ;
  assign y__h8640 = x__h7474 | y__h7475 ;
  assign y__h8697 = x__h7579 | y__h7580 ;
  assign y__h8754 = x__h7684 | y__h7685 ;
  assign y__h8811 = x__h7789 | y__h7790 ;
  assign y__h8868 = x__h7894 | y__h7895 ;
  assign y__h8925 = x__h7999 | y__h8000 ;
  assign y__h8982 = x__h8104 | y__h8105 ;
  assign y__h9039 = x__h8209 | y__h8210 ;
  assign y__h9096 = temp[0] & inpA[0] ;

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
	got_select <= `BSV_ASSIGNMENT_DELAY 1'd0;
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
	if (got_select_EN)
	  got_select <= `BSV_ASSIGNMENT_DELAY got_select_D_IN;
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
    got_select = 1'h0;
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
