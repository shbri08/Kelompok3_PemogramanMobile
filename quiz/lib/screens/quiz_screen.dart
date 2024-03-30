import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/widgets/question_widget.dart';
import 'package:quiz/widgets/result_widget.dart'; // Import ResultWidget

class QuizScreen extends StatefulWidget {
  final Question nextQuestion; // Menambahkan parameter nextQuestion

  QuizScreen({required this.nextQuestion}); // Konstruktor dengan parameter nextQuestion

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;

  List<Question> _questions = [
    Question(
    questionText: 'Ada berapa Fakultas yang ada di UNESA?',
    options: ['10', '7','16', '20', '12'],
    correctAnswer: '10',
  ),
  Question(
    questionText: 'Unesa terbagi menjadi berapa kampus?',
    options: ['4', '5', '7', '3', '1'],
    correctAnswer: '3',
  ),
  Question(
    questionText: 'Dimana letak kampus terbaru UNESA?',
    options: ['Lidah wetan', 'Ketintang', 'Magetan', 'Surabaya', 'Gresik'],
    correctAnswer: 'Magetan',
  ),
  Question(
    questionText: 'Siapa nama bapak rektor UNESA?',
    options: ['Cak Hasan', 'Cak Husni', 'Cak Husain', 'Cak Hasna', 'Cak Haisan'],
    correctAnswer: 'Cak Hasan',
    imagePath: 'images/cakhasan.jpg'
  ),
  Question(
    questionText: 'Ada berapa fakultas di kampus ketintang?',
    options: ['7', '6', '5', '10', '11'],
    correctAnswer: '6',
  ),
  Question(
    questionText: 'Fakultas apa yang menaungi jenjang diploma?',
    options: ['FMIPA', 'FEB', 'VOKASI', 'Teknik', 'Fisipol'],
    correctAnswer: 'VOKASI',
  ),
  Question(
    questionText: 'Siapa dekan fakultas vokasi?',
    options: ['Dr. Bambang Sigit Widodo, M.Pd.', 'Prof. Dr. Wasis, M.Si.', 'Syafi’ul Anam, Ph.D', 'Prof. Dr. Muhamad Nursalim, M.Si.', 'Suprapto, S.Pd., M.T.,'],
    correctAnswer: 'Suprapto, S.Pd., M.T.,',
  ),
  Question(
    questionText: 'Tahun berapa fakultas vokasi berdiri?',
    options: ['2020', '2019', '2021', '2022', '2023'],
    correctAnswer: '2021',
  ),
  Question(
    questionText: 'Ada berapa prodi di fakultas vokasi ?',
    options: ['9', '8', '6', '10', '7'],
    correctAnswer: '10',
  ),
  Question(
    questionText: 'Ruang Tu berada di Gedung apa?',
    options: ['K2', 'K3', 'K6', 'K9', 'K10'],
    correctAnswer: 'K9',
  )
  ];

  void _answerQuestion(String selectedAnswer) {
    bool isCorrectAnswer = _questions[_currentIndex].correctAnswer == selectedAnswer;
    if (isCorrectAnswer) {
      _score++;
      _showAnswerDialog('Corrected', const Color.fromARGB(255, 37, 212, 42),);
    } else {
      _showAnswerDialog('Incorrect', Colors.red);
    }
  }

  void _showAnswerDialog(String message, Color color) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              decoration: TextDecoration.none,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 3.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  Timer(Duration(milliseconds: 1500), () {
    Navigator.of(context).pop();
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultWidget(score: _score),
          ),
        );
      }
    });
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: _currentIndex < _questions.length
          ? QuestionWidget(
              question: _questions[_currentIndex],
              onAnswerSelected: _answerQuestion,
            )
          : ResultWidget(score: _score),
    );
  }
}