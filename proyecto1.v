`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Adrián Castillo J
//           Carlos Carranza
// Create Date:    12:56:05 08/08/2015 
// Design Name: 
// Module Name:    proyecto1 
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
module proyecto1(

input [4:0] inp,     //Declaramos la entrada tipo bus de 4 bits inp
   input clock,          //Declaramos la entrada clk
   input clr,           //Declaramos la entrada clr
	input hu,
   //output [4:0] outp,   //Declaramos la salida tipo bus de 4 bits outp
	//output hu,
   output H,  //Declaramos la salida tipo bus de 4 bits outp
	output T,
	output wire alarm,
	output wire warning,
	output  [3:0] statuse,
	output a, b, c, d, e, f, g, dp, //the individual LED output for the seven segment along with the digital point
   output [3:0] an   // the 4 bit enable signal
	
   );

//wire [4:0] a;
wire hum;
reg hum1;
reg u;	
wire[4:0] outp1;
reg [4:0] delay1;       //Declaramos la conexion auxiliar tipo reg delay1
reg [4:0] delay2;       //Declaramos la conexion auxiliar tipo reg delay2
reg [4:0] delay3;       //Declaramos la conexion auxiliar tipo reg delay3


reg [5:0] outdeco;
   
 //listo
always @(posedge clock)
     if (clr)
        outdeco <= 6'h00;
     else 
        case (outp1)
            5'b00000  : outdeco <= 6'b000000;
            5'b00001  : outdeco <= 6'b000001;
            5'b00010  : outdeco <= 6'b000010;
            5'b00011  : outdeco <= 6'b000011;
            5'b00100  : outdeco <= 6'b000100;
            5'b00101  : outdeco <= 6'b000101;
            5'b00110  : outdeco <= 6'b000110;
            5'b00111  : outdeco <= 6'b000111;
				5'b01000  : outdeco <= 6'b001000;
            5'b01001  : outdeco <= 6'b001001;
            5'b01010  : outdeco <= 6'b010000;
            5'b01011  : outdeco <= 6'b010001;
				5'b01100  : outdeco <= 6'b010010;
            5'b01101  : outdeco <= 6'b010011;
				5'b01110  : outdeco <= 6'b010100;
            5'b01111  : outdeco <= 6'b010101;
            5'b10000  : outdeco <= 6'b010110;
				5'b10001  : outdeco <= 6'b010111;
            5'b10010  : outdeco <= 6'b011000;
				5'b10011  : outdeco <= 6'b011001;
            5'b10100  : outdeco <= 6'b100000;
				5'b10101  : outdeco <= 6'b100001;
            5'b10110  : outdeco <= 6'b100010;
            5'b10111  : outdeco <= 6'b100011;
				5'b11000  : outdeco <= 6'b100100;
            5'b11001  : outdeco <= 6'b100101;
				5'b11010  : outdeco <= 6'b100110;
				5'b11011  : outdeco <= 6'b100111;
				5'b11100  : outdeco <= 6'b101000;
            5'b11101  : outdeco <= 8'b101001;
            5'b11110  : outdeco <= 6'b110000;
				5'b11111  : outdeco <= 6'b110001;
            default : outdeco <= 6'b000000;
        endcase








always @(posedge clock or posedge clr) begin
   if(clr) begin        //Si se activa clr
      delay1<=0;        //el siguiente valor de delay1 sera 0
      delay2<=0;        //el siguiente valor de delay2 sera 0
      delay3<=0;        //el siguiente valor de delay3 sera 0
   end
   else begin           //De lo contrario
      delay1<=inp;      //el siguiente valor de delay1 sera inp
      delay2<=delay1;   //el siguiente valor de delay2 sera delay1
      delay3<=delay2;   //el siguiente valor de delay3 sera delay2
   end
end

//Si la entrada inp es 1 durante 3 ciclos de cclk  outp sera 1.

reg  dela1;       //Declaramos la conexion auxiliar tipo reg delay1
reg  dela2;       //Declaramos la conexion auxiliar tipo reg delay2
reg  dela3;       //Declaramos la conexion auxiliar tipo reg delay3

always @(posedge clock or posedge clr) begin
   if(clr) begin        //Si se activa clr
      dela1<=0;        //el siguiente valor de delay1 sera 0
      dela2<=0;        //el siguiente valor de delay2 sera 0
      dela3<=0;        //el siguiente valor de delay3 sera 0
   end
   else begin           //De lo contrario
      dela1<=hu;      //el siguiente valor de delay1 sera inp
      dela2<=dela1;   //el siguiente valor de delay2 sera delay1
      dela3<=dela2;   //el siguiente valor de delay3 sera delay2
   end
end


assign outp1 = delay1 & delay2 & delay3;   //outp sera 1 si delay1, delay2 y delay3 son 1.
assign H = dela1 & dela2 & dela3;   //outp sera 1 si delay1, delay2 y delay3 son 1.
assign T = u;


localparam bn1 = 5'b11101; //13
always @ (outp1,bn1)
	if (outp1>=bn1)
		u = 1'b1;
	else
		u = 1'b0;
		
	
// Instantiate the module
maquina estados (
    .T(T), 
    .H(H), 
    .clock(clock), 
    .reset(clr), 
    .alarm(alarm), 
    .warning(warning), 
    .status(statuse)
    );
	 
sevenseg entra (
    .clock(clock), 
    .reset(clr), 
    .in0(outdeco[3:0]), 
    .in1(outdeco[5:4]), 
    .in3(statuse), 
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp), //the individual LED output for the seven segment along with the digital point
	 .an(an) 
    );


endmodule
