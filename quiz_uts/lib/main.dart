import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quiz_app/pages/homePage.dart';

//Fungsi utama 
void main() {
  runApp(const MyApp()); //menjalankan aplikasi dengan runApp
}

//kelas yang digunakan untuk menginisialisasi aplikasi 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

//Metode build untuk mendefinisikan Ui aplikasi 
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Quiz App',//judul aplikas
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),//menetapkan tema gelap untuk aplikasi
      home: HomePage(),//menetapkan layar aplikasi ke HomePage
    );
  }
}
