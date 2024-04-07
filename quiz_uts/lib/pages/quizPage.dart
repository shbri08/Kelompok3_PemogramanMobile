import 'package:flutter/material.dart';//package utama dari flutter untuk pengembangan UI
import 'package:flutter/rendering.dart';//package untuk mengakses metode rendering
import 'package:get/get.dart';//Package untuk manajemen state
import 'package:quiz_app/constants.dart';//file yang berisi konstanta-konstanta yang digunakan
import 'package:quiz_app/controllers/quizController.dart';//Controller untuk manajemen quiz
import 'package:quiz_app/models/question.dart';//Model untuk pertanyaan
import 'package:websafe_svg/websafe_svg.dart';//Package untuk memmuat gambar SVG

//Halaman utama quiz
class QuizPage extends StatelessWidget {//deklarasi class QuizPage menurunkan sifat statelesswideget yaitu tidak memiliki state yang berubah
  const QuizPage({super.key});//parameter dari quiz[age

  @override
  Widget build(BuildContext context) {
    QuizController _controller = Get.put(QuizController());//menginisialisasi ccontroller quiz
    return Scaffold(
      extendBodyBehindAppBar: true,//membuat konten halaman berada dibawah app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,// Menghilangkan warna latar belakang app bar
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
class Body extends StatelessWidget {//deklarasi class body menurunkan sifat statelesswideget yaitu tidak memiliki state yang berubah
  const Body({super.key,});//konstruktor class body dengan parameter key

  @override//artinya mendefinisikan kembali
  Widget build(BuildContext context) {//mengembalikan widget yang akan dirender oleh framework Flutter berdasarkan kondisi saat itu dan konteks aplikasi yang diberikan.
    //menginisialisasi comtroller quiz
    QuizController _quizcontroller = Get.put(QuizController());//menginisialisasi ccontroller quiz
    return Stack(
      children: [
        // FractionallySizedBox(
        //   widthFactor: 1.0, heightFactor: 1.0, child: WebsafeSvg.asset("images/bg.svg", fit: BoxFit.fill,),
        // ),
        SafeArea(//memastikan bahwa konten yang ditampilkan berada dalam area yang aman
          child: Column(//menempatkan widget secara vertikal dalam satu kolom.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(//menambahkan ruang kosong di sekeliling widget anaknya.
                padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),//padding horizontal
                child: ProgressBar(),//menampilkan progres bar
              ),
              SizedBox(height: kDefaultPadding),// Memberikan spasi vertikal menggunakan nilai padding default
              Padding(//menambahkan ruang kosong di sekeliling widget anaknya
                padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),// Menambahkan padding horizontal dengan nilai default
                child: Obx(// widget yang mengamati perubahan pada variabel yang diobservasi (observable) dalam controller kuis
                  () => Text.rich(//menampilkan teks yang terdiri dari beberapa gaya teks (rich text)
                    TextSpan(//menentukan berbagai gaya teks dalam satu teks.
                      text:
                        "Pertanyaan ${_quizcontroller.questionNumber.value}",//menampilkan nomor pertanyaan
                      style: Theme.of(context)//mengakses gaya teks dari tema aplikasi untuk judul 5, yang kemudian diberi warna sekunder
                        .textTheme
                        .headline4
                        ?.copyWith(color: kSecondaryColor),// Mengatur gaya teks untuk nomor pertanyaan
                      children: [
                        TextSpan(
                          text: "/${_quizcontroller.questions.length}",//menampilkan total pertanyaan
                          style: Theme.of(context)//mengakses gaya teks dari tema aplikasi untuk judul 5, yang kemudian diberi warna sekunder
                            .textTheme
                            .headline5
                            ?.copyWith(color: kSecondaryColor),// Mengatur gaya teks untuk total pertanyaan
                        )
                      ]
                    ),
                  ),
                )
              ),
              SizedBox(height: kDefaultPadding),//spasi vertikal
              Expanded(//memperluas widget ke sisa ruang yang tersedia dalam parent widgetnya.
                child: PageView.builder(//membuat tata letak halaman yang dapat digulirkan secara horizontal
                  physics: NeverScrollableScrollPhysics(),//menghilangkan scroll
                  controller: _quizcontroller.pageController,//controller untuk pageview
                  onPageChanged: _quizcontroller.updateQuizNum,//Mengubah nomor pertanyaan saat halaman berubah
                  itemCount: _quizcontroller.questions.length,// Jumlah total pertanyaan
                  //kartu pertanyaan
                  itemBuilder: (context, index) => QuestionCard(//parameter yang digunakan oleh PageView.builder untuk 
                    //membangun tampilan setiap item dalam PageView
                    key: ValueKey('question_card_$index'),//memberikan kunci unik pada setiap widget QuestionCard
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

class QuestionCard extends StatelessWidget {//widget untuk menampilkan kartu pertanyaan dalam kuis.
  const QuestionCard({//konstruktor QuestionCard menerima parameter yang diperlukan yaitu key (kunci) dan question (pertanyaan)
    required Key key,// Kunci unik untuk widget QuestionCard
    required this.question,// Data pertanyaan yang akan ditampilkan
  }) : super(key: key);//Memanggil konstruktor kelas induk dengan meneruskan kunci kepadanya

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
      child: Column(//widget yang mengatur widget-childnya dalam bentuk kolom vertikal
        children: [
          if (question.image != null && question.image!.isNotEmpty)//// Memeriksa apakah pertanyaan memiliki gambar
            Image.asset(
              question.image!,// Memuat gambar pertanyaan jika tersedia
              height: 125,//tinggi kamar
              width: 125,//lebar kamar
            ),
          SizedBox(height: 15),// Memberikan spasi vertikal sebesar 15 piksel
          Text(
            question.question,//Menampilkan teks pertanyaan dari objek pertanyaan
            style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kBlackColor),// Mengatur gaya teks menggunakan gaya teks bawaan (headline6) dari tema aplikasi dengan warna teks hitam
          ),
          SizedBox(height: kDefaultPadding / 2),// Memberikan separuh tinggi padding default sebagai spasi antara teks pertanyaan dan opsi jawaban
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,// Indeks dari opsi jawaban
              text: question.options[index],// Teks dari opsi jawaban pada indeks tertentu
              press: () => _controller.checkAns(question, index),// Menandai jawaban saat opsi jawaban dipilih
            ),
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {// Kelas Option adalah widget untuk menampilkan opsi jawaban dalam kartu pertanyaan
  const Option({// Konstruktor Option menerima parameter yang diperlukan yaitu text (teks opsi), index (indeks opsi), dan press (fungsi untuk menangani aksi saat opsi dipilih)
    super.key,// Key yang diberikan oleh kelas induk, digunakan untuk mengidentifikasi widget
    required this.text,// Teks dari opsi jawaban yang akan ditampilkan
    required this.index,// Indeks dari opsi jawaban
    required this.press,// Fungsi yang akan dipanggil saat opsi dipilih
  });
  final String text;//teks opsi
  final int index;//indeks opsi
  final VoidCallback press;//fungsi saat opsi dipilih

  @override
  Widget build(BuildContext context) {// Mengimplementasikan metode build untuk menampilkan widget berdasarkan kondisi yang diberikan oleh QuizController
    return GetBuilder<QuizController>(// Menginisialisasi QuizController untuk mendapatkan akses ke data dan fungsi dari kuis
      init: QuizController(),
      builder: (qnController) {
      //fungsi untuk mendapatkan warna yang benar
        Color getTheRightColor() {
          if (qnController.isAnswered) {// Jika pertanyaan telah dijawab
            if (index == qnController.correctAns) {
              return kGreenColor;// Jika indeks opsi saat ini sama dengan indeks jawaban yang benar, kembalikan warna hijau          
            } else if (index == qnController.selectedAns &&
                qnController.selectedAns != qnController.correctAns) {
                  return kRedColor;// Mengembalikan warna merah jika jawaban salah
            }
          }
          return kGrayColor;// Mengembalikan warna abu-abu jika jawaban belum dipilih.
        }
      //fungsi untuk mendapatkan ikon yang benar
        IconData getTheRightIcon() {
          return getTheRightColor() == kRedColor ? Icons.close : Icons.done;// Mengembalikan ikon close jika warna adalah merah, dan ikon done jika warna adalah hijau
        }

        return InkWell(// Memuat widget InkWell untuk menangani aksi tap pada opsi jawaban
          onTap: press,// Menetapkan fungsi onTap yang diberikan saat widget ditekan
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),// Menambahkan margin atas pada container
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: kDefaultPadding),// Menambahkan padding vertikal dan horizontal pada container
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),// Menetapkan dekorasi border dengan warna hitam
              borderRadius: BorderRadius.circular(15),// Memberikan radius border container
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$text",// Menampilkan teks opsi jawaban
                  style: TextStyle(color: Colors.black54, fontSize: 12),// Mengatur gaya teks untuk teks opsi
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: getTheRightColor() == kGrayColor// Menentukan warna latar belakang berdasarkan status jawaban
                      ? Colors.transparent// Jika status adalah abu-abu, maka latar belakang transparan
                      :getTheRightColor(),// Jika status bukan abu-abu, maka gunakan warna yang sesuai
                    borderRadius: BorderRadius.circular(50),// Membuat sudut border berbentuk bulat
                    border: Border.all(color: getTheRightColor()),// Menambahkan border dengan warna yang sesuai
                  ),
                  child: getTheRightColor() == kGrayColor// Menentukan ikon yang ditampilkan berdasarkan status jawaban
                    ? null// Jika status adalah abu-abu, tidak ada ikon yang ditampilkan
                    : Icon(getTheRightIcon(), size: 16),// Jika status bukan abu-abu, tampilkan ikon yang sesuai
                )
              ],
            ),
          
          )
        );
      }
    );
  }
}
//indikator proses
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,// Konstruktor ProgressBar yang menerima parameter super.key
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,// Lebar kontainer akan mengisi lebar maksimum yang tersedia
      height: 35,// Tinggi kontainer ProgressBar
      decoration: BoxDecoration(// Mendefinisikan dekorasi untuk ProgressBar
        border: Border.all(color: Color(0xFF3F4768), width: 3),// Garis luar ProgressBar dengan warna dan ketebalan tertentu
        borderRadius: BorderRadius.circular(50)// Membuat sudut kontainer ProgressBar menjadi melengkung
      ),
      child: GetBuilder<QuizController>( // Widget GetBuilder digunakan untuk mendapatkan data dari QuizController
        init: QuizController(),// Menginisialisasi instance dari QuizController
        builder: (controller) {
          print(controller.animation.value);// Mencetak nilai animasi dari controller ke konsol
          return Stack(// Stack digunakan untuk menumpuk widget di atas satu sama lain
            children: [
              LayoutBuilder(// Widget LayoutBuilder digunakan untuk membangun widget sesuai dengan batasan yang diberikan
                builder: (context, Constraints) => Container(
                  width: Constraints.maxWidth * controller.animation.value,// Lebar kontainer akan bergantung pada nilai animasi dari controller
                  decoration: BoxDecoration(// Dekorasi untuk kontainer yang akan menampilkan kemajuan sejauh ini
                    gradient: kPrimaryGradient,// Memberikan gradasi warna sebagai latar belakang kontainer
                    borderRadius: BorderRadius.circular(50),// Membuat sudut kontainer menjadi melengkung
                  ),
                ),
              ),
              Positioned.fill(//mengisi ruang dari parent widget-nya
                child: Padding(//menambahkan ruang kosong di sekeliling widget child-nya.
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2),// Menambahkan padding horizontal dengan nilai default dibagi dua.
                  child: Row(// Menampilkan elemen dalam bentuk baris.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,// Menyusun elemen dengan jarak yang sama di antara mereka
                    children: [
                      Text("${(controller.animation.value * 20).round()} sec"),// Menampilkan teks yang menunjukkan waktu dalam detik
                      WebsafeSvg.asset("images/clock.svg"),// Menampilkan gambar jam
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
