import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MonitorNtuPage extends StatefulWidget {
  final String ntu;

  MonitorNtuPage({required this.ntu});

  @override
  State<MonitorNtuPage> createState() => _MonitorNtuPageState();
}

class _MonitorNtuPageState extends State<MonitorNtuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: 30.w,
                      height: 30.w,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 15.w),
                        onPressed: () {
                          Get.back();
                        },
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Monitor NTU',
                      style: TextStyle(
                        color: Color(0xFF2C2C2C),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 30.w,
                    ),
                  ],
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
                      SizedBox(
                        height: 170.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                width: 90.w,
                                height: 90.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF5DCCFC),
                                )),
                            Container(
                                width: 122.w,
                                height: 122.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0x665DCCFC),
                                )),
                            Container(
                              width: 190.w,
                              height: 190.w,
                              decoration: ShapeDecoration(
                                shape: OvalBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFB8E5F8)),
                                ),
                              ),
                            ),
                            Text(
                              widget.ntu,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 35.w,
                                height: 50.w,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/icon/water-drop-3.png'))),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Center(
                                    child: Text(
                                      'NTU',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5DCCFC),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 203.w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 15,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'NTU meter',
                                  style: TextStyle(
                                    color: Color(0xFF5DCCFC),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  color: Color(0xFFE8ECF4),
                                  thickness: 1,
                                ),
                              ),
                              phLavelRow()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 150.w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 15,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Standar NTU',
                                  style: TextStyle(
                                    color: Color(0xFF5DCCFC),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Divider(
                                  color: Color(0xFFE8ECF4),
                                  thickness: 1,
                                ),
                              ),
                              phStandarItem("Air Normal", "0-25 NTU"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget phLavelRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [phLevelText('Sample Air')],
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              phLevel("250", Color(0xFFA67739)),
              phLevel("100", Color(0xFFBA9146)),
              phLevel("50", Color(0xFFD2B56D)),
              phLevel("25", Color(0xFFE0D09E)),
              phLevel("10", Color(0xFFECE9CB)),
            ],
          ),
        ),
      ],
    );
  }

  Widget phLevel(String num, Color color) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 30.w,
          decoration: ShapeDecoration(
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            num,
            style: TextStyle(
              color: Color(0xFF2A2A2A),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget phLevelText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF2C2C2C),
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget phStandarItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          width: double.infinity,
          height: 29.h,
          decoration: ShapeDecoration(
            color: Color(0xFFF7F8F9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF2C2C2C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                    color: Color(0xFF5DCCFC),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
