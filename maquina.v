`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Adrián Castillo J
//           Carlos Carranza
// Create Date:    14:44:25 08/08/2015 
// Design Name: 
// Module Name:    maquina 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module maquina(

input wire T,
input wire H,
input wire clock,
input wire reset,
output wire alarm,
output wire warning,
output reg [3:0] status
);

localparam state_I = 2'd0,
state_1 = 2'd1,
state_2 = 2'd2,
state_3 = 2'd3;

//definimos registros para estado actual y siguiente

reg [1:0] currentstate;
reg [1:0] nextstate;

//definimos las salidas

assign alarm = (status == 4'b0011);
assign warning = T + H ;

always @ (*) begin
	status = 4'b0000;

	case (currentstate)
	state_1: begin
		status = 4'b0001;
		end
	state_2: begin
		status = 4'b0010;
		
		end
	state_3 : begin
		status = 4'b0011;

		
		end
	endcase
end
//se viene la logica secuencial, para transiciones

always @ (posedge clock ) begin
	if (reset) currentstate <= state_I;
	else currentstate <= nextstate;
end
// las transiciones

always @ (*) begin
	nextstate = currentstate;
	case (currentstate)
	state_I : begin
		nextstate = state_1;
		end
	state_1 : begin
		if (T + H ) nextstate = state_2;
		end
	state_2 : begin
		if (T & H) nextstate = state_3;
		
		end
	endcase
end


endmodule
