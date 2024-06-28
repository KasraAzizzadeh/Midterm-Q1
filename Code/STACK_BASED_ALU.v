module STACK_BASED_ALU
			#(parameter n = 32 , parameter size = 16) 
			(input clock, input reset, input [2:0] opcode,
    			input signed [n - 1: 0] input_data,
    			output reg signed [n - 1: 0] output_data,
    			output reg overflow);

    		integer pointer;
    		reg signed [n - 1:0] stack [size - 1:0];

    		always @(posedge clock) begin
        		if (reset) begin
            			pointer = 0;
            			output_data = 0;
            			overflow = 0;
        		end else begin
            				if(opcode[2] != 0) begin
                				case (opcode[1:0])
                    					2'b00: begin // Opcode: 100 => Addition
								overflow = 0;
                        					if (pointer >= 2) begin
                            						output_data = stack[pointer - 1] + stack[pointer - 2];
									// check if the sign has changed:
                            						if ((stack[pointer - 1] > 0 && stack[pointer - 2] > 0 && output_data < 0) ||
                                					(stack[pointer - 1] < 0 && stack[pointer - 2] < 0 && output_data > 0))
                                						overflow = 1;
								end
                    					end
                    					2'b01: begin // Opcode: 101 => Multiply
								overflow = 0;
                        					if (pointer >= 2) begin
                            						output_data = stack[pointer - 1] * stack[pointer - 2];
									// check if the sign has changed:
                            						if (output_data / stack[pointer - 2] != stack[pointer - 1])
                                					overflow = 1;
								end
							end
                    					2'b10: begin // Opcode: 110 => Push
                        					if (pointer < size) begin
                            						stack[pointer] = input_data;
                            						pointer = pointer + 1;
                        					end
                    					end
                    					2'b11: begin // Opcode: 111 => Pop
								overflow = 0;
                        					if (pointer > 0) begin
                            						output_data = stack[pointer - 1]; 
                            						stack[pointer - 1] = {n{1'b0}};
                            						pointer = pointer - 1;
                        					end
                    					end
                				endcase
            				end
        		end
    		end


endmodule
