// primitives.v
// Holds pre-designed primitives

primitive udff_r(q, clock, reset_l, data);

   output q; reg q;
   input  clock, reset_l, data;

   table
      // obtain output on rising edge of clock
      // clock reset_l data q q+
      (01) 1 0 : ? : 0 ;
      (01) 1 1 : ? : 1 ;
      (0?) 1 1 : 1 : 1 ;
      (0?) 1 0 : 0 : 0 ;
      // asynchronous reset_l
      ? 0 ? : ? : 0 ;
      // ignore rising edge of reset_l
      ? R ? : ? : - ;
      // ignore negative edge of clock
      F 1 ? : ? : - ;
      // ignore data changes on steady clock
      ? 1 (??) : ? : - ;
   endtable

endprimitive // udff_r


`timescale 1ns / 1ps
`celldefine
module dff_r(q, clock, reset_l, data);
   input clock, reset_l, data;
   output q;

   udff_r(q, clock, reset_l, data);

   specify
      // arc clock --> q
      (posedge clock => ( q +: data )) = (0.1, 0.1);
   endspecify

endmodule // dff_r
`endcelldefine


primitive udff(q, clock, data);

   output q; reg q;
   input  clock, data;

   table
      // obtain output on rising edge of clock
      // clock data q q+
      (01) 0 : ? : 0 ;
      (01) 1 : ? : 1 ;
      (0?) 1 : 1 : 1 ;
      (0?) 0 : 0 : 0 ;
      // ignore negative edge of clock
      F ? : ? : - ;
      // ignore data changes on steady clock
      ? (??) : ? : - ;
   endtable

endprimitive // u_dff


primitive dff(q, clock,  data);
   output q; reg q;
   input  clock, data;

   table
      // obtain output on rising edge of clock
      // clock data q q+
      (01) 0 : ? : 0 ;
      (01) 1 : ? : 1 ;
      (0?) 1 : 1 : 1 ;
      (0?) 0 : 0 : 0 ;
      // ignore negative edge of clock
      F ? : ? : - ;
      // ignore data changes on steady clock
      ? (??) : ? : - ;

   endtable
endprimitive // dff

`celldefine
module scanff(CK, Q, D, SE, SI);
   input CK, D, SI, SE;
   output Q;
   wire   a;
   dff  DFF0(Q, CK, a);
   u_mux2  MUX0(a, D, SI, SE);

endmodule // scanff
`endcelldefine

`celldefine
module bscanff(CK, a, D, SE, SI);
   input CK, D, SI, SE;
   output a;
   // output Q;
   dff  DFF0(Q, CK, SI);
   u_mux2  MUX0(a, D, Q, SE);

endmodule // scanff
`endcelldefine

module u_mux2(out, in0, in1, sel);
   output out;
   input in0, in1, sel;

   wire  nsel, w1, w0;
   not NOT0(nsel, sel);

   and AND0(w0, nsel, in0);
   and AND1(w1, sel, in1);

   or OR0(out, w1, w0);
endmodule // u_mux2