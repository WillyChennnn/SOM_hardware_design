//*************************************************
//** Author: LPHP Lab
//** Project: Simple image processor
//**    			- Top Testbench
//*************************************************


`define input_file_name "Lenna512512.bmp"              // you should change the input image name by yourself
`define output_file_name "Lenna512512_results.bmp"     // you should change the output image name by yourself
`define size 262144                                     //default size is 480000 pixels
`define width 512                                       //default width is 800 pixels
`define height 512                                      //default height is 800 pixels

/////////////////////////////////////////////////////////
//													   //
//               Do not modify code below              //
//													   //
/////////////////////////////////////////////////////////

`timescale 1ns/10ps
`define period 20


`include "SOM.v"
`include "address_memory.v"
`include "RAM.v"
`include "addr_mux.v"

module SOM_tb();

  reg clk;
  reg rst;
  reg [7:0] data [`size*3+54:0];
  wire done;
  wire read_en;
  wire [12:0] amem_addr;
  wire [17:0]mem_addr,map_addr;
  wire [17:0]ram_a;
  wire addr_mode;
  wire [23:0]pixel,winner_weight;
  wire ram_rd,ram_wr;





  reg [23:0] tmp;

  integer file_handle;
  integer i,j,k,pointer,file_input;

  SOM SOM(.clk(clk),
          .rst(rst),
          .pixel(pixel),
          .read_en(read_en),
          .amem_addr(amem_addr),
          .addr_mode(addr_mode),
          .map_addr(map_addr),
          .ram_wr(ram_wr),
          .ram_rd(ram_rd),
          .winner_weight(winner_weight),
          .done(done)
         );

  address_mem address_mem(.read_en(read_en),
                          .amem_addr(amem_addr),
                          .ram_a(mem_addr)
                         );

  addr_mux	  addr_mux(.addr_mode(addr_mode),
                      .mem_addr(mem_addr),
                      .controller_addr(map_addr),
                      .ram_a(ram_a)
                     );
  ram ram(.clk(clk),
          .rst(rst),
          .ram_wr(ram_wr),
          .ram_rd(ram_rd),
          .ram_a(ram_a),
          .ram_q(pixel),
          .ram_d(winner_weight)
         );

  initial
  begin
    #(`period*0)
     file_input = $fopen(`input_file_name,"rb");
    file_handle = $fopen(`output_file_name,"wb");
    pointer = $fread(data, file_input);
    for(k=0;k<`size;k=k+1)
    begin
      ram.dram[k]={data[3*k+56],data[3*k+55],data[3*k+54]};
    end
    clk = 1;
    rst = 0;

    #(`period/2)
     rst = 1;

    #(`period/2)
     rst = 0;
  end

  always #(`period/2) clk = ~clk;


  //from the code of 2010 iVCAD
  always@(negedge clk)
  begin
    if(done==1)
    begin
      for (j=0;j<54;j=j+1)
      begin
        $fwrite(file_handle,"%c",data[j]);
      end
      for ( i=0 ; i<`size ; i=i+1)
      begin
        tmp=ram.dram[i];
        /*if( tmp==0 )
        begin
          tmp=1;
        end*/
        $fwrite(file_handle,"%c",tmp[7:0]);
        $fwrite(file_handle,"%c",tmp[15:8]);
        $fwrite(file_handle,"%c",tmp[23:16]);
        /*for (k=0;k<3;k=k+1)
        begin
          $fwrite(file_handle,"%c",tmp);
        end*/
      end
      $fclose(file_handle);
      $finish;
    end
  end

  initial
  begin
    $dumpfile("wave.vcd");
    $dumpvars(0, SOM_tb);
  end


  initial
  begin
`ifdef FSDB
    $fsdbDumpfile("top_tb.fsdb");
    $fsdbDumpvars;
`endif
	`ifdef VCD

    $dumpfile("top_tb.vcd");
    $dumpvars;
`endif

  end
  initial
  begin
    #15000000000 $finish;
  end

endmodule
