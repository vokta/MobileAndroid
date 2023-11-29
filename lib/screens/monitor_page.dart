import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vokta_app/controllers/tank_event_controller.dart';
import 'package:vokta_app/screens/home_page.dart';
import 'package:vokta_app/screens/monitor_gps_page.dart';
import 'package:vokta_app/screens/monitor_ntu_page.dart';
import 'package:vokta_app/screens/monitor_ph_page.dart';
import 'package:vokta_app/screens/monitor_tds_page.dart';
import 'package:vokta_app/screens/monitor_temp_page.dart';

class MonitorPage extends StatefulWidget {
  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  bool _isList = false;

  void _changeMonitorView() {
    setState(() {
      _isList = !_isList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xFFF0F8FA),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SafeArea(
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
                  Center(
                      child: Text(
                    'Monitor',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  Container(
                    width: 30.w,
                    height: 30.w,
                    child: IconButton(
                      icon: Icon(
                        _isList ? Icons.grid_view : Icons.view_agenda_outlined,
                        size: 20.w,
                        color: Color(0xFF5DCCFC),
                      ),
                      onPressed: _changeMonitorView,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              monitorView(_isList)
            ],
          ),
        ),
      ),
    ));
  }

  Widget monitorView(bool isList) {
    if (!isList) {
      return Expanded(
        child: Obx(() {
          String ph = tankEventController.tank.value!.events?.ph ?? '0';
          String tds = tankEventController.tank.value!.events?.tds ?? '0';
          String temperature =
              tankEventController.tank.value!.events?.temperature ?? '0';
          String turbidity =
              tankEventController.tank.value!.events?.turbidity ?? '0';
          double latitude = double.tryParse(
                  tankEventController.tank.value!.events?.latitude ?? '') ??
              0;
          double longitude = double.tryParse(
                  tankEventController.tank.value!.events?.longitude ?? '') ??
              0;
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.76, -0.65),
                        end: Alignment(-0.76, 0.65),
                        colors: [
                          Color(0xFF5DCCFC),
                          Color.fromARGB(255, 139, 216, 249)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFFd9d9d9),
                        width: 0.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => Get.to(MonitorPhPage(
                        ph: ph,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25.w,
                                height: 35.h,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/icon/water-drop-2.png',
                                      width: 25.w,
                                    ),
                                    Center(
                                      child: Text(
                                        'pH',
                                        style: TextStyle(
                                          color: Color(0xFF5DCCFC),
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(ph,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text(
                                'Keasaman',
                                style: TextStyle(
                                  color: const Color(0xFFE8ECF4),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    height: 140.w,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFFd9d9d9),
                        width: 0.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => (Get.to(MonitorTdsPage(tds: tds))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25.w,
                                height: 35.h,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/icon/water-drop.png',
                                      width: 25.w,
                                    ),
                                    Center(
                                      child: Text(
                                        'TDS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: tds,
                                      style: TextStyle(
                                        color: Color(0xFF2C2C2C),
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'mg/l',
                                      style: TextStyle(
                                        color: Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'Kepadatan',
                                style: TextStyle(
                                  color: const Color(0xFFD0D0D0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 140.w,
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 15,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                      border: Border.all(
                        color: const Color(0xFFd9d9d9),
                        width: 0.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => Get.to(MonitorNtuPage(ntu: turbidity)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25.w,
                                height: 35.h,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/icon/water-drop.png',
                                      width: 25.w,
                                    ),
                                    Center(
                                      child: Text(
                                        'NTU',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(turbidity,
                                  style: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text(
                                'Kekeruhan',
                                style: TextStyle(
                                  color: const Color(0xFFD0D0D0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    height: 140.w,
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 15,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                      border: Border.all(
                        color: const Color(0xFFd9d9d9),
                        width: 0.5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () =>
                          Get.to(MonitorTempPage(temperature: temperature)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25.w,
                                height: 35.h,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/icon/water-drop.png',
                                      width: 25.w,
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.thermostat,
                                      color: Colors.white,
                                      size: 18.sp,
                                    )),
                                  ],
                                ),
                              ),
                              Text('$temperature°c',
                                  style: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text(
                                'Suhu',
                                style: TextStyle(
                                  color: const Color(0xFFD0D0D0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 140.w,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFd9d9d9),
                    width: 0.5,
                  ),
                ),
                child: buildGoogleMap(latitude, longitude),
              ),
            ],
          );
        }),
      );
    } else {
      return Expanded(
        child: Obx(() {
          String ph = tankEventController.tank.value!.events?.ph ?? '0';
          String tds = tankEventController.tank.value!.events?.tds ?? '0';
          String temperature =
              tankEventController.tank.value!.events?.temperature ?? '0';
          String turbidity =
              tankEventController.tank.value!.events?.turbidity ?? '0';
          double latitude = double.tryParse(
                  tankEventController.tank.value!.events?.latitude ?? '') ??
              0;
          double longitude = double.tryParse(
                  tankEventController.tank.value!.events?.longitude ?? '') ??
              0;
          return ListView(
            children: [
              Container(
                width: 320.w,
                height: 87.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.76, -0.65),
                    end: Alignment(-0.76, 0.65),
                    colors: [
                      Color(0xFF5DCCFC),
                      Color.fromARGB(255, 139, 216, 249)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFFd9d9d9),
                    width: 0.5,
                  ),
                ),
                child: InkWell(
                  onTap: () => Get.to(MonitorPhPage(
                    ph: ph,
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25.w,
                          height: 35.h,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/icon/water-drop-2.png',
                                width: 25.w,
                              ),
                              Center(
                                child: Text(
                                  'pH',
                                  style: TextStyle(
                                    color: const Color(0xFF5DCCFC),
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(ph,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text(
                              'Keasaman',
                              style: TextStyle(
                                color: Color(0xFFE8ECF4),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: 320.w,
                height: 87.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFd9d9d9),
                    width: 0.5,
                  ),
                ),
                child: InkWell(
                  onTap: () => Get.to(MonitorTdsPage(tds: tds)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25.w,
                          height: 35.h,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/icon/water-drop.png',
                                width: 25.w,
                              ),
                              Center(
                                child: Text(
                                  'TDS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: tds,
                                      style: TextStyle(
                                        color: Color(0xFF2C2C2C),
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  TextSpan(
                                    text: 'mg/l',
                                    style: TextStyle(
                                      color: Color(0xFF2C2C2C),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'Kepadatan',
                              style: TextStyle(
                                color: const Color(0xFFD0D0D0),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: 320.w,
                height: 87.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFd9d9d9),
                    width: 0.5,
                  ),
                ),
                child: InkWell(
                  onTap: () => Get.to(MonitorNtuPage(ntu: turbidity)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25.w,
                          height: 35.h,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/icon/water-drop.png',
                                width: 25.w,
                              ),
                              Center(
                                child: Text(
                                  'NTU',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              turbidity,
                              style: TextStyle(
                                color: const Color(0xFF2C2C2C),
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Kekeruhan',
                              style: TextStyle(
                                color: const Color(0xFFD0D0D0),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: 320.w,
                height: 87.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFd9d9d9),
                    width: 0.5,
                  ),
                ),
                child: InkWell(
                  onTap: () =>
                      Get.to(MonitorTempPage(temperature: temperature)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25.w,
                          height: 35.h,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/icon/water-drop.png',
                                width: 25.w,
                              ),
                              Center(
                                  child: Icon(
                                Icons.thermostat,
                                color: Colors.white,
                                size: 18.sp,
                              )),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$temperature°c',
                              style: TextStyle(
                                color: const Color(0xFF2C2C2C),
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text('Suhu',
                                style: TextStyle(
                                  color: const Color(0xFFD0D0D0),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 87.w,
                width: 320.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFd9d9d9),
                    width: 0.5,
                  ),
                ),
                child: buildGoogleMapList(latitude, longitude),
              ),
            ],
          );
        }),
      );
    }
  }

  void _launchGoogleMaps(double lat, double lng) async {
    final Uri url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildGoogleMapList(double latitude, double longitude) {
    if (latitude == 0.0 && longitude == 0.0) {
      return const Center(child: Text('Data tidak tersedia'));
    } else {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('Vokta_app'),
                  position: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                ),
              },
              zoomControlsEnabled: false,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(18)),
            child: InkWell(
              onTap: () => Get.to(MonitorGpsPage(
                latitude: latitude,
                longitude: longitude,
              )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                      height: 35.h,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/icon/water-drop.png',
                            width: 25.w,
                          ),
                          Center(
                            child: Text(
                              'GPS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Lokasi ',
                      style: TextStyle(
                        color: Color(0xFF2C2C2C),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchGoogleMaps(latitude, longitude);
                      },
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF5DCCFC),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget buildGoogleMap(double latitude, double longitude) {
    if (latitude == 0.0 && longitude == 0.0) {
      return const Center(child: Text('Data tidak tersedia'));
    } else {
      return Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
              zoom: 12.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('Vokta_app'),
                position: LatLng(latitude ?? 0.0, longitude ?? 0.0),
              ),
            },
            zoomControlsEnabled: false,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25)),
          child: InkWell(
            onTap: () => Get.to(MonitorGpsPage(
              latitude: latitude,
              longitude: longitude,
            )),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 25.w,
                    height: 35.h,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/icon/water-drop.png',
                          width: 25.w,
                        ),
                        Center(
                          child: Text(
                            'GPS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lokasi ',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchGoogleMaps(latitude, longitude);
                    },
                    child: SizedBox(
                      width: 25.w,
                      height: 25.w,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF5DCCFC),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15.w,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]);
    }
  }
}
