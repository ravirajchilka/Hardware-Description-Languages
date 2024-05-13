
 module SPI_8bits_Moore(
    input wire clk,
    input wire rst,
    input wire tx_enable,
    output reg mosi,
    output reg cs,
    output wire sclk
);
 
    typedef enum logic [1:0] {
		idle = 0, 
		start_tx = 1, 
		tx_data = 2, 
		end_tx = 3 
		} state_type;

    state_type state, next_state;
   
   reg [7:0] din = 8'b00011000;
 
    reg spi_sclk = 0;
    reg [2:0] ccount = 0;
    reg [2:0] count = 0; // 0 -7 
    integer bit_count = 0;
  
 
////////////////////////next_State decoder
     always_comb begin
		case(state)
			idle : begin
				if(tx_enable)
					next_state = start_tx;
			end
			
			start_tx: begin
				if(count == 3'b111)
					next_state = tx_data;
			end
			
			tx_data : begin
				if(bit_count != 8) 
					next_state = tx_data;
				else
					next_state = end_tx;
			end
			
			end_tx: begin
				if(count == 3'b111)
					next_state = idle;
			end
		
			default :  next_state = idle;
		endcase
     end

  
  assign sclk = spi_sclk;
  
        
  /////////////////////sense reset
  
      always_ff@(posedge clk) begin
			if(rst)
				state <= idle;
			else
				state <= next_state;
      end
      

  /////////////////generating sclk  
   always_ff@(posedge clk)
      begin
		case(next_state)
			idle: begin
				spi_sclk <= 0;
				count <= 0;
				bit_count <= 0;
				mosi = 1'b0;
				cs   = 1'b1;
			end
			
			start_tx : begin
				cs = 1'b0;
				count <= count + 1;
				if(count < 3'b011 || count == 3'b111)
					spi_sclk <= 1'b1;
				else
					spi_sclk <= 1'b0;   
			end
			
			tx_data: begin
				mosi = din[7-bit_count];
				if(bit_count == 8) 
					mosi  = 1'b0;
				
				if(count < 3'b011 || count == 3'b111)
					spi_sclk <= 1'b1;
				else
					spi_sclk <= 1'b0; 

				if(bit_count != 8)
					if(count < 3'b111)
						count <= count + 1;
					else begin
						count <= 0;
						bit_count <= bit_count + 1;
					end
			end
			
			end_tx: begin
				cs = 1'b1;
				mosi = 1'b0;
				if(count < 3'b011 )
					spi_sclk <= 1'b1;
				else
					spi_sclk <= 1'b0; 

				count <= count + 1;
				bit_count <= 0;
			end
			
			default : begin
				count <= 0;
				bit_count <= 0;
				spi_sclk <= 1'b0;
			end
		
		endcase
     end
  
 
 endmodule
