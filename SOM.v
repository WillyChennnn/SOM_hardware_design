


`include "Neuron.v"
`include "Controller.v"
`include "comparator.v"
`include "USG.v"
`include "Nto1_mux.v"




module SOM(clk,
             rst,
             pixel,
             read_en,
             amem_addr,
             addr_mode,
             map_addr,
             ram_wr,
             ram_rd,
             winner_weight,
             done);
`include "./dat/weight.dat"
  //------------------input-------------------//
  input clk,rst;
  input [23:0]pixel;
  //------------------output------------------//
  output read_en;
  output [12:0]amem_addr; //256*32
  output addr_mode;
  output [17:0]map_addr; //128*128
  output ram_rd,ram_wr;
  output [23:0]winner_weight;
  output done;
  //--------------wire and reg----------------//

  wire op_wr;
  wire S_wr;
  wire [3:0]compare_en;
  wire [7:0]epoch;
  wire USS_ctrl;
  wire [3:0]winner_coordinate;
  wire [17:0]win_dist;
  wire [3:0]U0,U1,U2;
  //---------Neuron---------//
  wire [47:0]weight0,weight1,weight2,weight3,weight4,weight5,weight6,weight7;
  wire [47:0]weight8,weight9,weight10,weight11,weight12,weight13,weight14,weight15;

  wire [17:0]dist0,dist1,dist2,dist3,dist4,dist5,dist6,dist7,dist8,dist9,dist10;
  wire [17:0]dist11,dist12,dist13,dist14,dist15;

  wire [3:0]position0,position1,position2,position3,position4,position5,position6,position7;
  wire [3:0]position8,position9,position10,position11,position12,position13,position14,position15;

  wire [23:0]true_weight0,true_weight1,true_weight2,true_weight3,true_weight4,true_weight5,true_weight6,true_weight7;
  wire [23:0]true_weight8,true_weight9,true_weight10,true_weight11,true_weight12,true_weight13,true_weight14,true_weight15;

  //--------comparater------//
  wire [17:0]win_dist0,win_dist1,win_dist2,win_dist3,win_dist4,win_dist5,win_dist6,win_dist7;
  wire [17:0]win_dist8,win_dist9,win_dist10,win_dist11,win_dist12,win_dist13;
  wire [3:0]win_c0,win_c1,win_c2,win_c3,win_c4,win_c5,win_c6,win_c7;
  wire [3:0]win_c8,win_c9,win_c10,win_c11,win_c12,win_c13;


  // initial the weight
  assign weight0=w16;
  assign weight1=w17;
  assign weight2=w18;
  assign weight3=w19;
  assign weight4=w20;
  assign weight5=w21;
  assign weight6=w22;
  assign weight7=w23;
  assign weight8=w24;
  assign weight9=w25;
  assign weight10=w26;
  assign weight11=w27;
  assign weight12=w28;
  assign weight13=w29;
  assign weight14=w30;
  assign weight15=w31;


  Controller	Controller(.clk(clk),
                        .rst(rst),
                        .amem_addr(amem_addr),
                        .amem_en(read_en),
                        .addr_mode(addr_mode),
                        .map_addr(map_addr),
                        .ram_wr(ram_wr),
                        .ram_rd(ram_rd),
                        .op_wr(op_wr),
                        .S_wr(S_wr),
                        .compare_en(compare_en),
                        .epoch(epoch),
                        .USS_ctrl(USS_ctrl),
                        .done(done)
                       );

  Neuron	Neuron0(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight0),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist0),
                 .true_weight(true_weight0),
                 .coordinate_i({2'd0,2'd0}),
                 .position(position0),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );

  Neuron	Neuron1(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight1),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist1),
                 .true_weight(true_weight1),
                 .coordinate_i({2'd0,2'd1}),
                 .position(position1),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );

  Neuron	Neuron2(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight2),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist2),
                 .true_weight(true_weight2),
                 .coordinate_i({2'd0,2'd2}),
                 .position(position2),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron3(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight3),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist3),
                 .true_weight(true_weight3),
                 .coordinate_i({2'd0,2'd3}),
                 .position(position3),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron4(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight4),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist4),
                 .true_weight(true_weight4),
                 .coordinate_i({2'd1,2'd0}),
                 .position(position4),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron5(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight5),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist5),
                 .true_weight(true_weight5),
                 .coordinate_i({2'd1,2'd1}),
                 .position(position5),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron6(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight6),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist6),
                 .true_weight(true_weight6),
                 .coordinate_i({2'd1,2'd2}),
                 .position(position6),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron7(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight7),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist7),
                 .true_weight(true_weight7),
                 .coordinate_i({2'd1,2'd3}),
                 .position(position7),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron8(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight8),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist8),
                 .true_weight(true_weight8),
                 .coordinate_i({2'd2,2'd0}),
                 .position(position8),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron9(.clk(clk),
                 .rst(rst),
                 .initial_weight(weight9),
                 .pixel(pixel),
                 .S_wr(S_wr),
                 .op_wr(op_wr),
                 .total_dist(dist9),
                 .true_weight(true_weight9),
                 .coordinate_i({2'd2,2'd1}),
                 .position(position9),
                 .coordinate_c(winner_coordinate),
                 .USS_ctrl(USS_ctrl),
                 .U0(U0),
                 .U1(U1),
                 .U2(U2)
                );
  Neuron	Neuron10(.clk(clk),
                  .rst(rst),
                  .initial_weight(weight10),
                  .pixel(pixel),
                  .S_wr(S_wr),
                  .op_wr(op_wr),
                  .total_dist(dist10),
                  .true_weight(true_weight10),
                  .coordinate_i({2'd2,2'd2}),
                  .position(position10),
                  .coordinate_c(winner_coordinate),
                  .USS_ctrl(USS_ctrl),
                  .U0(U0),
                  .U1(U1),
                  .U2(U2)
                 );
  Neuron	Neuron11(.clk(clk),
                  .rst(rst),
                  .initial_weight(weight11),
                  .pixel(pixel),
                  .S_wr(S_wr),
                  .op_wr(op_wr),
                  .total_dist(dist11),
                  .true_weight(true_weight11),
                  .coordinate_i({2'd2,2'd3}),
                  .position(position11),
                  .coordinate_c(winner_coordinate),
                  .USS_ctrl(USS_ctrl),
                  .U0(U0),
                  .U1(U1),
                  .U2(U2)
                 );
  Neuron	Neuron12(.clk(clk),
                  .rst(rst),
                  .initial_weight(weight12),
                  .pixel(pixel),
                  .S_wr(S_wr),
                  .op_wr(op_wr),
                  .total_dist(dist12),
                  .true_weight(true_weight12),
                  .coordinate_i({2'd3,2'd0}),
                  .position(position12),
                  .coordinate_c(winner_coordinate),
                  .USS_ctrl(USS_ctrl),
                  .U0(U0),
                  .U1(U1),
                  .U2(U2)
                 );
  Neuron	Neuron13(.clk(clk),
                  .rst(rst),
                  .initial_weight(weight13),
                  .pixel(pixel),
                  .S_wr(S_wr),
                  .op_wr(op_wr),
                  .total_dist(dist13),
                  .true_weight(true_weight13),
                  .coordinate_i({2'd3,2'd1}),
                  .position(position13),
                  .coordinate_c(winner_coordinate),
                  .USS_ctrl(USS_ctrl),
                  .U0(U0),
                  .U1(U1),
                  .U2(U2)
                 );
  Neuron	Neuron14(.clk(clk),
                  .rst(rst),
                  .initial_weight(weight14),
                  .pixel(pixel),
                  .S_wr(S_wr),
                  .op_wr(op_wr),
                  .total_dist(dist14),
                  .true_weight(true_weight14),
                  .coordinate_i({2'd3,2'd2}),
                  .position(position14),
                  .coordinate_c(winner_coordinate),
                  .USS_ctrl(USS_ctrl),
                  .U0(U0),
                  .U1(U1),
                  .U2(U2)
                 );
  Neuron	Neuron15(.clk(clk),
                  .rst(rst),
                  .initial_weight(weight15),
                  .pixel(pixel),
                  .S_wr(S_wr),
                  .op_wr(op_wr),
                  .total_dist(dist15),
                  .true_weight(true_weight15),
                  .coordinate_i({2'd3,2'd3}),
                  .position(position15),
                  .coordinate_c(winner_coordinate),
                  .USS_ctrl(USS_ctrl),
                  .U0(U0),
                  .U1(U1),
                  .U2(U2)
                 );
  //-----------------------------stage1-----------------------------//
  comparator	comparater0(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist0),
                         .d2(dist1),
                         .coordinate1(position0),
                         .coordinate2(position1),
                         .winner_dist(win_dist0),
                         .winner_coordinate(win_c0)
                        );
  comparator	comparater1(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist2),
                         .d2(dist3),
                         .coordinate1(position2),
                         .coordinate2(position3),
                         .winner_dist(win_dist1),
                         .winner_coordinate(win_c1)
                        );
  comparator	comparater2(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist4),
                         .d2(dist5),
                         .coordinate1(position4),
                         .coordinate2(position5),
                         .winner_dist(win_dist2),
                         .winner_coordinate(win_c2)
                        );
  comparator	comparater3(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist6),
                         .d2(dist7),
                         .coordinate1(position6),
                         .coordinate2(position7),
                         .winner_dist(win_dist3),
                         .winner_coordinate(win_c3)
                        );
  comparator	comparater4(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist8),
                         .d2(dist9),
                         .coordinate1(position8),
                         .coordinate2(position9),
                         .winner_dist(win_dist4),
                         .winner_coordinate(win_c4)
                        );
  comparator	comparater5(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist10),
                         .d2(dist11),
                         .coordinate1(position10),
                         .coordinate2(position11),
                         .winner_dist(win_dist5),
                         .winner_coordinate(win_c5)
                        );
  comparator	comparater6(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist12),
                         .d2(dist13),
                         .coordinate1(position12),
                         .coordinate2(position13),
                         .winner_dist(win_dist6),
                         .winner_coordinate(win_c6)
                        );
  comparator	comparater7(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[3]),
                         .d1(dist14),
                         .d2(dist15),
                         .coordinate1(position14),
                         .coordinate2(position15),
                         .winner_dist(win_dist7),
                         .winner_coordinate(win_c7)
                        );
  //-------------------------------stage2-----------------------------//
  comparator	comparater8(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[2]),
                         .d1(win_dist0),
                         .d2(win_dist1),
                         .coordinate1(win_c0),
                         .coordinate2(win_c1),
                         .winner_dist(win_dist8),
                         .winner_coordinate(win_c8)
                        );
  comparator	comparater9(.clk(clk),
                         .rst(rst),
                         .compare_en(compare_en[2]),
                         .d1(win_dist2),
                         .d2(win_dist3),
                         .coordinate1(win_c2),
                         .coordinate2(win_c3),
                         .winner_dist(win_dist9),
                         .winner_coordinate(win_c9)
                        );
  comparator	comparater10(.clk(clk),
                          .rst(rst),
                          .compare_en(compare_en[2]),
                          .d1(win_dist4),
                          .d2(win_dist5),
                          .coordinate1(win_c4),
                          .coordinate2(win_c5),
                          .winner_dist(win_dist10),
                          .winner_coordinate(win_c10)
                         );
  comparator	comparater11(.clk(clk),
                          .rst(rst),
                          .compare_en(compare_en[2]),
                          .d1(win_dist6),
                          .d2(win_dist7),
                          .coordinate1(win_c6),
                          .coordinate2(win_c7),
                          .winner_dist(win_dist11),
                          .winner_coordinate(win_c11)
                         );
  //-----------------------------stage3---------------------------//
  comparator	comparater12(.clk(clk),
                          .rst(rst),
                          .compare_en(compare_en[1]),
                          .d1(win_dist8),
                          .d2(win_dist9),
                          .coordinate1(win_c8),
                          .coordinate2(win_c9),
                          .winner_dist(win_dist12),
                          .winner_coordinate(win_c12)
                         );
  comparator	comparater13(.clk(clk),
                          .rst(rst),
                          .compare_en(compare_en[1]),
                          .d1(win_dist10),
                          .d2(win_dist11),
                          .coordinate1(win_c10),
                          .coordinate2(win_c11),
                          .winner_dist(win_dist13),
                          .winner_coordinate(win_c13)
                         );
  //-----------------------------stage4---------------------------//
  comparator	final_comparater(.clk(clk),
                              .rst(rst),
                              .compare_en(compare_en[0]),
                              .d1(win_dist12),
                              .d2(win_dist13),
                              .coordinate1(win_c12),
                              .coordinate2(win_c13),
                              .winner_dist(win_dist),
                              .winner_coordinate(winner_coordinate)
                             );
  //-----------------------------USG------------------------------//
  USG	USG(.clk(clk),
          .rst(rst),
          .wr_en(S_wr),
          .win_dist(win_dist),
          .epoch(epoch),
          .U0(U0),
          .U1(U1),
          .U2(U2)
         );
  //---------------------------Nto1_mux---------------------------//
  Nto1_mux	Nto1_mux(.win_coordinate(winner_coordinate),
                    .weight0(true_weight0),
                    .weight1(true_weight1),
                    .weight2(true_weight2),
                    .weight3(true_weight3),
                    .weight4(true_weight4),
                    .weight5(true_weight5),
                    .weight6(true_weight6),
                    .weight7(true_weight7),
                    .weight8(true_weight8),
                    .weight9(true_weight9),
                    .weight10(true_weight10),
                    .weight11(true_weight11),
                    .weight12(true_weight12),
                    .weight13(true_weight13),
                    .weight14(true_weight14),
                    .weight15(true_weight15),
                    .win_weight(winner_weight)
                   );


endmodule

