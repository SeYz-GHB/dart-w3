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
      
      // Stop if name is empty
      if (name == null || name.trim().isEmpty) {
        print('--- Quiz Finished ---');
        break;
      }
      
      Player player = Player(name: name.trim());
      quiz.addPlayer(player);
      
      // Reset for new player
      quiz.answers.clear();
      quiz.totalSCore = 0;
      
      // Ask questions
      for (var question in quiz.questions) {
        print('Question: ${question.title} - ( ${question.point} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();
        
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          quiz.addAnswer(answer);
        }
      }
      
      // Calculate score
      int scorePercent = quiz.getScoreInPercentage();
      player.score = quiz.totalSCore;
      
      // Show player's result
      print('${player.name}, your score in percentage: ${scorePercent} %');
      print('${player.name}, your score in points: ${scorePercent} %');
      
      // Show scoreboard
      for (var p in quiz.players) {
        print('Player: ${p.name}\t\tScore:${p.score}');
      }
    }
  }
}