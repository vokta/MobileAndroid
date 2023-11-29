import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

class MonitorGpsPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  MonitorGpsPage({required this.latitude, required this.longitude});

  @override
  State<MonitorGpsPage> createState() => _MonitorGpsPageState();
}

class _MonitorGpsPageState extends State<MonitorGpsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FA),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 12.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('Vokta_app'),
                position: LatLng(widget.latitude, widget.longitude),
              ),
            },
            zoomControlsEnabled: false,
          ),
          Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.5))),
          Align(
            child: SafeArea(
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
                          'Monitor GPS',
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
                      height: 100.h,
                    ),
                    Container(
                      width: 320.w,
                      height: 340.w,
                      padding: EdgeInsets.all(30),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 20,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Koordinat',
                                    style: TextStyle(
                                      color: Color(0xFF5DCCFC),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.gps_fixed,
                                    color: Color(0xFFD0D0D0),
                                  )
                                ],
                              ),
                              Divider(
                                color: Color(0xFFE8ECF4),
                                thickness: 1,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Latitude',
                                  style: TextStyle(
                                    color: Color(0xFF2C2C2C),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 40.h,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8F9),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFE8ECF4)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.latitude.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF2A2A2A),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Longitude',
                                  style: TextStyle(
                                    color: Color(0xFF2C2C2C),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 40.h,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF7F8F9),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFE8ECF4)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.longitude.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF2A2A2A),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: widget.latitude.toString() +
                                        ", " +
                                        widget.longitude.toString()));
                                Get.snackbar(
                                  'Salin Koordinat',
                                  'Koordinat berhasil di salin!',
                                  backgroundColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor:
                                    Color.fromRGBO(93, 204, 252, 1),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 13),
                              ),
                              child: Container(
                                  width: 300.w,
                                  height: 20.h,
                                  child: Center(
                                    child: Text(
                                      'Salin',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
