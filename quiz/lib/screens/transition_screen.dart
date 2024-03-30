import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/screens/quiz_screen.dart';

class TransitionScreen extends StatelessWidget {
  final bool isCorrectAnswer;
  final Question nextQuestion;
  final Function(String) onAnswerSelected;

  TransitionScreen({
    required this.isCorrectAnswer,
    required this.nextQuestion,
    required this.onAnswerSelected,
    
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isCorrectAnswer ? Colors.green : Colors.red;
    String text = isCorrectAnswer ? 'Correct' : 'Incorrect';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Transition Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    Navigator.pop(context); // Kembali ke layar sebelumnya (misalnya, QuizScreen)
    // Navigasi ke halaman berikutnya (misalnya, QuizScreen) dengan menyediakan pertanyaan berikutnya
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => QuizScreen(nextQuestion: nextQuestion),
    settings: RouteSettings(arguments: nextQuestion),
  ),
);

  },
              child: Text('Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}