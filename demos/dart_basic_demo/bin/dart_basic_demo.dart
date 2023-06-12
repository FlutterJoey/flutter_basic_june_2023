void main(List<String> arguments) {
  print('Hello World');

  print(1 + 1);

  var myVar = 3.141592;

  var calculated = 2 / myVar;
  print(calculated);
}

void rockPaperScissors(String choice1, String choice2) {
  if (choice1 == choice2) {
    print('Its a draw');
  }
  if (choice1 == 'paper' && choice2 == 'rock') {
    print('choice 1 won');
  }
}
