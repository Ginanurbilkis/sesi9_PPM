import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Nama Pengguna";
  String _phoneNumber = "08123456789";
  String _password = "******";

  List<String> _downloadedMovies = [
    "Film 1 - The Beginning",
    "Film 2 - Adventure Awaits",
    "Film 3 - Final Quest",
  ];

  int _selectedIndex = 2; // Default index untuk ProfilePage

  // Fungsi untuk mengupdate data pengguna
  void _editProfile(String field, String value) {
    setState(() {
      if (field == "name") {
        _name = value;
      } else if (field == "phoneNumber") {
        _phoneNumber = value;
      } else if (field == "password") {
        _password = value;
      }
    });
  }

  // Fungsi untuk menghapus film dari daftar unduhan
  void _deleteMovie(int index) {
    setState(() {
      _downloadedMovies.removeAt(index);
    });
  }

  // Fungsi navigasi untuk BottomNavigationBar
  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UploadPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Profil
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _phoneNumber,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Form untuk Edit Profil
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Nama",
                          prefixIcon: Icon(Icons.person),
                        ),
                        onSubmitted: (value) => _editProfile("name", value),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Nomor HP",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        onSubmitted: (value) => _editProfile("phoneNumber", value),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        onSubmitted: (value) => _editProfile("password", value),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Daftar Film yang Diunduh
              Text(
                "Film yang Telah Diunduh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _downloadedMovies.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        _downloadedMovies[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteMovie(index);
                        },
                      ),
                    ),
                  );
                },
              ),
              if (_downloadedMovies.isEmpty)
                Center(
                  child: Text(
                    "Belum ada film yang diunduh.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(child: Text("Halaman Home")),
    );
  }
}

class UploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload")),
      body: Center(child: Text("Halaman Upload")),
    );
  }
}
