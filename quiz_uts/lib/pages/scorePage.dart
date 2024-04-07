import 'package:flutter/material.dart'; 
import 'package:get/get.dart';//import get untuk manajemen state dan navigasi 
import 'package:quiz_app/constants.dart';//import file constants.dart
import 'package:quiz_app/controllers/quizController.dart';//import controller QuizControler

//widget untuk menamppilkan halaman scorr
class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //inisialisasi instance dari QuizController
    QuizController _qzController = Get.put(QuizController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            //menyusun widget secara vertikal
            children: [
              Spacer(flex: 5),
              //Text judul skor dengan gaya yang telah ditentukan 
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              // Tesk untuk menampilkan skor kuis
              Text(
                "${_qzController.numOfCorrectAns * 10}/${_qzController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 5),//untuk memberikan ruang kosong
            ],
          )
        ],
      ),
    );
  }
}
