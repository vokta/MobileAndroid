import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Text(
              'Masuk',
              style:
                  TextStyle(fontSize: 24),
            ),
            Text(
              'Hello, masukan akun kamu',
              style: TextStyle(color: Color.fromRGBO(177, 177, 177, 1), fontSize: 14),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(
                    244, 244, 244, 1),
                borderRadius:
                    BorderRadius.circular(30),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 10, left: 15),
                    child: Image.asset(
                      'assets/icon/sms.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                      decoration: InputDecoration(
                        border: InputBorder.none, 
                        hintText: 'Alamat Email',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 1),
                borderRadius:
                    BorderRadius.circular(30),
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 10, left: 15), 
                    child: Image.asset(
                      'assets/icon/lock.png',
                      width: 20,
                      height: 20
                    ),
                  ),
                  Expanded(
                    child: TextField(
                       style: TextStyle(color: Color.fromRGBO(142, 142, 142, 1), fontSize: 14),
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        _togglePasswordVisibility,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        _obscureText
                            ? 'assets/icon/eye.png'
                            : 'assets/icon/eye-slash.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => Home());
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30),
                  ),
                  backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 13),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text(
                    'Masuk',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
