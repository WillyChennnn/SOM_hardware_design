`define a_mem_size 8192

module address_mem(read_en,
                     amem_addr,
                     ram_a);

  input read_en;
  input [12:0] amem_addr;
  output reg [17:0]ram_a; //[13:7]=row,[6:0]=column

  reg [17:0]a_mem[0:`a_mem_size-1];
  wire [17:0]random_addr;


  assign random_addr=a_mem[amem_addr];

  always@(*)
  begin
    if(read_en==1'b1&&(amem_addr<`a_mem_size))
    begin
      ram_a=10'd512*random_addr[17:9]+random_addr[8:0]; // addr:128*row+col
    end
    else
    begin
      ram_a=18'd0;
    end
  end

  initial
  begin
    $readmemb("random_addr512512.dat", a_mem);
  end



endmodule
