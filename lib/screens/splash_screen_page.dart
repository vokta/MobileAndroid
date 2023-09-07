import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/home.dart';
import 'package:vokta_app/screens/on_boarding_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ubah sesuai kebutuhan
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFDFF5FF), Color(0xFF67D0FD)],
          ),
        ),child: Stack(children: [
          
          Positioned(
            bottom: -20,
            child: Center(
              child: Image.asset(
                'assets/images/splash_1.png',
                width: 600,
                fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -100,
            child: Center(
              child: Image.asset(
                'assets/images/splash_2.png', 
                width: 600,
                fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(child:  SplashContent(),),
        ])), // Widget konten splash screen
    );
  }
}

class SplashContent extends StatefulWidget {
  @override
  _SplashContentState createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  double opacityLevel = 0; // Awalnya opacity 0

  @override
  void initState() {
    super.initState();
    // Setelah 0,5 detik, animasikan opacity menjadi 1
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1;
      });

      Future.delayed(Duration(seconds: 2), () {
        Get.offAll(OnBoardingPage()); // Menggunakan GetX untuk pindah halaman
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: opacityLevel,
        duration: Duration(seconds: 1), // Durasi animasi
        curve: Curves.easeIn, // Kurva animasi
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            Image.asset(
              'assets/images/vokta_logo.png', // Ganti dengan path gambar kedua
              width: MediaQuery.of(context).size.width/2,
            ), // Ganti dengan path gambar
            SizedBox(height: MediaQuery.of(context).size.height/2.5),
            RichText(
              text: TextSpan(
                text: 'Powered by ',
                style: TextStyle(color: Colors.white),
                children: const <TextSpan>[
                  TextSpan(text: 'Vokasi Water', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
