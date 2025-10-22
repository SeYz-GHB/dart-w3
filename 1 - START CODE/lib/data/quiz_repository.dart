// lib/data/quiz_repository.dart
import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {


    File file = File(filePath);
    String content = file.readAsStringSync();
    

    Map<String, dynamic> data = jsonDecode(content);

  
    List questionsJson = data['questions'];


    List<Question> questions = [];
    for (var q in questionsJson) {
      Question question = Question(
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        point: q['points'],
      );
      questions.add(question);
    }

    // Create and return Quiz
    Quiz quiz = Quiz(questions: questions);
    return quiz;
  }
}