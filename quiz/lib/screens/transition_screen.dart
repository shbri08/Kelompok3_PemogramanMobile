import 'package:flutter/material.dart';

class TransitionScreen extends StatelessWidget {
  final bool isCorrect;

  TransitionScreen({required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCorrect ? Icons.check : Icons.close,
              size: 50,
              color: isCorrect ? Colors.green : Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              isCorrect ? 'Correct!' : 'Wrong!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
