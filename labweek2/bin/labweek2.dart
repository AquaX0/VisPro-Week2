import 'dart:math';
import 'dart:io';

class Hangman {
  List<String> words = [
    'Apple', 'Banana', 'Blue', 'Destruction', 'Security', 'Cat', 'Ear'
  ];
  List<String> letterGuess = [];
  List<String> letterSpace = [];
  int lives = 6;
  int lettersUsed = 0;
  int loopCheck = 0;

  late String randomWord;

  void initializeGame() {
    randomWord = words[Random().nextInt(words.length)].toUpperCase();
    letterGuess = List.filled(randomWord.length, '*');
    letterSpace = [];
    lives = 6;
    loopCheck = 0;
    lettersUsed = 0;
  }

  void startGame() {
    initializeGame();
    print('Welcome to hangman, let\'s start playing!');
    print(letterGuess.join());

    while (letterGuess.join() != randomWord && lives > 0) {
      stdout.write('Guess a letter: ');
      String? input = stdin.readLineSync();

      if (input == null || input.isEmpty) {
        print('Please enter a letter at a time, try again');
        continue;
      }
      input = input.toUpperCase();

      if (input.length != 1) {
        print('Please enter only one letter at a time, try again');
        continue;
      }

      if (!RegExp(r'^[A-Z]$').hasMatch(input)) {
        print('Incorrect character, retry');
        continue;
      }

      if (letterSpace.contains(input)) {
        print('You already chose this letter, try another one.');
        continue;
      }

      letterSpace.add(input);

      bool found = false;
      for (int i = 0; i < randomWord.length; i++) {
        if (randomWord[i] == input) {
          letterGuess[i] = input;
          found = true;
        }
      }

      if (found) {
        print('Correct! Next letter.');
      } else {
        lives--;
        print('Incorrect, try again. You have $lives lives left.');
      }

      print(letterGuess.join());
      print('Used letters: ${letterSpace.join(", ")}');
    }

    if (letterGuess.join() == randomWord) {
      print('Well done! The word was $randomWord');
    } else {
      print('No more lives, you lost! The word was $randomWord');
    }
  }
}

void main() {
  Hangman game = Hangman();
  game.startGame();
}