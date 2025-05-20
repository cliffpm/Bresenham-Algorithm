/* This module is a pre-loaded ROM containing coordinate points 
		for a circle generated from a python script to load into the 
		Bresenham algorithm to display a circle on a display monitor.
		This module takes in a 6 bit addr used for reading different 
		buckets within the ROm, as well as the 11 bit outputs for each 
		resepective coordinates that will get passed into the algorithm
		(x0,y0, x1,y1).
*/
module circle_rom(input logic [5:0] addr,
						output logic [10:0] x0, y0, x1, y1);
	
	// dedicated ROM for each coordinate
	logic [10:0] x0_rom [0:35];
	logic [10:0] y0_rom [0:35];
	logic [10:0] x1_rom [0:35];
	logic [10:0] y1_rom [0:35];

	
	// loading pre-computed coordinates
	initial begin
	x0_rom[0] = 11'd420; y0_rom[0] = 11'd240;
	x1_rom[0] = 11'd417; y1_rom[0] = 11'd257;

	x0_rom[1] = 11'd417; y0_rom[1] = 11'd257;
	x1_rom[1] = 11'd411; y1_rom[1] = 11'd273;

	x0_rom[2] = 11'd411; y0_rom[2] = 11'd273;
	x1_rom[2] = 11'd402; y1_rom[2] = 11'd288;

	x0_rom[3] = 11'd402; y0_rom[3] = 11'd288;
	x1_rom[3] = 11'd390; y1_rom[3] = 11'd301;

	x0_rom[4] = 11'd390; y0_rom[4] = 11'd301;
	x1_rom[4] = 11'd376; y1_rom[4] = 11'd312;

	x0_rom[5] = 11'd376; y0_rom[5] = 11'd312;
	x1_rom[5] = 11'd360; y1_rom[5] = 11'd321;

	x0_rom[6] = 11'd360; y0_rom[6] = 11'd321;
	x1_rom[6] = 11'd343; y1_rom[6] = 11'd328;

	x0_rom[7] = 11'd343; y0_rom[7] = 11'd328;
	x1_rom[7] = 11'd325; y1_rom[7] = 11'd332;

	x0_rom[8] = 11'd325; y0_rom[8] = 11'd332;
	x1_rom[8] = 11'd306; y1_rom[8] = 11'd334;

	x0_rom[9] = 11'd306; y0_rom[9] = 11'd334;
	x1_rom[9] = 11'd286; y1_rom[9] = 11'd332;

	x0_rom[10] = 11'd286; y0_rom[10] = 11'd332;
	x1_rom[10] = 11'd268; y1_rom[10] = 11'd328;

	x0_rom[11] = 11'd268; y0_rom[11] = 11'd328;
	x1_rom[11] = 11'd250; y1_rom[11] = 11'd321;

	x0_rom[12] = 11'd250; y0_rom[12] = 11'd321;
	x1_rom[12] = 11'd234; y1_rom[12] = 11'd312;

	x0_rom[13] = 11'd234; y0_rom[13] = 11'd312;
	x1_rom[13] = 11'd220; y1_rom[13] = 11'd301;

	x0_rom[14] = 11'd220; y0_rom[14] = 11'd301;
	x1_rom[14] = 11'd208; y1_rom[14] = 11'd288;

	x0_rom[15] = 11'd208; y0_rom[15] = 11'd288;
	x1_rom[15] = 11'd199; y1_rom[15] = 11'd273;

	x0_rom[16] = 11'd199; y0_rom[16] = 11'd273;
	x1_rom[16] = 11'd193; y1_rom[16] = 11'd257;

	x0_rom[17] = 11'd193; y0_rom[17] = 11'd257;
	x1_rom[17] = 11'd190; y1_rom[17] = 11'd240;

	x0_rom[18] = 11'd190; y0_rom[18] = 11'd240;
	x1_rom[18] = 11'd193; y1_rom[18] = 11'd222;

	x0_rom[19] = 11'd193; y0_rom[19] = 11'd222;
	x1_rom[19] = 11'd199; y1_rom[19] = 11'd206;

	x0_rom[20] = 11'd199; y0_rom[20] = 11'd206;
	x1_rom[20] = 11'd208; y1_rom[20] = 11'd191;

	x0_rom[21] = 11'd208; y0_rom[21] = 11'd191;
	x1_rom[21] = 11'd220; y1_rom[21] = 11'd178;

	x0_rom[22] = 11'd220; y0_rom[22] = 11'd178;
	x1_rom[22] = 11'd234; y1_rom[22] = 11'd167;

	x0_rom[23] = 11'd234; y0_rom[23] = 11'd167;
	x1_rom[23] = 11'd250; y1_rom[23] = 11'd158;

	x0_rom[24] = 11'd250; y0_rom[24] = 11'd158;
	x1_rom[24] = 11'd268; y1_rom[24] = 11'd152;

	x0_rom[25] = 11'd268; y0_rom[25] = 11'd152;
	x1_rom[25] = 11'd286; y1_rom[25] = 11'd148;

	x0_rom[26] = 11'd286; y0_rom[26] = 11'd148;
	x1_rom[26] = 11'd306; y1_rom[26] = 11'd146;

	x0_rom[27] = 11'd306; y0_rom[27] = 11'd146;
	x1_rom[27] = 11'd325; y1_rom[27] = 11'd148;

	x0_rom[28] = 11'd325; y0_rom[28] = 11'd148;
	x1_rom[28] = 11'd343; y1_rom[28] = 11'd152;

	x0_rom[29] = 11'd343; y0_rom[29] = 11'd152;
	x1_rom[29] = 11'd360; y1_rom[29] = 11'd158;

	x0_rom[30] = 11'd360; y0_rom[30] = 11'd158;
	x1_rom[30] = 11'd376; y1_rom[30] = 11'd167;

	x0_rom[31] = 11'd376; y0_rom[31] = 11'd167;
	x1_rom[31] = 11'd390; y1_rom[31] = 11'd178;

	x0_rom[32] = 11'd390; y0_rom[32] = 11'd178;
	x1_rom[32] = 11'd402; y1_rom[32] = 11'd191;

	x0_rom[33] = 11'd402; y0_rom[33] = 11'd191;
	x1_rom[33] = 11'd411; y1_rom[33] = 11'd206;

	x0_rom[34] = 11'd411; y0_rom[34] = 11'd206;
	x1_rom[34] = 11'd417; y1_rom[34] = 11'd222;

	x0_rom[35] = 11'd417; y0_rom[35] = 11'd222;
	x1_rom[35] = 11'd420; y1_rom[35] = 11'd240;

	end // initial 
	
	// assigining coordinate values from resepective ROM.
	assign x0 = x0_rom[addr];
	assign y0 = y0_rom[addr];
	assign x1 = x1_rom[addr];
	assign y1 = y1_rom[addr];

endmodule //circle_rom 