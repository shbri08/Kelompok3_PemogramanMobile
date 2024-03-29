import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final int score;

  ResultWidget({required this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score',
            style: TextStyle(fontSize: 24),
          ),
          // You can add more widgets here to display additional information
        ],
      ),
    );
  }
}
