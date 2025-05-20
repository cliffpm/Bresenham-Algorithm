/* Given two points on the screen this module draws a line between
 * those two points by coloring necessary pixels
 *
 * Inputs:
 *   clk    - should be connected to a 50 MHz clock
 *   reset  - resets the module and starts over the drawing process
 *	 x0 	- x coordinate of the first end point
 *   y0 	- y coordinate of the first end point
 *   x1 	- x coordinate of the second end point
 *   y1 	- y coordinate of the second end point
 *
 * Outputs:
 *   x 		- x coordinate of the pixel to color
 *   y 		- y coordinate of the pixel to color
 *   done	- flag that line has finished drawing
 *
 */
module line_drawer(clk, reset, x0, y0, x1, y1, x, y, done);
	input logic clk, reset;
	input logic [10:0]	x0, y0, x1, y1;
	output logic done;
	output logic [10:0]	x, y;
	// declare states
	enum{init,load_steepSwap, do_steepSwap, load_revSwap, do_revSwap, calcdelta, drawing, finish} ps, ns; 
	logic signed [11:0] error;
	logic signed [11:0] deltax, deltay, x_counter, y_counter;
	logic signed [10:0] ystep, x0_r, y0_r, x1_r, y1_r,tempSteepX_0, tempSteepX_1, tempSteepY_0, tempSteepY_1, tempRevX_0, tempRevX_1, tempRevY_0, tempRevY_1;
	logic isSteep, revSwap;
	
	

  // isSteep is calculated using original input values (before any augmentation) so we can assign this combinationally.
  assign isSteep = ((y1 > y0 ? y1-y0: y0-y1) > (x1 > x0 ? x1-x0: x0-x1));
  


	//next state logic 
	always_comb begin 
		case(ps)
			init: begin 
                if (isSteep)
                // swap x's and y's
                ns = load_steepSwap;
                else if (x0 > x1)
                // swap coordinates
                ns = load_revSwap;
                else ns = calcdelta;
            end 
            load_steepSwap:
                ns = do_steepSwap;
            do_steepSwap:
                if (tempSteepX_0 > tempSteepX_1)
                ns = load_revSwap;
                else 
                ns = calcdelta;
            load_revSwap:
                ns = do_revSwap;
            do_revSwap:
                ns = calcdelta;
            calcdelta: ns = drawing;
            drawing: ns = (x_counter == x1_r) ? finish : drawing; // exit for loop condition
            finish: begin 
                ns = init;
            end 
		endcase 
	end // always_comb
    
	 // assigning done signal
    assign done = ps == finish;
	
	//present state logic 
	always_ff @(posedge clk) begin 
		if (reset)
			ps <= init;
		else ps <= ns;
	end 
	
	
	// datapath arithmetic operations in accordance with psuedo code
	always_ff @(posedge clk) begin 
		if (reset) begin 
     // not really necessary since ff block has not comb.
      x0_r <= 0;
      y0_r <= 0;
      x1_r <= 0;
      y1_r <= 0;
      x_counter <= 0;
      y_counter <= 0;
      deltax <= 0;
      deltay <= 0;
      error <= 0;
      ystep <= 0;
		end 
		else begin 
			case(ps)
				init: begin 
				  x0_r <= x0;
				  y0_r <= y0;
				  x1_r <= x1;
				  y1_r <= y1;		
				end 

				load_steepSwap: begin 
				  tempSteepX_0 <= y0_r;
				  tempSteepY_0 <= x0_r;

				  tempSteepX_1 <= y1_r;
				  tempSteepY_1 <= x1_r;
				end 

				do_steepSwap: begin 
				  x0_r <= tempSteepX_0;
				  y0_r <= tempSteepY_0;

				  x1_r <= tempSteepX_1;
				  y1_r <= tempSteepY_1;
				end 


				load_revSwap: begin 
				  tempRevX_0 <= x1_r;
				  tempRevY_0 <= y1_r;

				  tempRevX_1 <= x0_r;
				  tempRevY_1 <= y0_r;
				end 


				do_revSwap: begin 
					x0_r <= tempRevX_0;
					y0_r <= tempRevY_0;

					x1_r <= tempRevX_1;
					y1_r <= tempRevY_1;
				end 

				calcdelta: begin 
					deltax <= x1_r-x0_r;
					deltay <= ((y1_r > y0_r) ? y1_r - y0_r : y0_r - y1_r);
					// arithmetic right shift is equivalent to dividing by 2.
					error <= -((x1_r - x0_r) >>> 1);
					ystep <= (y0_r < y1_r) ? 1: -1;
					x_counter <= x0_r;
					y_counter <= y0_r;
					end 
					
				// for loop
				drawing: begin 
					if (isSteep) begin 
						x <= y_counter;
						y <= x_counter;
					end 
					else begin 
						x <= x_counter;
						y <= y_counter;
					end 
					// clever way to check error + deltay without needing to wait extra clock cycle
					if (error + deltay >= 0) begin 
						y_counter <= y_counter + ystep;
						error <= error + deltay - deltax;
					end 
					else error <= error + deltay;
					x_counter <= x_counter + 1;        
				end 
			endcase 
		end
	end  // always_ff
	
endmodule  // line_drawer