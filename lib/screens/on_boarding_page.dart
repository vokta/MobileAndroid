import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/register_page.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/welcome.png',
                width: MediaQuery.of(context).size.height / 3),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Text('Monitor kualitas air\nanda secara real time',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            SizedBox(height: MediaQuery.of(context).size.height / 100),
            Text('Nikmati kemudahan hanya dalam\ngengaman',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(177, 177, 177, 1),
                    fontSize: MediaQuery.of(context).size.height / 55)),
            SizedBox(height: MediaQuery.of(context).size.height / 7),
            GestureDetector(
              onTap: () {
                Get.to(() => RegisterPage());
              },
              child: Text('Mulai',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue[200],
                      fontSize: 14)),
            ),
          ]),
        ),
      ),
    );
  }
}
