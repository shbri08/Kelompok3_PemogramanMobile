import 'package:flutter/widgets.dart';
import 'package:get/get.dart'; 
import 'package:get/state_manager.dart';
import 'package:quiz_app/models/question.dart';//import question.dart
import 'package:quiz_app/pages/scorePage.dart';//import scorePage.dart 

//kelas yang mengatur logika kuis dan state terkait kuis
class QuizController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;//Deklarasi controller animasi 
  late Animation _animation;//Deklarasi animasi 

  Animation get animation => this._animation;//getter untuk animasi 

  late PageController _pageController;//deklarasi controller halaman
  PageController get pageController => this._pageController;//getter untuk controler halaman

//list pertanyaan dari data sempel 
  final List<Question> _questions = sample_data
    .map(
      (question) => Question(
        id: question['id'],
        image: question['image'],
        question: question['question'],
        options: question['options'] ?? [],
        answer: question['answer_index']),
    )
    .toList();

//getter untuk list pertanyaan 
  List<Question> get questions => this._questions;

  bool _isAnswered = false;//status pertanyaan sudah dijawab atau beum
  bool get isAnswered => this._isAnswered;//getter untuk status jawaban

  int _correctAns = 0 ;//jumlah jawaban yang benar
  int get correctAns => this._correctAns;//getter untuk jumlah jawaban yang benar

  int _selectedAns = 0;//jawaban yang dipilih oleh pengguna 
  int get selectedAns => this._selectedAns;//getter untuk jawaban yang dipilh

  final RxInt _questionNumber = 1.obs;//nomor pertanyaan 
  RxInt get questionNumber => this._questionNumber;//getter untuk jawaban yang dipilih 

  int _numOfCorrectAns = 0;//jumlah jawaban yang benar 
  int get numOfCorrectAns => this._numOfCorrectAns;//getter untuk jumlah jawaban yang benar

//metode yang dijalankan saat kelas diinisialisasi
  @override
  void onInit() {
    //inisialisasi controller animasi
    _animationController =
      AnimationController(duration: Duration(seconds: 20), vsync: this);
    //mendefinisikan animasi
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    //memulai dan memanggil metode nextQuestion 
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();//inisialisasi controller halaman
    super.onInit();
  }

  //metode dijalankan saat kelas ditutup
  @override
  void onClose() {
    super.onClose();
    //mematikan controller animasi dan halaman 
    _animationController.dispose();
    _pageController.dispose();
  }

  //metode untuk mengecek jawaban yang dipilih 
  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;//menandai jika jawaban benar
    _correctAns = question.answer;//menyimpan jawaban benar
    _selectedAns = selectedIndex;//menyimpan jawaban yang dipilih 

  //menambah jumlah jawaban benar 
    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }

  //menghentikan animasi dan memperbarui tampilan
    _animationController.stop();
    update();

  //memanggil metode nextQuestion setelah 1 detik
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  //metode beralih ke pertanyaan selanjutya
  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {//memeriksa pertanyaan yang belum di tampilkan
      _isAnswered = false;//menandai pertanyaan yang belum di jawab 
      _pageController.nextPage(//berpindah ke halaman berikutnya dengan animasi 
        duration: Duration(milliseconds: 250), curve: Curves.ease);

      _animationController.reset();//mengatur ulang controller animasi

      _animationController.forward().whenComplete(nextQuestion);//memulai animasi lagi dan memanggil nesxtQuestion
    } else {
      Get.to(ScorePage());//navigasi kehalaman skor 
    }
  }

  //Metode untuk memperbarui nomer pertanyaan
  void updateQuizNum(int index) {
    _questionNumber.value = index +1;
  }
}
