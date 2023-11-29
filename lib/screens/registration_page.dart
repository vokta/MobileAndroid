import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vokta_app/models/user.dart';
import 'package:vokta_app/screens/verification_page.dart';
import 'package:vokta_app/services/registration_service.dart';
import 'package:vokta_app/widgets/custom_loading.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegistrationService _registrationService = RegistrationService();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  bool _isLoading = false;
  bool _isRegistrationAllowed = false;
  bool _obscureText = true;
  bool _emailValid = true;
  bool _emailAvailable = true;
  String _firstNameErrorMessage = "";
  String _emailErrorMessage = "";
  String _passwordErrorMessage = "";
  String _addressErrorMessage = "";
  String _mobileErrorMessage = "";

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    final allowed = await _registrationService.registrationStart();
    setState(() {
      _isRegistrationAllowed = allowed;
    });
  }

  void _checkEmailAvailability(String email) {
    _registrationService.isEmailAvailable(email).then((isExist) {
      setState(() {
        _emailAvailable = isExist;
      });
    });
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

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.validate();
    final isEmailValid = _emailErrorMessage == '' ? true : false;

    if (isEmailValid) {
      final isEmailAvailable =
          await _registrationService.isEmailAvailable(_emailController.text);

      if (!isEmailAvailable) {
        setState(() {
          _emailErrorMessage = 'Email sudah digunakan';
          _isLoading = false;
        });
        return;
      }
    }

    if (!isEmailValid) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (_firstNameErrorMessage == "" &&
        _emailErrorMessage == "" &&
        _passwordErrorMessage == "" &&
        _addressErrorMessage == "" &&
        _mobileErrorMessage == "") {
      User user = User(
          firstname: _firstnameController.text,
          lastname: _lastnameController.text,
          email: _emailController.text,
          mobileNo: _mobileController.text,
          address: _addressController.text,
          password: _passwordController.text);
      final registrationSuccess = await _registrationService.storeUser(user);
      if (!registrationSuccess) {
        setState(() {
          Get.snackbar(
            'Gagal Registrasi',
            'Terjadi kesalahan saat mencoba mendaftar.',
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
          _isLoading = false;
        });
        return;
      } else {
        Get.off(() => VerificationPage());
      }
    }

    setState(() {
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
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          'Daftar Akun',
                          style: TextStyle(
                            color: Color(0xFF2C2C2C),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Lengkapi informasi dibawah ini',
                          style: TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.w,
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
                                      'assets/icon/profile.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _firstnameController,
                                      style: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Nama depan',
                                        hintStyle: TextStyle(
                                          color: const Color(0xFFB0B0B0),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          _firstNameErrorMessage =
                                              'Nama depan tidak boleh kosong';
                                        } else {
                                          _firstNameErrorMessage = '';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 236, 244, 1))),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _lastnameController,
                                      style: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Nama belakang',
                                        hintStyle: TextStyle(
                                          color: const Color(0xFFB0B0B0),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (_firstNameErrorMessage != '')
                          _buildErrorTextFieldMessage(_firstNameErrorMessage),
                        SizedBox(
                          height: 15.h,
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
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _emailErrorMessage =
                                          'Email tidak boleh kosong';
                                    } else if (!isEmailValid(value)) {
                                      _emailErrorMessage = 'Email tidak valid';
                                    } else {
                                      _emailErrorMessage = '';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Masukan email',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFFB0B0B0),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_emailErrorMessage != '')
                          _buildErrorTextFieldMessage(_emailErrorMessage),
                        SizedBox(
                          height: 15.h,
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
                                padding: EdgeInsets.only(
                                  right: 5.w,
                                ),
                                child: Image.asset(
                                  'assets/icon/lock.png',
                                  width: 20,
                                  height: 20,
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
                                  padding: const EdgeInsets.all(8.0),
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
                        SizedBox(
                          height: 15.h,
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
                                padding: EdgeInsets.only(
                                  right: 5.w,
                                ),
                                child: Image.asset(
                                  'assets/icon/location.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _addressController,
                                  style: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Alamat',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFFB0B0B0),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _addressErrorMessage =
                                          'Alamat tidak boleh kosong';
                                    } else {
                                      _addressErrorMessage = '';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_addressErrorMessage != '')
                          _buildErrorTextFieldMessage(_addressErrorMessage),
                        SizedBox(
                          height: 15.h,
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
                                padding: EdgeInsets.only(
                                  right: 5.w,
                                ),
                                child: Image.asset(
                                  'assets/icon/mobile.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _mobileController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'No Handphone',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFFB0B0B0),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      _mobileErrorMessage =
                                          'No handphone tidak boleh kosong';
                                    } else if (value.length < 6) {
                                      _mobileErrorMessage =
                                          'No handphone minimal 6 digit';
                                    } else if (value.length > 13) {
                                      _mobileErrorMessage =
                                          'No handphone maksimal 13 digit';
                                    } else {
                                      _mobileErrorMessage = '';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_mobileErrorMessage != '')
                          _buildErrorTextFieldMessage(_mobileErrorMessage),
                        SizedBox(
                          height: 15.h,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 60,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: 'Saya setuju dengan ',
                                  style: TextStyle(
                                    color: const Color(0xFF3B3B3B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                  )),
                              TextSpan(
                                text: 'Ketentuan layanan',
                                style: TextStyle(
                                  color: const Color(0xFF369EFF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                  text: '\n dan ',
                                  style: TextStyle(
                                    color: const Color(0xFF3B3B3B),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                  )),
                              TextSpan(
                                  text: 'Kebijakan privasi',
                                  style: TextStyle(
                                    color: const Color(0xFF369EFF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                text: ' aplikasi Vokta',
                                style: TextStyle(
                                  color: const Color(0xFF3B3B3B),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ElevatedButton(
                            onPressed: _submitForm,
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
                              width: 320.w,
                              height: 20.h,
                              child: Center(
                                child: Text(
                                  'Daftar',
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
              )
            ],
          ),
        ),
        if (!_isRegistrationAllowed || _isLoading) const CustomLoading()
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
