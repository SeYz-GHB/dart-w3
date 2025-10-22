// lib/domain/quiz.dart
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Player {
  String name;
  int score;
  
  Player({required this.name, this.score = 0});
}

class Question {
  late String id;  
  String title;
  List<String> choices;
  String goodChoice;
  int point;

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
    required this.point,
  }) {
    id = uuid.v4(); // Generate unique ID automatically
  }
}

class Answer {
  String questionId;
  String answerChoice;

  Answer({required this.questionId, required this.answerChoice});

  bool isGood(Quiz quiz) {
   
    for (var question in quiz.questions) {
      if (question.id == questionId) {
        return answerChoice == question.goodChoice;
      }
    }
    return false;
  }
}

class Quiz {
  late String id;  
  List<Question> questions;
  List<Answer> answers = [];
  List<Player> players = [];
  int totalSCore = 0;
  int fullPoint = 100;

  Quiz({required this.questions}) {
    id = uuid.v4(); 
    

    fullPoint = 0;
    for (var question in questions) {
      fullPoint = fullPoint + question.point;
    }
  }

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  Question? getQuestionById(String questionId) {
    for (var question in questions) {
      if (question.id == questionId) {
        return question;
      }
    }
    return null;
  }

  int getScoreInPercentage() {
    totalSCore = 0;
    
    for (var ans in answers) {
      if (ans.isGood(this)) {
        Question? q = getQuestionById(ans.questionId);
        if (q != null) {
          totalSCore += q.point;
        }
      }
    }
    
    return ((totalSCore / fullPoint) * 100).toInt();
  }
}