

`include "VEP.v"
`include "adder.v"
`include "USS.v"

module Neuron(clk,
                rst,
                initial_weight,
                pixel,
                S_wr,
                op_wr,
                total_dist,
                true_weight,
                coordinate_i,
                position,
                coordinate_c,
                USS_ctrl,
                U0,
                U1,
                U2);

  //----------------------input------------------------//
  input clk,rst;
  input [47:0]initial_weight;
  input [23:0]pixel;
  input [3:0]coordinate_i;
  input [3:0]coordinate_c;
  input [3:0]U0,U1,U2;
  input USS_ctrl;
  input S_wr,op_wr;
  //----------------------output-----------------------//
  output reg [17:0]total_dist;
  output [3:0]position;
  output [23:0]true_weight;
  //---------------------wire and reg------------------//
  wire [15:0]r_in,g_in,b_in;
  wire [15:0]r_weight,g_weight,b_weight;
  wire [3:0] S_out,S_in;
  wire [16:0]r_dist_in,r_dist_out;
  wire [16:0]g_dist_in,g_dist_out;
  wire [16:0]b_dist_in,b_dist_out;
  wire [15:0]r_dist,g_dist,b_dist;
  wire [17:0]tot_dist;
  wire [7:0]true_red,true_green,true_blue;

  reg [15:0]r_reg,g_reg,b_reg;
  reg [16:0]r_dist_reg,g_dist_reg,b_dist_reg;
  reg [3:0]S_reg;
  reg [17:0]buffer,buffer1;

  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      r_reg<=initial_weight[47:32];
      g_reg<=initial_weight[31:16];
      b_reg<=initial_weight[15:0];
      r_dist_reg<=17'd0;
      g_dist_reg<=17'd0;
      b_dist_reg<=17'd0;
    end
    else if(op_wr)
    begin
      r_reg<=r_weight;
      g_reg<=g_weight;
      b_reg<=b_weight;
      r_dist_reg<=r_dist_out;
      g_dist_reg<=g_dist_out;
      b_dist_reg<=b_dist_out;
    end
    else
    begin
    end
  end

  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      total_dist<=18'd0;
    end
    else
    begin
      total_dist<=buffer1;
    end
  end

  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      S_reg<=4'd0;
    end
    else if(S_wr)
    begin
      S_reg<=S_out;
    end
    else
    begin
    end
  end

  assign r_in=r_reg;
  assign g_in=g_reg;
  assign b_in=b_reg;
  assign r_dist_in=r_dist_reg;
  assign g_dist_in=g_dist_reg;
  assign b_dist_in=b_dist_reg;
  assign S_in=S_reg;
  assign position=coordinate_i;

  //carry
  assign true_red=(r_reg[7])? r_reg[15:8]+8'd1:r_reg[15:8];
  assign true_green=(g_reg[7])? g_reg[15:8]+8'd1:g_reg[15:8];
  assign true_blue=(b_reg[7])? b_reg[15:8]+8'd1:b_reg[15:8];
  assign true_weight={true_red,true_green,true_blue};


  always@(tot_dist)
  begin
    buffer=~tot_dist;
    buffer1=~buffer;
  end

  VEP VEP_R (.pixel(pixel[23:16]),
             .weight(r_in),
             .shift(S_in),
             .previous_dist(r_dist_in),
             .n_weight(r_weight),
             .n_dist(r_dist_out),
             .abs_dist(r_dist)
            );

  VEP VEP_G (.pixel(pixel[15:8]),
             .weight(g_in),
             .shift(S_in),
             .previous_dist(g_dist_in),
             .n_weight(g_weight),
             .n_dist(g_dist_out),
             .abs_dist(g_dist)
            );

  VEP VEP_B (.pixel(pixel[7:0]),
             .weight(b_in),
             .shift(S_in),
             .previous_dist(b_dist_in),
             .n_weight(b_weight),
             .n_dist(b_dist_out),
             .abs_dist(b_dist)
            );

  adder adder(.r_dist(r_dist),
              .g_dist(g_dist),
              .b_dist(b_dist),
              .tot_dist(tot_dist)
             );

  USS USS(.U0(U0),
          .U1(U1),
          .U2(U2),
          .USS_ctrl(USS_ctrl),
          .coordinate_i(coordinate_i),
          .coordinate_c(coordinate_c),
          .S(S_out)
         );

endmodule
