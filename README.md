# GF180 Blind Hangman Project

Author: Josue Guerra, Steven Conaway, Nicholas Palma, Jacob Bechtel, University of Notre Dame

Email:  jguerra4@nd.edu, sconawa2@nd.edu, npalma2@nd.edu, jbechte2@nd.edu

CSE 30342 - Digital Integrated Circuits - University of Notre Dame

Push Date: 12/11/2023

Our final project for the Digital Integrated Circuits class at the University of Notre Dame is a game called "Blind Hangman", where the user has 7 tries to guess a 5 letter word. The only feedback on their progress is whether or not they have made a correct guess for a given letter position.

To do this, a 16 state finite state machine was implemented. The game starts in the INIT_GAME state, where it sets the enble and select bits for the game. It then proceeds into the GEN_WORD state, which selects the word from the word ROM based on user input. After the word is selected, it moves to the GUESS state, where the user inputs the letter they guess. Then the FSM proceeds to move through the CHECK_GUESS states, CHECK_GUESS_0, CHECK_GUESS_1, CHECK_GUESS_2, CHECK_GUESS_3, and CHECK_GUESS_4. If the letter matches the letter in that position of the word, it will move to CORRECT_0, CORRECT_1, CORRECT_2, CORRECT_3, or CORRECT_4 from the associated CHECK_GUESS state. It passes back to GUESS from any CORRECT states. If the user guessed a letter not in the word, the FSM moves to the ALL_INCORRECT state. This state increments the tries register, which keeps track of how many incorrect letters the user guessed, like the hangman diagram in the classic game. If all the letters are correct, the FSM moves to the WIN state, and if the user guesses incorrectly seven times, the FSM moves to the LOSE state. It will then go back to the INIT_GAME state for the user to play again.

To implement letters, we used a custom 5 bit encoding for all lowercase English alphabet characters. The letter a is 00000, b is 00001, c is 00010, etc. This was used instead of ASCII to save space as no other characters were necessary for this project. The word ROM stores 64 twenty-five bit words to be selected by the user in the GEN_WORD state. These were generated using a python script and are stored in a text file which is read by verilog to create the ROM. Each words has no duplicate letters, as the FSM was not designed with that in mind.

The chip uses 12 input pins and 7 output pins. The 6 high input pins are used to select which word to play the game with. The next highest pin is the next state pin, which is turned on whenever the FSM needs to change states. The remaining 5 pins are the letter the user guesses using our custom 5 bit letter encoding. The highest output pin is set to one when the user loses the game and the second highest is set to one when the user wins the game. Otherwise, they will remain at zero. The remaining 5 pins turn on if the user correctly guesses the letter in that position. For example, if the word is Notre, if the user guesses an e, the lowest pin will turn to a one.
