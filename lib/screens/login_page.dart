import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/home.dart';
import 'package:vokta_app/services/auth_service.dart';
import 'package:vokta_app/widgets/custom_loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  String _loginErrorMessage = '';
  String _emailErrorMessage = '';
  String _passwordErrorMessage = '';

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

  void _auth() async {
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.validate();
    String _authErrorMessage = '';
    if (_emailErrorMessage == '' && _passwordErrorMessage == '') {
      final isAuth = await _authService.login(
          _emailController.text, _passwordController.text);

      if (isAuth == 200) {
        Get.offAll(() => Home());
      } else if (isAuth == 400) {
        _authErrorMessage = "*Maaf, email yang anda masukan belum terdaftar";
      } else if (isAuth == 401) {
        _authErrorMessage = "*Maaf, password yang kamu masukan salah";
      } else {
        _authErrorMessage =
            "*Maaf, terjadi kesalahan di server kami, coba lagi nanti";
      }
    }

    setState(() {
      _loginErrorMessage = _authErrorMessage;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 90.h,
                    ),
                    Image.asset(
                      'assets/images/vokta_logo_blue.png',
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Container(
                      width: 320.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 244, 244, 1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color.fromRGBO(232, 236, 244, 1))),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Image.asset(
                              'assets/icon/sms.png',
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              style: TextStyle(
                                color: const Color(0xFF2C2C2C),
                                fontSize: 14.sp,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Alamat Email',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFB0B0B0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _emailErrorMessage =
                                      'Email tidak boleh kosong';
                                } else if (!isEmailValid(value)) {
                                  _emailErrorMessage = 'Email tidak valid';
                                } else {
                                  _emailErrorMessage = '';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_emailErrorMessage != '')
                      _buildErrorTextFieldMessage(_emailErrorMessage),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 320.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 244, 244, 1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color.fromRGBO(232, 236, 244, 1))),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Image.asset(
                              'assets/icon/lock.png',
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                color: const Color(0xFF2C2C2C),
                                fontSize: 14.sp,
                              ),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFB0B0B0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _passwordErrorMessage =
                                      'Password tidak boleh kosong';
                                } else if (value.length < 8) {
                                  _passwordErrorMessage =
                                      'Password minimal 8 karakter';
                                } else {
                                  _passwordErrorMessage = '';
                                }
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                size: 17.sp,
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_passwordErrorMessage != '')
                      _buildErrorTextFieldMessage(_passwordErrorMessage),
                    if (_loginErrorMessage != '')
                      _buildErrorTextFieldMessage(_loginErrorMessage),
                    SizedBox(
                      height: 30.h,
                    ),
                    ElevatedButton(
                        onPressed: _auth,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                        ),
                        child: Container(
                          width: 190.w,
                          height: 20.h,
                          child: Center(
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        )),
        if (_isLoading) const CustomLoading()
      ],
    );
  }

  Widget _buildErrorTextFieldMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 12),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
