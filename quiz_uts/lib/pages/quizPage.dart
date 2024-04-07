import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/quizController.dart';
import 'package:quiz_app/models/question.dart';
import 'package:websafe_svg/websafe_svg.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizController _controller = Get.put(QuizController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: _controller.nextQuestion, child: Text("Skip"))
        ],
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    QuizController _quizcontroller = Get.put(QuizController());
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
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                        "Pertanyaan ${_quizcontroller.questionNumber.value}",
                      style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: "/${_quizcontroller.questions.length}",
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
              SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _quizcontroller.pageController,
                  onPageChanged: _quizcontroller.updateQuizNum,
                  itemCount: _quizcontroller.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    key: ValueKey('question_card_$index'),
                    question: _quizcontroller.questions[index]),
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

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuizController _controller = Get.put(QuizController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          if (question.image != null && question.image!.isNotEmpty)
            Image.asset(
              question.image!,
              height: 125,
              width: 125,
            ),
          SizedBox(height: 15),
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
              press: () => _controller.checkAns(question, index),
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
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (qnController) {

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
