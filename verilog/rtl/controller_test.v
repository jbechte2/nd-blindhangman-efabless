module controller_test; 
 reg [11:0] _input;
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
    $display("Testing Blind Hangman ");
    $display(" HangMan Game Starting "); #10 expect_val(7'b0000000); expect_state(0); // init game
    // $display(" Generating Word..."); uut.daty.word=27'b000110101110100111000100101;  #10 expect_val (7'b0000000); // notre
    $display(" this should generate word "); _input=12'b000000111111; #10 expect_val (7'b0000000); expect_state(1); #10; expect_state(2);
    $display("\n");

	$display("an n?"); _input=12'b000000101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(7'b0010000); expect_state(2); 
    $display("\n");
	$display("enter o"); _input=12'b000000101110;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(6); #10; expect_val(7'b0011000); expect_state(2);
    $display("\n");
	$display("enter t"); _input=12'b000000110011;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(8); #10; expect_val(7'b0011100); expect_state(2);
    $display("\n");
	$display("enter r"); _input=12'b000000110001;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(10); #10; expect_val(7'b0011110); expect_state(2);
    $display("\n");
    $display("enter e"); _input=12'b000000100100;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(11); #10; expect_state(12); #10; expect_state(14); expect_val(7'b0111111); 
    $display("\n");
    
	$display("go back to init"); _input=12'b000000100000; #10; expect_state(0); expect_val(7'b0000000); #10;  _input=0; expect_state(1); #10; expect_state(2);
	$display("\n");
	$display("enter a #1"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #2"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #3"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #4"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #5"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #6"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #7"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); #10; expect_state(15);  expect_val(7'b1000000);
	$display("\ngame over\n");

        $display("go back to init"); _input=12'b000000100000; #10; expect_state(0); expect_val(7'b0000000); #10;  _input=0; expect_state(1); #10; expect_state(2);
	$display("\n");
	$display("enter a #1"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #2"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #3"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
	$display("an n?"); _input=12'b000000101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(7'b0010000); expect_state(2); 
    $display("\n");
	$display("enter a #4"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0010000); #10; expect_state(5); expect_val(7'b0010000); #10; expect_state(7); expect_val(7'b0010000); #10; expect_state(9); expect_val(7'b0010000); #10; expect_state(11); expect_val(7'b0010000); #10; expect_state(13); expect_val(7'b0010000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #5"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0010000); #10; expect_state(5); expect_val(7'b0010000); #10; expect_state(7); expect_val(7'b0010000); #10; expect_state(9); expect_val(7'b0010000); #10; expect_state(11); expect_val(7'b0010000); #10; expect_state(13); expect_val(7'b0010000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #6"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0010000); #10; expect_state(5); expect_val(7'b0010000); #10; expect_state(7); expect_val(7'b0010000); #10; expect_state(9); expect_val(7'b0010000); #10; expect_state(11); expect_val(7'b0010000); #10; expect_state(13); expect_val(7'b0010000); #10; expect_state(2); 
	$display("\n");
	$display("enter a #7"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0010000); #10; expect_state(5); expect_val(7'b0010000); #10; expect_state(7); expect_val(7'b0010000); #10; expect_state(9); expect_val(7'b0010000); #10; expect_state(11); expect_val(7'b0010000); #10; expect_state(13); #10; expect_state(15);  expect_val(7'b1010000);
	$display("\ngame over\n");

	$display("go back to init"); _input=12'b000000100000; #10; expect_state(0); expect_val(7'b0000000); #10;  _input=0; expect_state(1); #10; expect_state(2);
    $display("enter a #1"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0000000); #10; expect_state(5); expect_val(7'b0000000); #10; expect_state(7); expect_val(7'b0000000); #10; expect_state(9); expect_val(7'b0000000); #10; expect_state(11); expect_val(7'b0000000); #10; expect_state(13); expect_val(7'b0000000); #10; expect_state(2); 
	$display("\n");
    $display("an n?"); _input=12'b000000101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(7'b0010000); expect_state(2); 
    $display("\n");
	$display("enter o"); _input=12'b000000101110;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(6); #10; expect_val(7'b0011000); expect_state(2);
    $display("\n");
	$display("enter t"); _input=12'b000000110011;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(8); #10; expect_val(7'b0011100); expect_state(2);
    $display("\n");
	$display("enter r"); _input=12'b000000110001;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(10); #10; expect_val(7'b0011110); expect_state(2);
    $display("\n");
	$display("enter a #2"); _input=12'b000000100000; #10; _input=0; expect_state(3); expect_val(7'b0011110); #10; expect_state(5); expect_val(7'b0011110); #10; expect_state(7); expect_val(7'b0011110); #10; expect_state(9); expect_val(7'b0011110); #10; expect_state(11); expect_val(7'b0011110); #10; expect_state(13); expect_val(7'b0011110); #10; expect_state(2); 
	$display("\n");
    $display("enter e"); _input=12'b000000100100;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(11); #10; expect_state(12); #10; expect_state(14); expect_val(7'b0111111); 
    $display("\n");


    $display("go back to init"); _input=12'b1111111100000; #10; expect_state(0); expect_val(7'b0000000); #10;  _input=12'b111111000000; expect_state(1); #10; expect_state(2);
    $display("an n?"); _input=12'b111111101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(7'b0010000); expect_state(2); 
    $display("\n");
	$display("enter o"); _input=12'b111111101110;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(6); #10; expect_val(7'b0011000); expect_state(2);
    $display("\n");
	$display("enter t"); _input=12'b111111110011;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(8); #10; expect_val(7'b0011100); expect_state(2);
    $display("\n");
	$display("enter r"); _input=12'b111111110001;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(10); #10; expect_val(7'b0011110); expect_state(2);
    $display("\n");
    $display("enter a"); _input=12'b111111100000;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(11); #10; expect_state(12); #10; expect_state(14); expect_val(7'b0111111); 
    $display("\n");

    $display("go back to init"); _input=12'b1111111100000; #10; expect_state(0); expect_val(7'b0000000); #10;  _input=12'b111111000000; expect_state(1); #10; expect_state(2);
    $display("an n?"); _input=12'b111111101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(7'b0010000); expect_state(2); 
    $display("\n");
    $display("another n?"); _input=12'b111111101101;  #10; _input=0; expect_state(3); #10; expect_state(4); #10; expect_val(7'b0010000); expect_state(2); 
    $display("\n");
	$display("enter o"); _input=12'b111111101110;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(6); #10; expect_val(7'b0011000); expect_state(2);
    $display("\n");
	$display("enter t"); _input=12'b111111110011;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(8); #10; expect_val(7'b0011100); expect_state(2);
    $display("\n");
	$display("enter r"); _input=12'b111111110001;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(10); #10; expect_val(7'b0011110); expect_state(2);
    $display("\n");
    $display("enter a"); _input=12'b111111100000;  #10; _input=0; expect_state(3); #10; expect_state(5); #10; expect_state(7); #10; expect_state(9); #10; expect_state(11); #10; expect_state(12); #10; expect_state(14); expect_val(7'b0111111); 
    $display("\n");


    $display("it all worked, I guess");
    
    #10; $finish;

  end

endmodule

    


  
    


    
    
  
