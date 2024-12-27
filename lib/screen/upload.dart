import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart'; 
import 'package:lottie/lottie.dart'; 

// Import ProfilePage hanya dari satu file yang benar
import 'package:kartun_app/screen/profile.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UploadPage(), // Pastikan UploadPage menggunakan StatefulWidget
    );
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();
  double _opacity = 0.0;
  bool _isVideoPicked = false;
  bool _isUploading = false;

  int _selectedIndex = 0; // Untuk mengatur index BottomNavigation

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _isVideoPicked = true;
        _opacity = 1.0;
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih video terlebih dahulu!")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://example.com/upload-video'),
      );
      request.files.add(await http.MultipartFile.fromPath('video', _videoFile!.path));

      var response = await request.send();

      setState(() {
        _isUploading = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Video berhasil diunggah!")),
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengunggah video: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat mengunggah video!")),
      );
    }
  }

  // Fungsi untuk mengubah halaman saat navigasi dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi langsung sesuai pilihan
    if (index == 0) {
      // Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UploadPage()),
      );
    } else if (index == 1) {
      // Upload
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UploadPage()),
      );
    } else if (index == 2) {
      // Profile
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Page", style: GoogleFonts.poppins()),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: size.height * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Kelola Video Anda",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                AnimatedOpacity(
                  opacity: _isVideoPicked ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: _videoFile != null
                      ? Column(
                          children: [
                            Text(
                              "Video Terpilih:",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _videoFile!.path.split('/').last,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                if (_isVideoPicked)
                  Lottie.asset(
                    'assets/Animasi/Animation - 1734967204461.json',
                    height: size.height * 0.15,
                  ),
                ElevatedButton(
                  onPressed: _pickVideo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Pilih Video",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                if (_isUploading)
                  Lottie.asset(
                    'assets/Animasi/Animation - 1734967204461.json',
                    height: size.height * 0.15,
                  ),
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 1),
                  child: ElevatedButton(
                    onPressed: _uploadVideo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Unggah Video",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
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

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sukses", style: GoogleFonts.poppins()),
      ),
      body: Center(
        child: Text(
          "Video Berhasil Diunggah!",
          style: GoogleFonts.poppins(
            color: Colors.green,
            fontSize: size.width * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
