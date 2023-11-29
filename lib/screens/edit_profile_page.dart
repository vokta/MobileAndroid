import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/controllers/user_controller.dart';
import 'package:vokta_app/models/user.dart';
import 'package:vokta_app/services/user_service.dart';
import 'package:vokta_app/widgets/custom_loading.dart';
import 'package:get/get.dart';
import 'package:vokta_app/widgets/custom_textfield_error.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final UserController _userController = Get.put(UserController());
  final UserService _userService = UserService();
  final _userData = GetStorage();
  String? _uid;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _mobileNo;
  String? _address;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;
  bool _isEdit = false;
  bool _emailValid = true;
  bool _emailAvailable = true;
  String _firstNameErrorMessage = "";
  String _emailErrorMessage = "";
  String _mobileErrorMessage = "";
  String _addressErrorMessage = "";

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  void _loadUserData() {
    final userJson = _userData.read('user');
    User user = User.fromJson(userJson);

    setState(() {
      _uid = user.uid;
      _firstname = user.firstname;
      _lastname = user.lastname;
      _email = user.email;
      _mobileNo = user.mobileNo;
      _address = user.address;
    });

    setState(() {
      _firstnameController.text = _firstname ?? "";
      _lastnameController.text = _lastname ?? "";
      _emailController.text = _email ?? "";
      _mobileController.text = _mobileNo ?? "";
      _addressController.text = _address ?? "";
    });
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.validate();

    if (_firstNameErrorMessage == "" &&
        _emailErrorMessage == "" &&
        _addressErrorMessage == "" &&
        _mobileErrorMessage == "") {
      User user = User(
          uid: _uid,
          firstname: _firstnameController.text,
          lastname: _lastnameController.text,
          email: _emailController.text,
          mobileNo: _mobileController.text,
          address: _addressController.text);
      final isSuccess = await _userService.updateUser(user, context);
      if (!isSuccess) {
        setState(() {
          Get.snackbar(
            'Edit profile',
            'Terjadi kesalahan saat mencoba mengedit.',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          userController.updateFullName(
              _firstnameController.text + ' ' + _lastnameController.text);
          userController.updateEmail(_emailController.text);
          Get.snackbar(
            'Edit profile',
            'Selamat update profile berhasil',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          _isEdit = false;
          _isLoading = false;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _editingData() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Scaffold(
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    width: 20.w,
                                    height: 20.w,
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 20.w,
                                    )),
                              ),
                              Text(
                                "Edit Akun",
                                style: TextStyle(
                                  color: Color(0xFF3B3B3B),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: 20.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                          Image.asset(
                            'assets/images/profile-circle.png',
                            width: 100.w,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Obx(() {
                            return Text(
                              "${userController.fullName}",
                              style: TextStyle(
                                  color: Color(0xFF3B3B3B),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            );
                          }),
                          SizedBox(
                            height: 5.h,
                          ),
                          if (!_isEdit)
                            GestureDetector(
                              onTap: () => _editingData(),
                              child: Text(
                                'Edit Akun',
                                style: TextStyle(
                                    color: Color(0xFF5DCCFC),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          if (_isEdit)
                            GestureDetector(
                              onTap: () => _editingData(),
                              child: Text(
                                'Batal',
                                style: TextStyle(
                                    color: Color(0xFF5DCCFC),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(244, 244, 244, 1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  232, 236, 244, 1))),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: Image.asset(
                                              'assets/icon/profile.png',
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              enabled: _isEdit,
                                              controller: _firstnameController,
                                              style: TextStyle(
                                                color: _isEdit
                                                    ? Color(0xFF2C2C2C)
                                                    : Color(0xFFB0B0B0),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Nama depan',
                                                hintStyle: TextStyle(
                                                  color:
                                                      const Color(0xFFB0B0B0),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                          color:
                                              Color.fromRGBO(244, 244, 244, 1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  232, 236, 244, 1))),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              enabled: _isEdit,
                                              controller: _lastnameController,
                                              style: TextStyle(
                                                color: _isEdit
                                                    ? Color(0xFF2C2C2C)
                                                    : Color(0xFFB0B0B0),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Nama belakang',
                                                hintStyle: TextStyle(
                                                  color:
                                                      const Color(0xFFB0B0B0),
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
                                  CustomTextFieldError(
                                      message: _firstNameErrorMessage),
                                SizedBox(height: 15.h),
                                Container(
                                  width: 320.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(244, 244, 244, 1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              232, 236, 244, 1))),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Image.asset(
                                          'assets/icon/sms.png',
                                          width: 20.w,
                                          height: 20.h,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          enabled: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _emailController,
                                          style: TextStyle(
                                            color: Color(0xFFB0B0B0),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
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
                                  CustomTextFieldError(
                                      message: _emailErrorMessage),
                                SizedBox(height: 15.h),
                                Container(
                                  width: 320.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(244, 244, 244, 1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              232, 236, 244, 1))),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Image.asset(
                                          'assets/icon/location.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          enabled: _isEdit,
                                          controller: _addressController,
                                          style: TextStyle(
                                            color: _isEdit
                                                ? Color(0xFF2C2C2C)
                                                : Color(0xFFB0B0B0),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                  CustomTextFieldError(
                                      message: _addressErrorMessage),
                                SizedBox(height: 15.h),
                                Container(
                                  width: 320.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(244, 244, 244, 1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              232, 236, 244, 1))),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Image.asset(
                                          'assets/icon/mobile.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          enabled: _isEdit,
                                          controller: _mobileController,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          style: TextStyle(
                                            color: _isEdit
                                                ? Color(0xFF2C2C2C)
                                                : Color(0xFFB0B0B0),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              _mobileErrorMessage =
                                                  'No handphone tidak boleh kosong';
                                            } else if (value.length < 6) {
                                              _mobileErrorMessage =
                                                  'No handphone minimal 6 digit';
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
                                  CustomTextFieldError(
                                      message: _mobileErrorMessage),
                                SizedBox(
                                  height: 30.h,
                                ),
                                if (_isEdit)
                                  UnconstrainedBox(
                                    child: ElevatedButton(
                                        onPressed: _submitForm,
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          backgroundColor:
                                              Color.fromRGBO(93, 204, 252, 1),
                                        ).copyWith(
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    Size(200.w, 40.h))),
                                        child: Center(
                                          child: Text(
                                            'Update',
                                            style: TextStyle(fontSize: 18.sp),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                  ),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_isLoading) CustomLoading()
      ],
    );
  }

  bool isEmailValid(String email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
