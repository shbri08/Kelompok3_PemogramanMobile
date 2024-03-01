import 'package:flutter/material.dart';

void main() {
  runApp(const KartuNama());
}

class KartuNama extends StatelessWidget {
  const KartuNama({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
          title: Center(
            child: Text(
              'Kelompok 3',
              style: TextStyle(fontSize: 40),
            )
          )
          ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 194, 172, 204),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 144, 189, 183),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 7, 8, 92),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'DINA HARIYANTI',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 228, 188, 8),
                                    fontSize: 30, // Sesuaikan ukuran teks
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:20), // Mengatur jarak antara teks dan gambar
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'images/Dina.jpg', // Foto Dina
                                      width: 150, // lebar gambar
                                      height: 150, // tinggi gambar
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'NIM : 22091397067',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Prodi : D4 Manajemen Informatika',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Fakultas : Vokasi',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'TTL : Tuban, 14 April 2005',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          'Alamat : Grabagan - Tuban',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
