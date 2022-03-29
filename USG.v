`define P  8
`define L0 1
`define L1 2
`define L2 3
`define V0 1
`define V1 2
`define V2 3
//`define TE 256

module USG(clk,
             rst,
             wr_en,
             win_dist,
             epoch,
             U0,
             U1,
             U2
            );

  // ---------------------- input  ---------------------- //
  input clk,rst;
  input wr_en;
  input [17:0]win_dist;
  input [7:0]epoch;   // training counter

  // ---------------------- output ---------------------- //
  output reg[3:0]U0,U1,U2;

  // ---------------------- design ---------------------- //
  reg [17:0]dc_bar;
  reg mux_sel;
  reg [7:0]I00,I10,I20;
  reg [8:0]I01,I11,I21;
  reg [3:0]limiter0,limiter1,limiter2;

  wire [17:0]avg_dist;
  wire [18:0]compartor;
  wire [7:0]count;
  wire [7:0]F;
  wire [17:0]avg_win,avg_dc;

  assign avg_win=win_dist>>1;
  assign avg_dc=dc_bar>>1;
  assign avg_dist=avg_win+avg_dc;
  assign compartor=win_dist-dc_bar; //dc-dc_bar
  assign count=epoch>>6; // TE/4=64 shift 6 bits
  assign F=8'd3-count;

  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      dc_bar<=18'd0;
    end
    else if(wr_en)
    begin
      dc_bar<=avg_dist;
    end
    else
    begin
    end
  end

  //compartor output
  always@(*)
  begin
    if(compartor[18])
    begin
      mux_sel=1'b1;
    end
    else
    begin
      mux_sel=1'b0;
    end
  end


  always@(epoch)
  begin
    I00=(epoch>>7)+8'd1;
    I01=I00-F;
    //pass by limiter
    if(I01[8])
    begin
      limiter0=4'd0;
    end
    else
    begin
      limiter0=I01[3:0];
    end
    //pass by mux
    case(mux_sel)
      1'b0:
        U0=I00[3:0];
      1'b1:
        U0=limiter0;
      default:
        U0=4'd0;
    endcase
  end

  always@(epoch)
  begin
    I10=(epoch>>6)+8'd2;
    I11=I10-F;
    //pass by limiter
    if(I11[8])
    begin
      limiter1=4'd0;
    end
    else
    begin
      limiter1=I11[3:0];
    end
    //pass by mux
    case(mux_sel)
      1'b0:
        U1=I10[3:0];
      1'b1:
        U1=limiter1;
      default:
        U1=4'd0;
    endcase
  end

  always@(epoch)
  begin
    I20=(epoch>>5)+8'd3;
    I21=I20-F;
    //pass by limiter
    if(I21[8])
    begin
      limiter2=4'd0;
    end
    else
    begin
      limiter2=I21[3:0];
    end
    //pass by mux
    case(mux_sel)
      1'b0:
        U2=I20[3:0];
      1'b1:
        U2=limiter2;
      default:
        U2=4'd0;
    endcase
  end

endmodule
