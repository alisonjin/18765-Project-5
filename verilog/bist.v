// LFSR TPG and LFSR signature analysis
// LFSR taps: https://docs.xilinx.com/v/u/en-US/xapp052

module lfsr_compactor(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h0
    input [6:0] scan_outs,
    output reg [6:0] q
); 

    wire xor0, xor1, xor2, xor3, xor4, xor5, xor6;

    xor XOR0(xor0, scan_outs[0], q[6]);
    xor XOR1(xor1, scan_outs[1], q[0]);
    xor XOR2(xor2, scan_outs[2], q[1]);
    xor XOR3(xor3, scan_outs[3], q[2]);
    xor XOR4(xor4, scan_outs[4], q[3]);
    xor XOR5(xor5, scan_outs[5], q[4]);
    xor XOR6(xor6, scan_outs[6], q[5]);

    udff_r0 q0(q[0], clk, reset, xor0);
    udff_r0 q1(q[1], clk, reset, xor1);
    udff_r0 q2(q[2], clk, reset, xor2);
    udff_r0 q3(q[3], clk, reset, xor3);
    udff_r0 q4(q[4], clk, reset, xor4);
    udff_r0 q5(q[5], clk, reset, xor5);
    udff_r0 q6(q[6], clk, reset, xor6);
endmodule

module lfsr_tpg(
    input clk,
    input bist_en,
    input reset,    // Active-high synchronous reset to 5'h1
    output [6:0] q
); 
    wire xor_result;
    wire gated_clk;

    assign gated_clk = bist_en & clk;

    udff_r1 q0(q[0], gated_clk, reset, q[6]);
    udff_r0 q1(q[1], gated_clk, reset, q[0]);
    udff_r0 q2(q[2], gated_clk, reset, q[1]);
    udff_r0 q3(q[3], gated_clk, reset, q[2]);
    udff_r0 q4(q[4], gated_clk, reset, q[3]);
    udff_r0 q5(q[5], gated_clk, reset, q[4]);
    xor tap(xor_result, q[6], q[5]);
    udff_r0 q6(q[6], gated_clk, reset, xor_result);
endmodule

module s9234_scan(CK,  
  scan_en, test_en, bist_en,
  TPG_reset, COMP_reset,
  SI_chain1, SI_chain2, SI_chain3, SI_chain4, SI_chain5, SI_chain6, SI_chain7, 
  SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7, 
  g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,
  g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
  g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
  g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
  g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
  g639,g6728,g702,g705,g89,g94,g98, tpg_out);

input CK, scan_en, test_en, bist_en, TPG_reset, COMP_reset, SI_chain1, SI_chain2, SI_chain3, 
  SI_chain4, SI_chain5, SI_chain6, SI_chain7, 
  g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
  g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
  g41,g22,g44,g23;
output g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,
  g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,
  g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,
  g4104,g4107,g4098, SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7;

output [6:0] tpg_out;
//   wire [6:0] tpg_out;
  wire chain1, chain2, chain3, chain4, chain5, chain6, chain7;

  // BIST
  lfsr_tpg tpg(CK, bist_en, TPG_reset, tpg_out);

  u_mux2 MUX_0(chain1, SI_chain1, tpg_out[0],  bist_en);
  u_mux2 MUX_1(chain2, SI_chain2, tpg_out[1],  bist_en);
  u_mux2 MUX_2(chain3, SI_chain3, tpg_out[2],  bist_en);
  u_mux2 MUX_3(chain4, SI_chain4, tpg_out[3],  bist_en);
  u_mux2 MUX_4(chain5, SI_chain5, tpg_out[4],  bist_en);
  u_mux2 MUX_5(chain6, SI_chain6, tpg_out[5],  bist_en);
  u_mux2 MUX_6(chain7, SI_chain7, tpg_out[6],  bist_en);

  // CUT
//   s9234_scan_internal dft(CK,chain1, chain2, chain3, chain4, chain5, chain6, chain7,scan_en,SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g639,g6728,g702,g705,g89,g94,g98); 
    s9234_scan_boundary boundary(CK, test_en, chain1, chain2, chain3, chain4, chain5, chain6, chain7, scan_en, SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7, 
        g102,g107,g1290,g1293,g22,g23,
        g2584,g301,g306,g310,g314,g319,g32, 
        g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
        g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
        g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
        g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
        g639,g6728,g702,g705,g89,g94,g98);
  

endmodule