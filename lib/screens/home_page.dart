import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/monitor_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFDFF5FF), Color(0xFF67D0FD)],
        ),
      ),
      child: Stack(children: [
        Positioned(
          top: -MediaQuery.of(context).size.height * 0.1,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                    Image.asset(
                      'assets/images/vokta-default.png',
                      width: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "Hallo, Slamet",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(93, 204, 252, 1)),
                    ),
                    Text(
                      "Bagaimana kabar air mu hari ini?",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(132, 138, 148, 1)),
                    )
                  ],
                ),
              )),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 0.4,
          left: MediaQuery.of(context).size.width * 0.09,
          right: MediaQuery.of(context).size.width * 0.09,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 183, 226, 246),
                  Color.fromARGB(255, 126, 216, 255)
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
            ),
            Center(
                child: Text(
              "Tidak ada tangki tersambung",
              style: TextStyle(color: Colors.white),
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => MonitorPage());
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Atur radius sesuai keinginan
                  ),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 13), // Warna latar belakang tombol
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text(
                    'Cek Kualitas',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(93, 204, 252, 1)),
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        )
      ]),
    );
  }
}