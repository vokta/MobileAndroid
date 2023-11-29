import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MonitorPhPage extends StatefulWidget {
  final String ph;

  MonitorPhPage({required this.ph});

  @override
  State<MonitorPhPage> createState() => _MonitorPhPageState();
}

class _MonitorPhPageState extends State<MonitorPhPage> {
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
                      'Monitor pH',
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
                              widget.ph,
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
                                      'pH',
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
                                  'pH meter',
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
                        height: 200.w,
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
                                  'Standar pH',
                                  style: TextStyle(
                                    color: Color(0xFF5DCCFC),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                child: Divider(
                                  color: Color(0xFFE8ECF4),
                                  thickness: 1,
                                ),
                              ),
                              phStandarItem("Air Minum Mineral", "6.5-8.5"),
                              phStandarItem("Air Minum Demineral", "6.5-8.5"),
                              phStandarItem("Air Kolam", "6.5-8.5"),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            phLevelText('Asam'),
            phLevelText('Netral'),
            phLevelText('Basa')
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            phLevel("0", Color(0xFFFF1D11)),
            phLevel("1", Color(0xFFFE4D17)),
            phLevel("2", Color(0xFFFF8E1B)),
            phLevel("3", Color(0xFFFFB532)),
            phLevel("4", Color(0xFFE7CF00)),
            phLevel("5", Color(0xFFAEDC00)),
            phLevel("6", Color(0xFF00D500)),
            phLevel("7", Color(0xFF00B34F)),
            phLevel("8", Color(0xFF00B58A)),
            phLevel("9", Color(0xFF00A6C0)),
            phLevel("10", Color(0xFF008FDE)),
            phLevel("11", Color(0xFF0059CD)),
            phLevel("12", Color(0xFF5321CE)),
            phLevel("13", Color(0xFF820CD0)),
            phLevel("14", Color(0xFF8400AC)),
          ],
        ),
      ],
    );
  }

  Widget phLevel(String num, Color color) {
    return Column(
      children: [
        Container(
          width: 14.w,
          height: 30.w,
          decoration: ShapeDecoration(
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
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
    return Container(
      width: 275.w,
      height: 30.w,
      padding: const EdgeInsets.only(top: 5, left: 14, right: 10, bottom: 4),
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
          const SizedBox(width: 77),
          SizedBox(
            width: 54,
            child: Text(
              desc,
              style: TextStyle(
                  color: Color(0xFF5DCCFC),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
