import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception("File not found: $filePath");
    }

    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    return Quiz.fromJson(data);
  }

  void writeQuiz(Quiz quiz) {
    final file = File(filePath);
    final jsonString = jsonEncode(quiz.toJson());
    file.writeAsStringSync(jsonString);
  }
}
