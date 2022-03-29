module Nto1_mux(win_coordinate,
				weight0,
				weight1,
				weight2,
				weight3,
				weight4,
				weight5,
				weight6,
				weight7,
				weight8,
				weight9,
				weight10,
				weight11,
				weight12,
				weight13,
				weight14,
				weight15,
				win_weight
				);
//-----------------------input--------------------//
input [3:0]win_coordinate; //16 neuron:4*4
input [23:0]weight0,weight1,weight2,weight3,weight4,weight5,weight6,weight7;
input [23:0]weight8,weight9,weight10,weight11,weight12,weight13,weight14,weight15;
//-----------------------output-------------------//
output reg [23:0]win_weight;



always@(*)begin
	case(win_coordinate)
		{2'd0,2'd0}:win_weight=weight0;
		{2'd0,2'd1}:win_weight=weight1;
		{2'd0,2'd2}:win_weight=weight2;
		{2'd0,2'd3}:win_weight=weight3;
		{2'd1,2'd0}:win_weight=weight4;
		{2'd1,2'd1}:win_weight=weight5;
		{2'd1,2'd2}:win_weight=weight6;
		{2'd1,2'd3}:win_weight=weight7;
		{2'd2,2'd0}:win_weight=weight8;
		{2'd2,2'd1}:win_weight=weight9;
		{2'd2,2'd2}:win_weight=weight10;
		{2'd2,2'd3}:win_weight=weight11;
		{2'd3,2'd0}:win_weight=weight12;
		{2'd3,2'd1}:win_weight=weight13;
		{2'd3,2'd2}:win_weight=weight14;
		{2'd3,2'd3}:win_weight=weight15;
		default:win_weight=24'd0;
	endcase
end

endmodule