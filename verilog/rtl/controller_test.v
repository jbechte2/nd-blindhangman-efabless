module controller_test; 
 reg [5:0] _input;
 wire [6:0] _output;

 reg clk;
 reg rst;

 hangy uut (
    .clk(clk),
		.reset(rst),
		.chip_input(_input),
		.chip_output(_output)
 );


  task expect_val(input logic [6:0] compare_val); 
    $display("Expected value: %b", compare_val);
    if (_output !== compare_val) begin
      $display("Got value: %b", _output);
      $display("Test Failed");
      $finish;
    end
  endtask

  task expect_state(input logic [3:0] compare_state); 
    $display("Expected state: %b", compare_state);
    $display("In state %b", uut.controlly.state);
    if (uut.controlly.state !== compare_state) begin
      $display("Test Failed");
      $finish;
    end
  endtask

  initial begin //setting up clock 
    clk=0;
    rst=0;
    forever #5 begin
      clk = ~clk; 
    end
  end 

  
  initial begin //test bench for lose game 
// b01101 01110 10011 10001 00101
    $write("Testing Blind Hangman ");
    $write(" HangMan Game Starting "); #10 expect_val(5'b00000); expect_state(0); // init game
    // $write(" Generating Word..."); uut.daty.word=25'b0110101110100111000100101;  #10 expect_val (5'b00000); // notre
    $write(" this should generate word "); _input=6'b111111; #10 expect_val (5'b00000); expect_state(1); #10; expect_state(2);
    $write("\n");

	$write("an n?"); _input=6'b101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(5'b10000); expect_state(2); 
    $write("\n");
	$write("enter o"); _input=6'b101110;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(6); #10; expect_val(5'b11000); expect_state(2);
    $write("\n");
	$write("enter t"); _input=6'b110011;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(8); #10; expect_val(5'b11100); expect_state(2);
    $write("\n");
	$write("enter r"); _input=6'b110001;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(10); #10; expect_val(5'b11110); expect_state(2);
    $write("\n");
    $write("enter e"); _input=6'b100101;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(11); #10; expect_state(12); #10; expect_state(14); expect_val(7'b0111111); 
    $write("\n");
    
	$write("go back to init"); _input=6'b100000; #10; expect_state(0); expect_val(5'b00000); #10;  _input=0; expect_state(1); #10; expect_state(2);
	$write("\n");
	$write("enter a #1"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(2); 
	$write("\n");
	$write("enter a #2"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(2); 
	$write("\n");
	$write("enter a #3"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(2); 
	$write("\n");
	$write("enter a #4"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(2); 
	$write("\n");
	$write("enter a #5"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(2); 
	$write("\n");
	$write("enter a #6"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(2); 
	$write("\n");
	$write("enter a #7"); _input=6'b100000; #10; _input=0; expect_state(3); expect_val(5'b00000); #10; expect_state(5); expect_val(5'b00000); #10; expect_state(7); expect_val(5'b00000); #10; expect_state(9); expect_val(5'b00000); #10; expect_state(11); expect_val(5'b00000); #10; expect_state(13); expect_val(5'b00000); #10; expect_state(15); 
	$write("\ngame over\n");

	$write("go back to init"); _input=6'b100000; #10; expect_state(0); expect_val(5'b00000); #10;  _input=0; expect_state(1); #10; expect_state(2);
    
    #10; $finish;

  end

endmodule

    


  
    


    
    
  
