//# 36 inputs
//# 39 outputs
//# 211 D-type flipflops
//# 3570 inverters
//# 2027 gates (955 ANDs + 528 NANDs + 431 ORs + 113 NORs)
// bin_scan_in, scan_en, bin_scan_out, bout_scan_in, scan_en, bout_scan_out,
module s9234_scan_boundary(CK, test_en, SI_chain1, SI_chain2, SI_chain3, SI_chain4, SI_chain5, SI_chain6, SI_chain7, scan_en, SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7, 
  g102,g107,g1290,g1293,g22,g23,
  g2584,g301,g306,g310,g314,g319,g32, 
  g3222,g36,g3600,g37,g38,g39,g40,g4098,g4099,g41,g4100,g4101,g4102,g4103,
  g4104,g4105,g4106,g4107,g4108,g4109,g4110,g4112,g4121,g42,g4307,g4321,g44,
  g4422,g45,g46,g47,g4809,g5137,g5468,g5469,g557,g558,g559,g560,g561,g562,g563,
  g564,g567,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,
  g639,g6728,g702,g705,g89,g94,g98);

input CK, test_en, SI_chain1, SI_chain2, SI_chain3, SI_chain4, SI_chain5, SI_chain6, SI_chain7, scan_en, g89,g94,g98,g102,g107,g301,g306,g310,g314,g319,g557,g558,g559,g560,g561,g562,g563,g564,g705,g639,g567,g45,g42,g39,g702,g32,g38,g46,g36,g47,g40,g37,g41,g22,g44,g23;
output g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,g4104,g4107,g4098, SO_chain1, SO_chain2, SO_chain3, SO_chain4, SO_chain5, SO_chain6, SO_chain7;


wire In_SI_chain1, In_SI_chain2, In_SI_chain3, In_SI_chain4, In_SI_chain5, In_SI_chain6, In_SI_chain7;
wire In_SO_chain1, In_SO_chain2, In_SO_chain3, In_SO_chain4, In_SO_chain5, In_SO_chain6, In_SO_chain7;

wire i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31, i32, i33, i34, i35;

wire o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17, o18, o19, o20, o21, o22, o23, o24, o25, o26, o27, o28, o29, o30, o31, o32, o33, o34, o35, o36, o37, o38;


s9234_scan_internal internal(CK, In_SI_chain1, In_SI_chain2, In_SI_chain3, In_SI_chain4, In_SI_chain5, In_SI_chain6, In_SI_chain7, scan_en, In_SO_chain1, In_SO_chain2, In_SO_chain3, In_SO_chain4, In_SO_chain5, In_SO_chain6, In_SO_chain7, i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31, i32, i33, i34, i35, g2584,g3222,g3600,g4307,g4321,g4422,g4809,g5137,g5468,g5469,g5692,g6282,g6284,g6360,g6362,g6364,g6366,g6368,g6370,g6372,g6374,g6728,g1290,g4121,g4108,g4106,g4103,g1293,g4099,g4102,g4109,g4100,g4112,g4105,g4101,g4110,g4104,g4107,g4098);

  bscanff BIN_DFF_0   (CK, i0 , g89,  test_en, SI_chain1);
  bscanff BIN_DFF_1   (CK, i1 , g94,  test_en, i0 );
  bscanff BIN_DFF_2   (CK, i2 , g98,  test_en, i1 );
  bscanff BIN_DFF_3   (CK, i3 , g102, test_en, i2 );
  bscanff BIN_DFF_4   (CK, i4 , g107, test_en, i3 );
  bscanff BIN_DFF_5   (CK, i5 , g301, test_en, i4 );
  bscanff BIN_DFF_6   (CK, i6 , g306, test_en, SI_chain2 );
  bscanff BIN_DFF_7   (CK, i7 , g310, test_en, i6 );
  bscanff BIN_DFF_8   (CK, i8 , g314, test_en, i7 );
  bscanff BIN_DFF_9   (CK, i9 , g319, test_en, i8 );
  bscanff BIN_DFF_10  (CK, i10, g557, test_en, i9 );
  bscanff BIN_DFF_11  (CK, i11, g558, test_en, SI_chain3);
  bscanff BIN_DFF_12  (CK, i12, g559, test_en, i11);
  bscanff BIN_DFF_13  (CK, i13, g560, test_en, i12);
  bscanff BIN_DFF_14  (CK, i14, g561, test_en, i13);
  bscanff BIN_DFF_15  (CK, i15, g562, test_en, i14);
  bscanff BIN_DFF_16  (CK, i16, g563, test_en, SI_chain4);
  bscanff BIN_DFF_17  (CK, i17, g564, test_en, i16);
  bscanff BIN_DFF_18  (CK, i18, g705, test_en, i17);
  bscanff BIN_DFF_19  (CK, i19, g639, test_en, i18);
  bscanff BIN_DFF_20  (CK, i20, g567, test_en, i19);
  bscanff BIN_DFF_21  (CK, i21, g45,  test_en, SI_chain5);
  bscanff BIN_DFF_22  (CK, i22, g42,  test_en, i21);
  bscanff BIN_DFF_23  (CK, i23, g39,  test_en, i22);
  bscanff BIN_DFF_24  (CK, i24, g702, test_en, i23);
  bscanff BIN_DFF_25  (CK, i25, g32,  test_en, i24);
  bscanff BIN_DFF_26  (CK, i26, g38,  test_en, SI_chain6);
  bscanff BIN_DFF_27  (CK, i27, g46,  test_en, i26);
  bscanff BIN_DFF_28  (CK, i28, g36,  test_en, i27);
  bscanff BIN_DFF_29  (CK, i29, g47,  test_en, i28);
  bscanff BIN_DFF_30  (CK, i30, g40,  test_en, i29);
  bscanff BIN_DFF_31  (CK, i31, g37,  test_en, SI_chain7);
  bscanff BIN_DFF_32  (CK, i32, g41,  test_en, i31);
  bscanff BIN_DFF_33  (CK, i33, g22,  test_en, i32);
  bscanff BIN_DFF_34  (CK, i34, g44,  test_en, i33);
  bscanff BIN_DFF_35  (CK, i35, g23,  test_en, i34);

  assign In_SI_chain1 = i5;
  assign In_SI_chain2 = i10;
  assign In_SI_chain3 = i15;
  assign In_SI_chain4 = i20;
  assign In_SI_chain5 = i25;
  assign In_SI_chain6 = i30;
  assign In_SI_chain7 = i35;
  
  bscanff BOUT_DFF_0   (CK, o0 , g2584, test_en, In_SO_chain1);
  bscanff BOUT_DFF_1   (CK, o1 , g3222, test_en, o0 );
  bscanff BOUT_DFF_2   (CK, o2 , g3600, test_en, o1 );
  bscanff BOUT_DFF_3   (CK, o3 , g4307, test_en, o2 );
  bscanff BOUT_DFF_4   (CK, o4 , g4321, test_en, o3 );
  bscanff BOUT_DFF_5   (CK, o5 , g4422, test_en, In_SO_chain2);
  bscanff BOUT_DFF_6   (CK, o6 , g4809, test_en, o5 );
  bscanff BOUT_DFF_7   (CK, o7 , g5137, test_en, o6 );
  bscanff BOUT_DFF_8   (CK, o8 , g5468, test_en, o7 );
  bscanff BOUT_DFF_9   (CK, o9 , g5469, test_en, o8 );
  bscanff BOUT_DFF_10  (CK, o10, g5692, test_en, o9 );
  bscanff BOUT_DFF_11  (CK, o11, g6282, test_en, In_SO_chain3);
  bscanff BOUT_DFF_12  (CK, o12, g6284, test_en, o11);
  bscanff BOUT_DFF_13  (CK, o13, g6360, test_en, o12);
  bscanff BOUT_DFF_14  (CK, o14, g6362, test_en, o13);
  bscanff BOUT_DFF_15  (CK, o15, g6364, test_en, o14);
  bscanff BOUT_DFF_16  (CK, o16, g6366, test_en, o15);
  bscanff BOUT_DFF_17  (CK, o17, g6368, test_en, In_SO_chain4);
  bscanff BOUT_DFF_18  (CK, o18, g6370, test_en, o17);
  bscanff BOUT_DFF_19  (CK, o19, g6372, test_en, o18);
  bscanff BOUT_DFF_20  (CK, o20, g6374, test_en, o19);
  bscanff BOUT_DFF_21  (CK, o21, g6728, test_en, o20);
  bscanff BOUT_DFF_22  (CK, o22, g1290, test_en, o21);
  bscanff BOUT_DFF_23  (CK, o23, g4121, test_en, In_SO_chain5);
  bscanff BOUT_DFF_24  (CK, o24, g4108, test_en, o23);
  bscanff BOUT_DFF_25  (CK, o25, g4106, test_en, o24);
  bscanff BOUT_DFF_26  (CK, o26, g4103, test_en, o25);
  bscanff BOUT_DFF_27  (CK, o27, g1293, test_en, o26);
  bscanff BOUT_DFF_28  (CK, o28, g4099, test_en, o27);
  bscanff BOUT_DFF_29  (CK, o29, g4102, test_en, In_SO_chain6);
  bscanff BOUT_DFF_30  (CK, o30, g4109, test_en, o29);
  bscanff BOUT_DFF_31  (CK, o31, g4100, test_en, o30);
  bscanff BOUT_DFF_32  (CK, o32, g4112, test_en, o31);
  bscanff BOUT_DFF_33  (CK, o33, g4105, test_en, o32);
  bscanff BOUT_DFF_34  (CK, o34, g4101, test_en, In_SO_chain7);
  bscanff BOUT_DFF_35  (CK, o35, g4110, test_en, o34);
  bscanff BOUT_DFF_36  (CK, o36, g4104, test_en, o35);
  bscanff BOUT_DFF_37  (CK, o37, g4107, test_en, o36);
  bscanff BOUT_DFF_38  (CK, o38, g4098, test_en, o37);
  
  
  assign SO_chain1 = o4;
  assign SO_chain2 = o10;
  assign SO_chain3 = o16;
  assign SO_chain4 = o22;
  assign SO_chain5 = o28;
  assign SO_chain6 = o33;
  assign SO_chain7 = o38;


endmodule
