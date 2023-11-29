import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/login_page.dart';
import 'package:pinput/pinput.dart';
import 'package:vokta_app/services/registration_service.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final RegistrationService _registrationService = RegistrationService();
  final otpController = TextEditingController();
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _otpResend = false;
  bool _otpSuccess = false;
  bool _registerCompleted = false;
  int _remainingSeconds = 300;
  late Timer _timer;

  String _otpErrorMessage = "";

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _resendOtpCode() async {
    final gettingOtp = await _registrationService.getOtpCode();
    setState(() {
      _isLoading = true;
      _otpResend = gettingOtp;
      if (_otpResend) {
        Get.snackbar(
          'Kirim OTP',
          'Kode OTP berhasil di kirim ulang ke emailmu',
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        _remainingSeconds = 300;
      } else {
        Get.snackbar(
          'Kirim OTP',
          'Terjadi kesalahan pada saat mengirim ulang kode OTP',
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
      _isLoading = false;
    });
  }

  Future<void> _verifyOtpCode(String otpCode) async {
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState!.validate();
    final isOtpValid = _otpErrorMessage == '' ? true : false;
    if (isOtpValid) {
      final verify = await _registrationService.verifyOtpCode(otpCode);
      setState(() {
        _otpSuccess = verify;
      });

      if (_otpSuccess) {
        _registrationComplated();
      } else {
        _otpErrorMessage = "Kode OTP yang anda masukan salah";
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _registrationComplated() async {
    final completed = await _registrationService.registrationCompleted();
    setState(() {
      _isLoading = false;
      _registerCompleted = completed;
    });

    if (_registerCompleted) {
      Future.delayed(Duration(seconds: 2), () {
        Get.offAll(() => (LoginPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return Stack(
      children: [
        Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kode Verifikasi',
                style: TextStyle(
                  color: Color(0xFF3B3B3B),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Kami mengirim 6 digit angka\nke email kamu',
                  style: TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 45.h,
              ),
              Form(
                key: _formKey,
                child: Pinput(
                  controller: otpController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 42.w,
                    height: 42.h,
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                      color: Color.fromRGBO(30, 60, 87, 1),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF5DCCFC), width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      _otpErrorMessage = 'Kode OTP tidak boleh kosong';
                    } else if (value.length < 6) {
                      _otpErrorMessage = 'Kode OTP berisi 6 digit';
                    } else {
                      _otpErrorMessage = '';
                    }
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              if (_otpErrorMessage != '')
                _buildErrorTextFieldMessage(_otpErrorMessage),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                'Tidak menerima kode?',
                style: TextStyle(
                  color: Color(0xFF3B3B3B),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if (_remainingSeconds != 0)
                Text(
                  'Kirim ulang OTP dalam waktu\n$minutes:${seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 20),
              if (_remainingSeconds == 0)
                GestureDetector(
                  onTap: _resendOtpCode,
                  child: Text(
                    'Kirim kode lagi',
                    style: TextStyle(
                      color: Color(0xFF369EFF),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ElevatedButton(
                  onPressed: () {
                    _verifyOtpCode(otpController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Atur radius sesuai keinginan
                    ),
                    backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 13), // Warna latar belakang tombol
                  ),
                  child: Container(
                    width: 190.w,
                    height: 20.h,
                    child: Center(
                      child: Text(
                        'Verifikasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
            ],
          ),
        )),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
                child: CircularProgressIndicator(
              color: Color.fromRGBO(87, 249, 255, 1),
            )),
          ),
        if (_registerCompleted)
          Container(
            color: Colors.black.withOpacity(0.7),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                width: 200.h,
                height: 180.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 70.h,
                      height: 70.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(21, 216, 255, 1),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 70.h,
                      )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Color(0xFF2C2C2C),
                        fontSize: 20.sp,
                      ),
                      textAlign: TextAlign.center,
                      child: Text(
                        'Yey, Pendaftaran\nBerhasil!',
                        style: TextStyle(
                          color: Color(0xFF2C2C2C),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorTextFieldMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 12),
        textAlign: TextAlign.left,
      ),
    );
  }
}
