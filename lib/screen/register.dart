import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Logika registrasi, setelah sukses, arahkan ke Login
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
