import 'package:flutter/material.dart';

class FilmList extends StatelessWidget {
  const FilmList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Film 1"),
          trailing: IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Logika untuk mendownload film
            },
          ),
        ),
        ListTile(
          title: Text("Film 2"),
          trailing: IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Logika untuk mendownload film
            },
          ),
        ),
        // Daftar film lainnya
      ],
    );
  }
}
