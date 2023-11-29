import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/controllers/user_controller.dart';
import 'package:vokta_app/models/user.dart';
import 'package:vokta_app/screens/edit_profile_page.dart';
import 'package:vokta_app/screens/help_center.dart';
import 'package:vokta_app/screens/manage_device.dart';
import 'package:vokta_app/screens/register_page.dart';
import 'package:vokta_app/services/auth_service.dart';
import 'package:vokta_app/widgets/custom_loading.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  final _userData = GetStorage();
  String? _fullname;
  String? _email;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  void _loadUserData() {
    final userJson = _userData.read('user');
    User user = User.fromJson(userJson);

    setState(() {
      _fullname = user.firstname + ' ' + user.lastname;
      _email = user.email;
    });
  }

  void _logout() async {
    setState(() {
      _isLoading = true;
    });
    final isLogout = await _authService.logout();

    if (isLogout) {
      Get.offAll(() => RegisterPage());
    }

    setState(() {
      _isLoading = false;
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
                              "Akun",
                              style: TextStyle(
                                color: Color(0xFF3B3B3B),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              width: 20.w,
                            )
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
                          );
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(() {
                          return Text(
                            '${userController.email}',
                            style: TextStyle(
                              color: Color(0xFF8E8E8E),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                        SizedBox(
                          height: 50.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => EditProfilePage());
                          },
                          child: Container(
                              width: 360.w,
                              padding: EdgeInsets.all(16),
                              height: 45.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle_outlined,
                                        color: Color(0xFF5DCCFC),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Detail Akun',
                                        style: TextStyle(
                                          color: Color(0xFF3B3B3B),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF5DCCFC),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ManageDevicePage());
                          },
                          child: Container(
                              width: 360.w,
                              padding: EdgeInsets.all(16),
                              height: 45.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.dns_outlined,
                                          color: Color(0xFF5DCCFC)),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Kelola Device',
                                        style: TextStyle(
                                          color: Color(0xFF3B3B3B),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF5DCCFC),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => HelpCenterPage());
                          },
                          child: Container(
                              width: 360.w,
                              padding: EdgeInsets.all(16),
                              height: 45.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.live_help_outlined,
                                          color: Color(0xFF5DCCFC)),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Pusat Bantuan',
                                        style: TextStyle(
                                          color: Color(0xFF3B3B3B),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF5DCCFC),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            showLogoutDialog(context);
                          },
                          child: Container(
                              width: 360.w,
                              height: 45.h,
                              padding: EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.power_settings_new,
                                      color: Color(0xFF5DCCFC)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    'Keluar',
                                    style: TextStyle(
                                      color: Color(0xFF3B3B3B),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin keluar akun?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _logout();
              },
              child: Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
