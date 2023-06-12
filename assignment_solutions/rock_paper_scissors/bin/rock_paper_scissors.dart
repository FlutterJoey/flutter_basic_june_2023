void main(List<String> arguments) {
  print(rockPaperScissors('paper', 'rock'));
  print(rockPaperScissors('rock', 'paper'));
  print(rockPaperScissors('scissors', 'rock'));
  print(rockPaperScissors('rock', 'rock'));
  print(rockPaperScissors('paper', 'scissors'));
  print(rockPaperScissors('shotgun', 'scissors'));
}

String rockPaperScissors(String choice1, String choice2) {
  if (!isInputOkay(choice1)) {
    return 'Choice 1 was not correct';
  }
  if (!isInputOkay(choice2)) {
    return 'Choice 2 was not correct';
  }

  var choiceOneWin = 'Choice 1 wins';

  if (choice1 == choice2) {
    return 'It is a draw';
  }

  if (choice1 == 'rock' && choice2 == 'scissors') {
    return choiceOneWin;
  }
  if (choice1 == 'paper' && choice2 == 'rock') {
    return choiceOneWin;
  }
  if (choice1 == 'scissors' && choice2 == 'paper') {
    return choiceOneWin;
  }
  return 'Choice 2 wins';
}

bool isInputOkay(String input) {
  if (input == 'rock') {
    return true;
  }
  if (input == 'scissors') {
    return true;
  }
  if (input == 'paper') {
    return true;
  }
  return false;
}
