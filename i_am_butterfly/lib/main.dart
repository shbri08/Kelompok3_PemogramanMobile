import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'I am Butterfly',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 96, 83, 117),
        ),
        body: Center(
          child: Image(
              image: AssetImage(
                  'Images/Butterfly.png')),
        ),
        backgroundColor: Color.fromARGB(255, 177, 159, 211),
      ),
    ),
  );
}
