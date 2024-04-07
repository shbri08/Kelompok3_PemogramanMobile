import 'package:flutter/material.dart';// Package untuk pengembangan UI dengan Flutter
import 'package:get/get.dart';// Package untuk manajemen state dan navigasi
import 'package:quiz_app/constants.dart';// File yang berisi konstanta-konstanta yang digunakan
import 'package:quiz_app/pages/quizPage.dart';// Halaman kuis
// import 'package:websafe_svg/websafe_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});// Konstruktor kelas HomePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),// Padding horizontal dengan nilai default
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 8,),// Spacer untuk memberi ruang kosong di antara elemen dengan fleksibilitas 8
                  Text(
                    "Quiziz Unesa",// Judul halaman utama
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),// Gaya teks untuk judul
                    ),
                    Spacer(),//memberi ruang kosong
                    Text("Masukkan Nama"),// Label "Masukkan Nama"
                    SizedBox(height: 12,),// Spasi vertikal
                    TextField(// Widget untuk memasukkan nama
                      decoration: InputDecoration(
                        filled: true,// Mengisi latar belakang
                        fillColor: Color(0xFF1C2341),// Warna latar belakang
                        hintText: "Nama",// teks nama
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),// Membuat sudut border melengkung
                        )
                      ),
                    ),
                    Spacer(),
                    InkWell(//Widget untuk memulai kuis
                      onTap: () => Get.to(QuizPage()),// Aksi saat ditekan untuk navigasi ke halaman kuis
                      child: Container(
                        width: double.infinity,// Lebar container menyesuaikan dengan lebar layar
                        alignment: Alignment.center,// Posisi teks di tengah
                        padding: EdgeInsets.all(kDefaultPadding * 0.75),// Padding untuk konten dalam container
                        decoration: BoxDecoration(
                          gradient: kPrimaryGradient,// Gradasi warna untuk latar belakang
                          borderRadius: BorderRadius.all(Radius.circular(12)),// Membuat sudut border melengkung
                        ),
                        child: Text(
                          "Start Quiz",// Teks untuk tombol memulai kuis
                          style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.black),// Gaya teks untuk tombol
                        ),
                      ),
                    ),
                    Spacer(flex: 8,),// Spacer untuk memberi ruang kosong di bagian bawah dengan fleksibilitas 8
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
