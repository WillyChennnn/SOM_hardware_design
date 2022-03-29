`define img_size 262144

module ram(clk,
             rst,
             ram_wr,
             ram_rd,
             ram_a,
             ram_q,
             ram_d);

  input clk,rst;
  input ram_wr,ram_rd;
  input [17:0]ram_a;
  input [23:0]ram_d;
  output reg[23:0]ram_q;

  reg [23:0]dram[0:`img_size-1];

  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      ram_q<=24'd0;
    end
    else if(ram_rd==1'b1&&(ram_a<`img_size))
    begin
      ram_q<=dram[ram_a];
    end
    else
    begin
    end
  end

  always@(posedge clk)
  begin
    if(ram_wr==1'b1&&(ram_a<`img_size))
    begin
      dram[ram_a]<=ram_d;
    end
    else
    begin
    end
  end

endmodule
