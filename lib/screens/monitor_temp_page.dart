import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MonitorTempPage extends StatefulWidget {
  final String temperature;

  MonitorTempPage({required this.temperature});

  @override
  State<MonitorTempPage> createState() => _MonitorTempPageState();
}

class _MonitorTempPageState extends State<MonitorTempPage> {
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
                      'Monitor Suhu',
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
                              '${widget.temperature}°c',
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
                                      child: Icon(
                                    Icons.thermostat,
                                    color: Color(0xFF5DCCFC),
                                    size: 20,
                                  )),
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
                                  'Suhu meter',
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
                        height: 210.h,
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
                                  'Standar Suhu',
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
                              phStandarItem("Air Normal", "25°C - 32°C"),
                              phStandarItem("Air Hangat", "36°C - 37°C"),
                              phStandarItem("Air Dingin", "4°C - 15°C"),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            phLevelText('Batas Beku'),
            phLevelText('Titik Didih'),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        SfLinearGauge(
          minimum: 0.0,
          maximum: 100.0,
          orientation: LinearGaugeOrientation.horizontal,
          majorTickStyle: LinearTickStyle(length: 10),
          axisLabelStyle: TextStyle(fontSize: 12.sp, color: Colors.black),
          axisTrackStyle: const LinearAxisTrackStyle(
              color: Colors.white,
              edgeStyle: LinearEdgeStyle.bothCurve,
              thickness: 25.0,
              borderWidth: 7,
              borderColor: Color(0xFF5DCCFC)),
          barPointers: [
            LinearBarPointer(
              value: double.tryParse(widget.temperature) ?? 0.0,
              color: Color(0xFFEE5555),
              borderColor: Colors.white,
              borderWidth: 0.5,
              thickness: 7,
            )
          ],
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
