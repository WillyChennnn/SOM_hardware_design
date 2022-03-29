module VEP(pixel,
             weight,
             shift,
             previous_dist,
             n_weight,
             n_dist,
             abs_dist
            );

  //--------------------input-------------------//
  input [7:0]pixel;
  input [15:0]weight; //8bits integer 8bits float
  input [3:0]shift;
  input [16:0]previous_dist;
  //--------------------output-------------------//
  output reg [15:0]n_weight;
  output [16:0]n_dist;   //range from -255~255
  output [15:0]abs_dist; //range from 0~255
  //--------------register and wire--------------//
  reg [16:0]correction;
  wire [16:0]p_correction;
  wire [16:0]p_dist;

  //check to be positive
  assign p_correction=(correction[16])? ~(correction)+17'd1:correction;
  assign p_dist=(n_dist[16])? ~(n_dist)+17'd1:n_dist;

  assign n_dist={pixel,8'd0}-n_weight;
  assign abs_dist=p_dist[15:0];

  //barrel shifter
  always@(*)
  begin
    case(shift)
      4'd0:
        correction=previous_dist;
      4'd1:
        correction=$signed(previous_dist)>>>1;
      4'd2:
        correction=$signed(previous_dist)>>>2;
      4'd3:
        correction=$signed(previous_dist)>>>3;
      4'd4:
        correction=$signed(previous_dist)>>>4;
      4'd5:
        correction=$signed(previous_dist)>>>5;
      4'd6:
        correction=$signed(previous_dist)>>>6;
      4'd7:
        correction=$signed(previous_dist)>>>7;
      4'd8:
        correction=$signed(previous_dist)>>>8;
      4'd9:
        correction=$signed(previous_dist)>>>9;
      4'd10:
        correction=$signed(previous_dist)>>>10;
      4'd11:
        correction=$signed(previous_dist)>>>11;
      4'd12:
        correction=$signed(previous_dist)>>>12;
      4'd13:
        correction=$signed(previous_dist)>>>13;
      4'd14:
        correction=$signed(previous_dist)>>>14;
      default:
        correction=17'd0;
    endcase
  end
  //n_weight
  always@(*)
  begin
    if(correction[16])
    begin
      n_weight=weight-p_correction[15:0];
    end
    else
      n_weight=weight+p_correction[15:0];
  end




endmodule

