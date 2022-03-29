module comparator(clk,
                    rst,
                    compare_en,
                    d1,
                    d2,
                    coordinate1,
                    coordinate2,
                    winner_dist,
                    winner_coordinate
                   );

  //----------------input-----------------//
  input clk,rst;
  input compare_en;
  input [17:0]d1,d2;
  input [3:0]coordinate1,coordinate2;
  //----------------output----------------//
  output reg [17:0]winner_dist;
  output reg [3:0]winner_coordinate;
  //--------------reg and wire------------//
  wire [18:0]error;
  reg [3:0]buffer,buffer1;
  reg [17:0]dist_buffer,dist_buffer1;
  reg [17:0]win_dist;
  reg [3:0]win_coordinate;

  assign error=d1-d2;



  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      winner_dist<=18'd0;
      winner_coordinate<=4'd0;
    end
    else if(compare_en)
    begin
      winner_dist<=dist_buffer1;
      winner_coordinate<=buffer1;
    end
    else
    begin
    end
  end

  always@(*)
  begin
    if(error[18])
    begin
      win_dist=d1;
      win_coordinate=coordinate1;
    end
    else
    begin
      win_dist=d2;
      win_coordinate=coordinate2;
    end
  end

  //buffer
  always@(win_coordinate)
  begin
    buffer=~(win_coordinate);
    buffer1=~(buffer);
  end

  always@(win_dist)
  begin
    dist_buffer=~win_dist;
    dist_buffer1=~dist_buffer;
  end

endmodule
