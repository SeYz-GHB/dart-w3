import 'package:my_first_project/ui/quiz_console.dart';
import 'package:my_first_project/domain/quiz.dart';
import 'package:my_first_project/data/quiz_repository.dart';

void main() {
  // Use absolute path
  QuizRepository repository = QuizRepository(r'D:\dartCADT\w3\1 - START CODE\lib\data\quiz.json');
  Quiz quiz = repository.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}