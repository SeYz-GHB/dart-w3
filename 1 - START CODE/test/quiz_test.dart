import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

main() {
  test('Quiz should calculate 100% score for all correct answers', () {
    List<Question> questions = [
      Question(
        title: 'what one is bigger country France or Russia? ',
        choices: ['Russia', 'France'],
        goodChoice: "Russia",
        point: 10,
      ),
      Question(
        title: "what country has the most history aura base on the size of land they got : ",
        choices: ['Mongolia', 'France', 'Russia', 'England'],
        goodChoice: 'Mongolia',
        point: 60
      )
    ];
    
    Quiz quiz = Quiz(questions: questions);
    
    quiz.addAnswer(Answer(question: questions[0], answerChoice: "Russia"));
    quiz.addAnswer(Answer(question: questions[1], answerChoice: 'France'));
    
    expect(quiz.getScoreInPercentage(), equals(100));
    expect(quiz.getScoreInPoint(),equals(60));
    
  });
  

}