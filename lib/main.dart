import 'package:flutter/material.dart';
import 'package:kartun_app/screen/login.dart';
import 'package:kartun_app/screen/profile.dart'; // Pastikan ProfilePage diimpor dengan benar

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Pastikan LoginPage diimpor dengan benar
      routes: {
        '/home': (context) => MainPage(),
        '/upload': (context) => UploadPage(), // Periksa apakah UploadPage ada
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
