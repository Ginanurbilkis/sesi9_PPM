import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartun_app/screen/login.dart'; // Pastikan import LoginPage
import 'package:kartun_app/screen/mainPage.dart'; // Pastikan import MainPage
import 'package:kartun_app/screen/register.dart'; // Jika ada halaman register

void main() {
  // Test 1: Login dengan kredensial valid
  testWidgets('Login dengan kredensial valid', (WidgetTester tester) async {
    // Bangun widget LoginPage
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
      routes: {
        '/main': (context) => MainPage(), // Halaman utama setelah login berhasil
      },
    ));

    // Isi username dan password dengan kredensial valid
    await tester.enterText(find.byType(TextField).at(0), 'user');
    await tester.enterText(find.byType(TextField).at(1), 'userpass');

    // Tekan tombol Login
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verifikasi bahwa halaman utama muncul setelah login berhasil
    expect(find.byType(MainPage), findsOneWidget);
  });

  // Test 2: Login dengan kredensial tidak valid
  testWidgets('Login dengan kredensial tidak valid', (WidgetTester tester) async {
    // Bangun widget LoginPage
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
      routes: {
        '/main': (context) => MainPage(), // Halaman utama setelah login berhasil
      },
    ));

    // Isi username dan password dengan kredensial tidak valid
    await tester.enterText(find.byType(TextField).at(0), 'wronguser');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpass');

    // Tekan tombol Login
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verifikasi bahwa halaman utama tidak muncul (karena login salah)
    expect(find.byType(MainPage), findsNothing);
  });

  // Test 3: Navigasi ke halaman Register
  testWidgets('Navigasi ke halaman Register', (WidgetTester tester) async {
    // Bangun widget LoginPage
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
      routes: {
        '/register': (context) => Scaffold(), // Halaman Register (dummy untuk tes)
      },
    ));

    // Tekan tombol "Don't have an account? Register"
    await tester.tap(find.text("Don't have an account? Register"));
    await tester.pumpAndSettle();

    // Verifikasi bahwa halaman Register muncul
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
