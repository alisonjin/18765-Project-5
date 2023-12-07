// LFSR TPG and LFSR signature analysis
// LFSR taps: https://docs.xilinx.com/v/u/en-US/xapp052

// module lfsr_compactor(
//     input clk,
//     input reset,    // Active-high synchronous reset to 5'h0
//     output reg [6:0] q
// ); 

//     always @(posedge clk)
//     begin
//         if (reset)
//             q <= 7'd0;
//         else begin
//             //x^7 + x^6 + 1
//             q <= {q[5] ^ q[6], q[4], q[3], q[2], q[1], q[0], q[6]};
//         end
//     end
// endmodule

module lfsr_tpg(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    input feedback,
    output [6:0] q
); 
    wire[6:0] q_internal;
    wire q6_in;
    
    dff q0(q_internal[0], clk, feedback);
    dff q1(q_internal[1], clk, q_internal[0]);
    dff q2(q_internal[2], clk, q_internal[1]);
    dff q3(q_internal[3], clk, q_internal[2]);
    dff q4(q_internal[4], clk, q_internal[3]);
    dff q5(q_internal[5], clk, q_internal[4]);
    xor tap(q6_in, feedback, q_internal[5]);
    dff q6(q_internal[6], clk, q6_in);
    u_mux2 out(q, q_internal, 7'd1, reset);
    // always @(posedge clk)
    // begin
    //     if (reset)
    //         q <= 7'd1;
    //     else begin
    //         //x^7 + x^6 + 1
    //         q <= {q[5] ^ q[6], q[4], q[3], q[2], q[1], q[0], q[6]};
    //     end
    // end
endmodule

module s9234_scan(CK,  
  scan_en, bist_en,
  TPG_reset, COMP_reset,
  SI_chain1, SI_chain2, SI_chain3, SI_chain4, SI_chain5, SI_chain6, SI_chain7, 
  SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7, 
  g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,
  g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
  g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
  g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
  g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
  g639,g6728,g702,g705,g89,g94,g98);

input CK, scan_en, bist_en, TPG_reset, COMP_reset, SI_chain1, SI_chain2, SI_chain3, 
  SI_chain4, SI_chain5, SI_chain6, SI_chain7, 
  g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,
  g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,
  g41,g22,g44,g23;
output g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,
  g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,
  g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,
  g4104,g4107,g4098, SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7;

  wire [6:0] tpg_out;
  wire chain1, chain2, chain3, chain4, chain5, chain6, chain7;

  // BIST
  lfsr_tpg tpg(CK, TPG_reset, tpg_out[6], tpg_out);

  u_mux2 MUX_0(chain1, SI_chain1, tpg_out[0],  bist_en);
  u_mux2 MUX_1(chain2, SI_chain2, tpg_out[1],  bist_en);
  u_mux2 MUX_2(chain3, SI_chain3, tpg_out[2],  bist_en);
  u_mux2 MUX_3(chain4, SI_chain4, tpg_out[3],  bist_en);
  u_mux2 MUX_4(chain5, SI_chain5, tpg_out[4],  bist_en);
  u_mux2 MUX_5(chain6, SI_chain6, tpg_out[5],  bist_en);
  u_mux2 MUX_6(chain7, SI_chain7, tpg_out[6],  bist_en);

  // CUT
//   s9234_scan dft(CK,SI_chain1, SI_chain2, SI_chain3, SI_chain4, SI_chain5, SI_chain6, SI_chain7,scan_en,SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7,PI_g102,PI_g107,g1290,g1293,PI_g22,PI_g23,g2584,PI_g301,PI_g306,PI_g310,PI_g314,PI_g319,PI_g32,g3222,PI_g36,g3600,PI_g37,PI_g38,PI_g39,PI_g40,g4098,g4099,PI_g41,g4100,g4101,g4102,g4103,g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,PI_g42,g4307,g4321,PI_g44,g4422,PI_g45,PI_g46,PI_g47,g4809,g5137,g5468,g5469,PI_g557,PI_g558,PI_g559,PI_g560,PI_g561,PI_g562,PI_g563,PI_g564,PI_g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,PI_g639,g6728,PI_g702,PI_g705,PI_g89,PI_g94,PI_g98); 
  s9234_scan_internal dft(CK,chain1, chain2, chain3, chain4, chain5, chain6, chain7,scan_en,SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7,g102,g107,g1290,g1293,g22,g23,g2584,g301,g306,g310,g314,g319,g32,g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g639,g6728,g702,g705,g89,g94,g98); 

  

endmodule