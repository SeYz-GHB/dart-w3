import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  
  QuizConsole({required this.quiz});
  
  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    
    while (true) {
      stdout.write('Your name: ');
      String? name = stdin.readLineSync();
      
      if (name == null || name.trim().isEmpty) {
        print('--- Quiz Finished ---');
        break;
      }
      
      Player player = Player(name: name.trim());
      quiz.addPlayer(player);
      
      quiz.answers.clear();
      quiz.totalScore = 0;  
      
      for (var question in quiz.questions) {
        print('Question: ${question.title} ( ${question.point} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();
        
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(
            questionId: question.id, 
            answerChoice: userInput
          );
          quiz.addAnswer(answer);
        }
      }
      
      int scorePercent = quiz.getScoreInPercentage();
      player.score = quiz.totalScore; 
      
      print('${player.name}, your score in percentage: ${scorePercent} %');
      print('${player.name}, your score in points: ${player.score} %');
      
      for (var p in quiz.players) {
        print('Player: ${p.name}\t\tScore:${p.score}');
      }
    }
  }
}