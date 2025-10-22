import 'package:my_first_project/ui/quiz_console.dart';
import '../domain/quiz.dart';
import '../data/quiz_repository.dart';

void main() {
  
  QuizRepository repository = QuizRepository('lib/data/quiz.json');
  Quiz quiz = repository.readQuiz();
  
 
  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}