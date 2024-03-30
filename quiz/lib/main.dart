import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/screens/quiz_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menyiapkan nilai nextQuestion
    Question nextQuestion = Question(
      questionText: 'Pertanyaan selanjutnya?',
      options: ['Jawaban A', 'Jawaban B', 'Jawaban C'],
      correctAnswer: 'Jawaban A',
    );

    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(nextQuestion: nextQuestion), // Menggunakan nextQuestion saat membuat instance QuizScreen
    );
  }
}
