import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/widgets/custom_loading.dart';
import 'package:get/get.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final _userData = GetStorage();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
                              "Pusat Bantuan",
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
}
