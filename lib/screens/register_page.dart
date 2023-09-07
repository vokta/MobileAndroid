import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:vokta_app/screens/registration_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Text('Belum Punya Akun?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            SizedBox(height: MediaQuery.of(context).size.height / 2),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => RegistrationPage());
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Atur radius sesuai keinginan
                  ),
                  backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                  padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 13), // Warna latar belakang tombol
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Daftar',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.width / 30,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(87, 87, 87, 1)),
                  ),
                  TextSpan(
                    text: 'Masuk',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Aksi yang ingin dilakukan saat teks "Masuk" diklik
                        // Contohnya, berpindah ke halaman login
                        Get.to(() => LoginPage());
                      },
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
