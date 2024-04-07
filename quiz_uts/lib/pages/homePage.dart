import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/pages/quizPage.dart';
// import 'package:websafe_svg/websafe_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 8,),
                  Text(
                    "Quiziz Unesa",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text("Masukkan Nama"),
                    SizedBox(height: 12,),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1C2341),
                        hintText: "Nama",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        )
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => Get.to(QuizPage()),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding * 0.75),
                        decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Start Quiz",
                          style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Spacer(flex: 8,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}