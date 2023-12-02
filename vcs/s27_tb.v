`timescale 1ns / 1ps

module nm_testbench();

   reg CK, scan_in, scan_en, scan_out;  // Add new pins in your design
   reg [3:0] RAND;
   wire NOM_OUT, TEST_OUT;
   wire G0, G1, G2, G3;
   wire G17_orig;
   wire G17;
   integer f, i;


   // Original circuit
   s27 original(CK, G0, G1, G2, G3, G17_orig);

   // Your circuit
   s27_scan dft(CK, scan_en, scan_in, G0, G1, G2, G3, scan_out, G17); // Add new pins in your design

   assign {G0, G1, G2, G3} = RAND[3:0];
   assign NOM_OUT = G17_orig;
   assign TEST_OUT = G17;


   initial begin
      f = $fopen("output.txt","w");
      CK=0;
      scan_en=0;  // Configure the pins in your design
      scan_in=0;
      #20;

      for (i=0; i<100000; i=i+1) begin
         #5 CK=0;
         #5 RAND={$random,$random};
         #5 CK=1;
         // $fwrite(f, "%b\n", NOM_OUT^TEST_OUT);
         $fwrite(f, "%t\t%b\t%b\t%b\t%b\n", $time, RAND, NOM_OUT^TEST_OUT, NOM_OUT, TEST_OUT);
      end

      $fclose(f);
   end


endmodule // nm_testbench
