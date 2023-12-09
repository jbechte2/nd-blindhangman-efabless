module controller_test; 



  reg [4:0] input_char_eq_word;
  wire      guessed_letters_is_done;
  wire      s_tries;
  wire      en_tries;
  wire  [2:0]    s_guessed_letters;
  wire  [2:0]    en_guessed_letters ; 
  wire      en_word_index;
  wire      en_input_char;
  wire      s_win;
  wire      en_win;
  wire      s_lose;
  wire      en_lose;

  controller controller_inst 

  (

    .input_char_eq_word (input_char_eq_word), 
    .guessed_letters_is_done (guessed_letters_is_done),
    .s_tries(s_tries),
    .en_tries(en_tries),
    .s_guessed_letters(s_guessed_letters),
    .en_guessed_letters(en_guessed_letters), 
    .en_word_index (en_word_index), 
    .en_input_char (en_input_char), 
    .s_win(s_win), 
    .en_win(en_win), 
    .s_lose(s_lose), 
    .en_lose(en_lose), 
    
  ); 

  task expect; 
    input [4:0] exp_out; 
    if ({input_char_eq_word, guessed_letters_is_done, s_tries, en_tries, s_guessed_letters, en_guessed_letters, en_word_index, en_input_char, s_win, en_win, s_lose, en_lose} !== exp_out) begin
      $display("\nTEST FAILED");
      $display("time\tinput_char_eq_word, guessed_letters_is_done, s_tries, en_tries, s_guessed_letters, en_guessed_letters, en_word_index, en_input_char, s_win, en_win, s_lose, en_lose");
      $display("====\t====== ===== ==== === == ===== ====== ==== ===== ====== ===== ==");
      $display("%0d\t%d      %b     %b    %b   %d  %d     %b      %b    %b     %b",
               $time, input_char_eq_word, guessed_letters_is_done, s_tries, en_tries, s_guessed_letters, en_guessed_letters, en_word_index, en_input_char, s_win, en_win, s_lose, en_lose 
              );
      $display("WANT\t                  %b   %b  %b     %b      %b   ",
               exp_out[4],exp_out[3],exp_out[2],exp_out[1],exp_out[0]);
      $finish;
    end
  endtask
  
  
  initial begin 

    


  
    


    
    
  
