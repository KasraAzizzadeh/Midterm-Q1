module testbench();
		reg signed [31:0] input_data;
    		wire signed [31:0] output_data;
    		reg [2:0] opcode;
    		wire overflow;
    		reg clock;	reg reset;
    		STACK_BASED_ALU #(32 , 16) stack (clock, reset, opcode, input_data,
									    output_data, overflow);
    		always
         		#5 clock = ~clock;

    		initial begin
			clock = 0;
        		reset = 1; #10;
			reset = 0; #10
			//PUSH TEST:
			input_data = 100000;	opcode = 3'b110;
			#10;
			$display("pushing 100000"); 	opcode = 3'b000;
			#10
			//PUSH TEST:
        		input_data = 12345;	opcode = 3'b110;
			#10;
        		$display("pushing 12345");	opcode = 3'b000;
			#10;
			//ADD TEST:
			opcode = 3'b100;
			#10;
			$display("result: %d, overflow: %d" , output_data , overflow);
			//MULTIPLY TEST:
			opcode = 3'b101;
			#10;
			$display("result: %d, overflow: %d" , output_data , overflow);
			//PUSH TEST:
			input_data = 1000000;	opcode = 3'b110;
			#10;
			$display("pushing 1000000");	opcode = 3'b000;
			//PUSH TEST:
			input_data = 3000000;	opcode = 3'b110;
			#10;
			$display("pushing 3000000");	opcode = 3'b000;
			opcode = 3'b101;
			#10
			//MULTIPLY TEST:
			opcode = 3'b101;
			#10;
			$display("result: %d, overflow: %d" , output_data , overflow);			
			#10;
			//POP TEST:
			opcode =  3'b111;
			#10;
			$display("result: %d, overflow: %d" , output_data , overflow);
			#10;
			$display("result: %d, overflow: %d" , output_data , overflow);
        		$stop;
    		end
endmodule

