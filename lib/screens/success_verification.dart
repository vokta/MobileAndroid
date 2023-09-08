import 'package:flutter/material.dart';

class SuccessVerification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white.withOpacity(0.7),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2 -
              MediaQuery.of(context).size.height * 0.45 / 2,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.7),
                gradient: LinearGradient(
                  colors: [Color(0xFF67D0FD), Color(0xFFDFF5FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.15,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icon/check.png',
                        width: MediaQuery.of(context).size.height ,
                        height: MediaQuery.of(context).size.height ,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  DefaultTextStyle(
                    style: TextStyle(color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.035,),
                        textAlign: TextAlign.center,
                    child: Text(
                      'Yey, Verifikasi\nBerhasil!'
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
