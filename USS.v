`define rmax 3'd2


module USS(S,
             USS_ctrl,
             coordinate_i,
             coordinate_c,
             U0,
             U1,
             U2);


  // ---------------------- input  ---------------------- //
  input [3:0]coordinate_i,coordinate_c;
  input [3:0]U0,U1,U2;
  input USS_ctrl;
  // ---------------------- output ---------------------- //
  output reg[3:0]S;

  // ---------------------- design ---------------------- //


  wire [2:0]dx,dy; //distance between winner and neuron
  wire [2:0]p_dx,p_dy;
  wire [2:0]r;     //r=radius

  assign dx=coordinate_i[3:2]-coordinate_c[3:2];
  assign dy=coordinate_i[1:0]-coordinate_c[1:0];

  //change to be positive
  assign p_dx=(dx[2])? ~dx+3'd1:dx;
  assign p_dy=(dy[2])? ~dy+3'd1:dy;

  assign r=p_dx[1:0]+p_dy[1:0];


  always@(*)
  begin
    if(USS_ctrl)
    begin
      S=4'd15; //not to update weight
    end
    else
    begin
      case(r)
        3'd0:
          S=U0;
        3'd1:
          S=U1;
        3'd2:
          S=U2; //r=r_max
        default:
          S=4'd15; //r>r_max
      endcase
    end
  end

endmodule


