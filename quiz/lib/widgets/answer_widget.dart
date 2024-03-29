import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final String answerText;
  final Function(String) onSelected;

  AnswerWidget({required this.answerText, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(answerText),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Text(
            answerText,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
