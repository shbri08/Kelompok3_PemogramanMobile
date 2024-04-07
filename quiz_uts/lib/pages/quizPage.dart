import 'package:flutter/material.dart';//package utama dari flutter untuk pengembangan UI
import 'package:flutter/rendering.dart';//package untuk mengakses metode rendering
import 'package:get/get.dart';//Package untuk manajemen state
import 'package:get/get_state_manager/get_state_manager.dart';//paket untuk manajemen state
import 'package:quiz_app/constants.dart';//file yang berisi konstanta-konstanta yang digunakan
import 'package:quiz_app/controllers/quizController.dart';//Controller untuk manajemen quiz
import 'package:quiz_app/models/question.dart';//Model untuk pertanyaan
import 'package:websafe_svg/websafe_svg.dart';//Package untuk memmuat gambar SVG

//Halaman utama quiz
class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizController _controller = Get.put(QuizController());//menginisialisasi ccontroller quiz
    return Scaffold(
      extendBodyBehindAppBar: true,//membuat konten halaman berada dibawah app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,//menghilangkan bayangan app bar
        actions: [
          TextButton(onPressed: _controller.nextQuestion, child: Text("Skip"))//tombol untuk melompati pertanyaan
        ],
      ),
      body: Body(),//tubuh quiz
    );
  }
}
//tubuh quiz
class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //menginisialisasi comtroller quiz
    QuizController _quizcontroller = Get.put(QuizController());//menginisialisasi ccontroller quiz
    return Stack(
      children: [
        // FractionallySizedBox(
        //   widthFactor: 1.0, heightFactor: 1.0, child: WebsafeSvg.asset("images/bg.svg", fit: BoxFit.fill,),
        // ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),//padding horizontal
                child: ProgressBar(),//menampilkan progres bar
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                        "Pertanyaan ${_quizcontroller.questionNumber.value}",//menampilkan nomor pertanyaan
                      style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: "/${_quizcontroller.questions.length}",//menampilkan total pertanyaan
                          style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: kSecondaryColor),
                        )
                      ]
                    ),
                  ),
                )
              ),
              SizedBox(height: kDefaultPadding),//spasi vertikal
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),//menghilangkan scroll
                  controller: _quizcontroller.pageController,//controller untuk pageview
                  onPageChanged: _quizcontroller.updateQuizNum,//Mengubah nomor pertanyaan saat halaman berubah
                  itemCount: _quizcontroller.questions.length,// Jumlah total pertanyaan
                  //kartu pertanyaan
                  itemBuilder: (context, index) => QuestionCard(
                    key: ValueKey('question_card_$index'),
                    question: _quizcontroller.questions[index]),//kartu pertanyaan
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required Key key,
    required this.question,
  }) : super(key: key);

  final Question question;//pertanyaan

  @override
  Widget build(BuildContext context) {
    QuizController _controller = Get.put(QuizController());//Menginisialisasi controller kuis
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),//margin horizontal
      padding: EdgeInsets.all(kDefaultPadding),//padding pada  konten baru
      decoration: BoxDecoration(
        color: Colors.white,//warna latar belakang kartu
        borderRadius: BorderRadius.circular(25),//membuat sudut karu bulat
      ),
      child: Column(
        children: [
          if (question.image != null && question.image!.isNotEmpty)
            Image.asset(
              question.image!,// Memuat gambar pertanyaan jika tersedia
              height: 125,//tinggi kamar
              width: 125,//lebar kamar
            ),
          SizedBox(height: 15),//spasi vertikal
          Text(
            question.question,
            style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => _controller.checkAns(question, index),//menandai jawaban
            ),
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    super.key,
    required this.text,
    required this.index,
    required this.press,
  });
  final String text;//teks opsi
  final int index;//indeks opsi
  final VoidCallback press;//fungsi saat opsi dipilih

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (qnController) {
      //fungsi untuk mendapatkan warna yang benar
        Color getTheRightColor() {
          if (qnController.isAnswered) {
            if (index == qnController.correctAns) {
              return kGreenColor;              
            } else if (index == qnController.selectedAns &&
                qnController.selectedAns != qnController.correctAns) {
                  return kRedColor;
            }
          }
          return kGrayColor;
        }
      //fungsi untuk mendapatkan ikon yang benar
        IconData getTheRightIcon() {
          return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap: press,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$text",
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: getTheRightColor() == kGrayColor
                      ? Colors.transparent
                      :getTheRightColor(),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: getTheRightColor()),
                  ),
                  child: getTheRightColor() == kGrayColor
                    ? null
                    : Icon(getTheRightIcon(), size: 16),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
//indikator proses
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50)
      ),
      child: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) {
          print(controller.animation.value);
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, Constraints) => Container(
                  width: Constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradient,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${(controller.animation.value * 20).round()} sec"),
                      WebsafeSvg.asset("images/clock.svg"),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
