class Question {
  String questionText;
  List<String> options;
  String correctAnswer;
  String imagePath;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.imagePath = '',
  });
}
