module addr_mux(addr_mode,
                  mem_addr,
                  controller_addr,
                  ram_a);

  //--------------------input--------------------//
  input addr_mode;
  input [17:0]mem_addr,controller_addr;
  //--------------------output-------------------//
  output [17:0]ram_a;


  assign ram_a=(addr_mode)?controller_addr:mem_addr;

endmodule
