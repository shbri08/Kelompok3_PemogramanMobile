import 'package:flutter/material.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/widgets/answer_widget.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(String) onAnswerSelected;

  QuestionWidget({required this.question, required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (question.imagePath.isNotEmpty)
          Image.asset(
            question.imagePath,
            height: 100,
            width: 100,
          ),
        Text(
          question.questionText,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        ...question.options.map((option) => AnswerWidget(
              answerText: option,
              onSelected: onAnswerSelected,
            )),
      ],
    );
  }
}
