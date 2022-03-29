module adder(r_dist,
			 g_dist,
			 b_dist,
			 tot_dist);

//--------------------input------------------//
input [15:0]r_dist,g_dist,b_dist;
//--------------------output-----------------//
output [17:0]tot_dist;
//-----------------reg and wire--------------//

assign tot_dist=r_dist+g_dist+b_dist;

endmodule