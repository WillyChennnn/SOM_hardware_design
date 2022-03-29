`define img_size 262144
module Controller(clk,
                    rst,
                    amem_addr,
                    amem_en,
                    addr_mode,
                    map_addr,
                    ram_wr,
                    ram_rd,
                    op_wr,
                    S_wr,
                    compare_en,
                    epoch,
                    USS_ctrl,
                    done);

  //---------------------input-------------------//
  input clk,rst;
  //---------------------output------------------//
  output reg [12:0]amem_addr;
  output reg [17:0]map_addr;
  output reg [7:0]epoch;
  output reg [3:0]compare_en;
  output amem_en;
  output addr_mode;
  output ram_rd,ram_wr;
  output op_wr;
  output S_wr;
  output USS_ctrl;
  output done;
  //--------------------parameter----------------//
  parameter	INIT=4'd0,
            READ=4'd1,
            OP_1=4'd2,
            COMPARE_1=4'd3,
            UPDATE=4'd4,
            MAP_READ=4'd5,
            OP_2=4'd6,
            COMPARE_2=4'd7,
            MAP=4'd8,
            DONE=4'd9;
  //-----------------reg and wire-----------------//
  reg [3:0]state,n_state;
  reg [3:0]stage; //log2(N) N for neuron number
  reg [4:0]iteration;


  assign done=(state==DONE)?1'b1:1'd0;
  assign S_wr=(state==UPDATE)?1'b1:1'b0;
  assign op_wr=(state==OP_1)?1'b1:1'b0;
  assign ram_rd=(state==READ||state==MAP_READ)?1'b1:1'b0;
  assign ram_wr=(state==MAP)?1'b1:1'b0;
  assign amem_en=(state==READ)?1'b1:1'b0;
  assign addr_mode=(state==READ)?1'b0:1'b1; // 0: address from address_memory
  assign USS_ctrl=(epoch==8'd255&&iteration==5'd31)?1'b1:1'b0; //weight trained done

  //FSM
  always@(posedge clk or posedge rst)
  begin
    if(rst)
    begin
      state<=INIT;
    end
    else
    begin
      state<=n_state;
    end
  end
  always@(*)
  begin
    case(state)
      INIT:
      begin
        n_state=READ;
      end
      READ:
      begin
        n_state=OP_1;
      end
      OP_1:
      begin
        n_state=COMPARE_1;
      end
      COMPARE_1:
      begin
        if(stage==4'd3)
        begin
          n_state=UPDATE;
        end
        else
        begin
          n_state=COMPARE_1;
        end
      end
      UPDATE:
      begin
        if(epoch==8'd255&&iteration==5'd31)
        begin
          n_state=MAP_READ;
        end
        else
        begin
          n_state=READ;
        end
      end
      MAP_READ:
      begin
        n_state=OP_2;
      end
      OP_2:
      begin
        n_state=COMPARE_2;
      end
      COMPARE_2:
      begin
        if(stage==4'd3)
        begin
          n_state=MAP;
        end
        else
        begin
          n_state=COMPARE_2;
        end
      end
      MAP:
      begin
        if(map_addr==`img_size-1)
        begin
          n_state=DONE;
        end
        else
        begin
          n_state=MAP_READ;
        end
      end
      DONE:
      begin
        n_state=DONE;
      end
      default:
      begin
        n_state=DONE;
      end
    endcase
  end

  //iteration and epoch
  always@(posedge clk)
  begin
    if(state==INIT)
    begin
      iteration<=5'd0;
      epoch<=8'd0;
    end
    else if(n_state==READ)
    begin
      if(iteration==5'd31)
      begin
        iteration<=5'd0;
        epoch<=epoch+8'd1;
      end
      else
      begin
        iteration<=iteration+5'd1;
      end
    end
    else
    begin
    end
  end

  //amem_addr 0~8191
  always@(posedge clk)
  begin
    if(state==INIT)
    begin
      amem_addr<=13'd0;
    end
    else if(n_state==READ)
    begin
      amem_addr<=amem_addr+13'd1;
    end
    else
    begin
    end
  end

  //map_addr 0~16383
  always@(posedge clk)
  begin
    if(state==UPDATE)
    begin
      map_addr<=18'd0;
    end
    else if(n_state==MAP_READ)
    begin
      map_addr<=map_addr+18'd1;
    end
    else
    begin
    end
  end

  //stage
  always@(posedge clk)
  begin
    if(state==OP_1||state==OP_2)
    begin
      stage<=4'd0;
    end
    else if(n_state==COMPARE_1||n_state==COMPARE_2)
    begin
      stage<=stage+4'd1;
    end
    else
    begin
    end
  end

  //comparator mux enable
  always@(*)
  begin
    if(state==COMPARE_1||state==COMPARE_2)
    begin
      case(stage)
        4'd0:
          compare_en=4'b1000;
        4'd1:
          compare_en=4'b0100;
        4'd2:
          compare_en=4'b0010;
        4'd3:
          compare_en=4'b0001;
        default:
          compare_en=4'd0;
      endcase
    end
    else
    begin
      compare_en=4'd0;
    end
  end




endmodule
