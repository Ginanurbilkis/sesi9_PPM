import 'package:flutter/material.dart';
import 'package:kartun_app/screen/profile.dart';

class OwnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pemilik")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Halaman Pemilik", style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                // Aksi pemilik, misalnya menuju ke halaman upload video
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadPage()),
                );
              },
              child: Text("Unggah Video"),
            ),
          ],
        ),
      ),
    );
  }
}
