import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Player {
  late String id;
  String name;
  int score;

  Player({required this.name, this.score = 0, String? id}) {
    this.id = id ?? uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score};
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      score: json['score'],
    );
  }
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
    String? id,
  }) {
    this.id = id ?? uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'choices': choices,
      'goodChoice': goodChoice,
      'points': point,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      point: json['points'],
    );
  }
}

class Answer {
  String questionId;
  String answerChoice;

  Answer({required this.questionId, required this.answerChoice});

  bool isGood(Quiz quiz) {
    final question = quiz.getQuestionById(questionId);
    return question != null && answerChoice == question.goodChoice;
  }

  Map<String, dynamic> toJson() {
    return {'questionId': questionId, 'answerChoice': answerChoice};
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionId: json['questionId'],
      answerChoice: json['answerChoice'],
    );
  }
}

class Quiz {
  late String id;
  List<Question> questions;
  List<Answer> answers;
  List<Player> players;
  int totalScore = 0;
  int fullPoint = 0;

  Quiz({
    required this.questions,
    this.answers = const [],
    this.players = const [],
    String? id,
  }) {
    this.id = id ?? uuid.v4();
    for (var q in questions) {
      fullPoint += q.point;
    }
  }

  void addAnswer(Answer answer) => answers.add(answer);
  void addPlayer(Player player) => players.add(player);

  Question? getQuestionById(String questionId) {
    return questions.firstWhere(
      (q) => q.id == questionId,
      orElse: () => Question(
          title: '', choices: [], goodChoice: '', point: 0, id: questionId),
    );
  }

  int getScoreInPercentage() {
    totalScore = 0;
    for (var ans in answers) {
      if (ans.isGood(this)) {
        var q = getQuestionById(ans.questionId);
        if (q != null) totalScore += q.point;
      }
    }
    return ((totalScore / fullPoint) * 100).toInt();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toJson()).toList(),
      'answers': answers.map((a) => a.toJson()).toList(),
      'players': players.map((p) => p.toJson()).toList(),
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      answers: (json['answers'] != null)
          ? (json['answers'] as List)
              .map((a) => Answer.fromJson(a))
              .toList()
          : [],
      players: (json['players'] != null)
          ? (json['players'] as List)
              .map((p) => Player.fromJson(p))
              .toList()
          : [],
    );
  }
}
