`default_nettype none

module user_proj_example #(
	parameter AWIDTH=5, DWIDTH=8, BITS = 16
)(

	`ifdef USE_POWER_PINS
		inout vdd,	// User area 1 1.8V supply
		inout vss,	// User area 1 digital ground
	`endif
	
    // Include the Caravel Ports to connect the inputs and outputs
    input wb_clk_i,
    input wb_rst_i,

    // IOs
    input  [5:0] io_in,
    output [6:0] io_out,
	  output [6:0] io_oeb,
);

	/* For mapping the wb_clk_i and wb_rst_i to our clk and rst */
  wire clk = wb_clk_i;
  wire rst = !wb_rst_i;
	
	/* Set io_oeb to 0 to ensure all outputs are active */
	assign io_oeb = 1'b0;

	hangy the_hangy(
		.clk(clk),
		.reset(rst),
		.chip_input(io_in),
		.chip_output(io_out)
	);

endmodule


// states and instructions

typedef enum logic [3:0] {INIT_GAME = 4'b0000, GEN_WORD, GUESS, 
                          CHECK_GUESS_0, CORRECT_0, 
                          CHECK_GUESS_1, CORRECT_1, 
                          CHECK_GUESS_2, CORRECT_2, 
                          CHECK_GUESS_3, CORRECT_3, 
                          CHECK_GUESS_4, CORRECT_4, 
                          ALL_INCORRECT, WIN, LOSE
                         } statetype;


// next = chip_input[5];
// input_char = chip_input[4:0];
// guessed_letters = chip_output[4:0];
// win = chip_output[14];
// lose = chip_output[15];
module hangy
             (input  logic             clk, reset, 
              input  [5:0] chip_input,
              output [6:0] chip_output);
  
  logic [4:0] input_char_eq_word;
  logic guessed_letters_is_done;
  logic tries_eq_7,
  logic s_tries, en_tries;
  logic [2:0] s_guessed_letters, en_guessed_letters;
  logic en_word_index;
  logic en_input_char;
  logic s_win, en_win;
  logic s_lose, en_lose;

  // chip input breakdown:
  logic next = chip_input[5];
  logic [4:0] input_char = chip_input[4:0];

  // chip output breakdown:
  assign chip_output[6:0] = {lose, win, guessed_letters};

  controller controlly (
    .clk(clk),
    .reset(reset),
    .next(next),
    .input_char_eq_word(input_char_eq_word),
    .guessed_letters_is_done(guessed_letters_is_done),
    .tries_eq_7(tries_eq_7),
    .s_tries(s_tries),
    .en_tries(en_tries),
    .s_guessed_letters(s_guessed_letters),
    .en_guessed_letters(en_guessed_letters),
    .en_word_index(en_word_index),
    .en_input_char(en_input_char),
    .s_win(s_win),
    .en_win(en_win),
    .s_lose(s_lose),
    .en_lose(en_lose)
  );

  datapath daty (
    .clk(clk),
    .rst(reset),
    .chip_input(chip_input),
    .s_tries(s_tries),
    .en_tries(en_tries),
    .s_guessed_letters(s_guessed_letters),
    .en_guessed_letters(en_guessed_letters),
    .en_word_index(en_word_index),
    .en_input_char(en_input_char),
    .s_win(s_win),
    .en_win(en_win),
    .s_lose(s_lose),
    .en_lose(en_lose),
    .guessed_letters(guessed_letters),
    .input_char_eq_word(input_char_eq_word),
    .guessed_letters_is_done(guessed_letters_is_done),
    .tries_eq_7(tries_eq_7),
    .win(win),
    .lose(lose)
  );

endmodule

module controller(input logic clk, reset, 
                  input  logic next, 
                  input  logic [4:0] input_char_eq_word,
                  input  logic guessed_letters_is_done,
                  input  logic tries_eq_7, 
                  output logic s_tries, en_tries,
                  output logic [2:0] s_guessed_letters, en_guessed_letters,
                  output logic en_word_index,
                  output logic en_input_char,
                  output logic s_win, en_win,
                  output logic s_lose, en_lose,
                  );

  statetype       state, next_state;
  
  always_ff @(posedge clk)
    if (reset) state <= INIT_GAME;
    else       state <= next_state;
    
  always_comb
    begin
      // start by setting all outputs to 0
      s_tries = 1'b0; 
      en_tries = 1'b0;

      s_guessed_letters = 3'b0;
      en_guessed_letters = 1'b0;

      en_word_index = 1'b0;

      en_input_char = 1'b0;

      s_win = 1'b0;
      en_win = 1'b0;

      s_lose = 1'b0;
      en_lose = 1'b0;

      case (state)
        INIT_GAME:      begin
                          s_tries = 1'b0;
                          en_tries = 1'b1;

                          s_guessed_letters = 3'b0;
                          en_guessed_letters = 1'b1;

                          s_win = 1'b0;
                          en_win = 1'b1;

                          s_lose = 1'b0;
                          en_lose = 1'b1;

                          if (next) next_state = GEN_WORD;
                          else next_state = INIT_GAME;
                        end
        GEN_WORD:       begin
                          en_word_index = 1'b1;
                          next_state = GUESS;
                        end
        GUESS:          begin
                          en_input_char = 1'b1;
                          if (next) next_state = CHECK_GUESS_0;
                          else next_state = GUESS;
                        end
        CHECK_GUESS_0:  begin 
                          if (input_char_eq_word[0]) next_state = CORRECT_0;
                          else next_state = CHECK_GUESS_1;
                        end
        CHECK_GUESS_1:  begin 
                          if (input_char_eq_word[1]) next_state = CORRECT_1;
                          else next_state = CHECK_GUESS_2;
                        end
        CHECK_GUESS_2:  begin 
                          if (input_char_eq_word[2]) next_state = CORRECT_2;
                          else next_state = CHECK_GUESS_3;
                        end
        CHECK_GUESS_3:  begin 
			                    if (input_char_eq_word[3]) next_state = CORRECT_3;
                          else next_state = CHECK_GUESS_4;
                        end
        CHECK_GUESS_4:  begin 
                          if (input_char_eq_word[4]) next_state = CORRECT_4;
                          else next_state = ALL_INCORRECT;
                        end
        CORRECT_0:      begin
                          s_guessed_letters = 3'b001;
                          en_guessed_letters = 1'b1;
                          if (guessed_letters_is_done) next_state = WIN;
                          else next_state = GUESS;
                        end
        CORRECT_1:      begin
                          s_guessed_letters = 3'b010;
                          en_guessed_letters = 1'b1;
                          if (guessed_letters_is_done) next_state = WIN;
                          else next_state = GUESS;
                        end
        CORRECT_2:      begin
                          s_guessed_letters = 3'b011;
                          en_guessed_letters = 1'b1;
                          if (guessed_letters_is_done) next_state = WIN;
                          else next_state = GUESS;
                        end
        CORRECT_3:      begin
                          s_guessed_letters = 3'b100;
                          en_guessed_letters = 1'b1;
                          if (guessed_letters_is_done) next_state = WIN;
                          else next_state = GUESS;
                        end
        CORRECT_4:      begin
                          s_guessed_letters = 3'b101;
                          en_guessed_letters = 1'b1;
                          if (guessed_letters_is_done) next_state = WIN;
                          else next_state = GUESS;
                        end
        ALL_INCORRECT:  begin
                          s_tries = 1'b1;
                          en_tries = 1'b1;
                          if (tries_eq_7) next_state = LOSE;
                          else next_state = GUESS;
                        end
        WIN:            begin
                          s_win = 1'b1;
                          en_win = 1'b1;
                          if (next) next_state = INIT_GAME;
                          else next_state = WIN;
                        end
        LOSE:           begin
                          s_lose = 1'b1;
                          en_lose = 1'b1;
                          if (next) next_state = INIT_GAME;
                          else next_state = LOSE;
                        end
        default: next_state = INIT_GAME; // should never happen
      endcase
    end
  
endmodule


module datapath #(parameter WIDTH = 8, REGBITS = 3)
                 (input  logic clk, rst,
                 input   logic [15:0] chip_input,

                  input logic s_tries, en_tries,
                  input logic [2:0] s_guessed_letters, en_guessed_letters,
                  input logic en_word_index,
                  input logic en_input_char,
                  input logic s_win, en_win,
                  input logic s_lose, en_lose,

                 output reg [4:0] guessed_letters,    // this is letter-by-letter

                 output reg [4:0] input_char_eq_word, // this is letter-by-letter
                 output reg guessed_letters_is_done,
                 output reg tries_eq_7, 

                 output reg win, 
                 output reg lose,
                 );

  reg [2:0] tries;

  always_comb 
    begin
      if (en_tries) begin
        if (s_tries) tries = tries + 1'b1;
        else tries = 1'b0;
      end
    end
  
  always_comb
    begin
      if (en_guessed_letters) begin
        case (s_guessed_letters)
          3'b000:  guessed_letters = 5'b00000;
          3'b001:  guessed_letters = guessed_letters | 5'b10000;
          3'b010:  guessed_letters = guessed_letters | 5'b01000;
          3'b011:  guessed_letters = guessed_letters | 5'b00100;
          3'b100:  guessed_letters = guessed_letters | 5'b00010;
          3'b101:  guessed_letters = guessed_letters | 5'b00001;
          default: guessed_letters = guessed_letters | 5'b00000;
        endcase
      end
    end 

  wire [5:0] random6;
  reg [5:0] word_index = 0;
  always_comb
    if (en_word_index) word_index = random6;
  
  // TODO: this
  // if wi = 0
  wire [24:0] word = words[24:0];
  // if wi = 1 [49:25]
  // if wi = 2 [74:50]
  // if wi = 3 [99:75]
  
  lfsr6 lfsr(
    .clk(clk),
    .q(word_index)
  );

  reg [4:0] input_char = 0;
  always_comb
    if (en_input_char) input_char = chip_input[4:0];
  
  always_comb 
    input_char_eq_word = {
      input_char == word[24:20],
      input_char == word[19:15],
      input_char == word[14:10],
      input_char == word[9:5],
      input_char == word[4:0],
    }
  

  always_comb 
    guessed_letters_is_done = (guessed_letters == 5'b11111);
  
  always_comb 
    tries_eq_7 = (tries == 3'b111);
  
  always_comb 
    if (en_win) win = s_win;

  always_comb 
    if (en_lose) lose = s_lose;  
endmodule

module lfsr6 (
 input clk,
 output reg [5:0] q);

 initial q = 6'd1;

 always @(posedge clk)
  q <= {q[4:0], q[5]^q[0]};

endmodule

/* End EFabless Harness project with `default_nettype wire */
`default_nettype wire
