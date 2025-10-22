class Player {
  final String name;
  int score;
  Player({required this.name, this.score = 0});
}

class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
    required this.point,
  });
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() => answerChoice == question.goodChoice;
}

class Quiz {
  List<Question> questions;
  List<Answer> answers = [];
  List<Player> players = [];
  int totalSCore = 0;
  int fullPoint = 100;

  Quiz({required this.questions});

  void addAnswer(Answer answer) => answers.add(answer);
  void addPlayer(Player player) => players.add(player);

  int getScoreInPercentage() {
    totalSCore = 0;
    for (var ans in answers) {
      if (ans.isGood()) {
        totalSCore += ans.question.point;
      }
    }
    return ((totalSCore / fullPoint) * 100).toInt();
  }
}
