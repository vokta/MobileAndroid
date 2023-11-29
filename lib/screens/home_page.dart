import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/controllers/tank_event_controller.dart';
import 'package:vokta_app/controllers/tank_list_controller.dart';
import 'package:vokta_app/controllers/tank_selected.dart';
import 'package:vokta_app/controllers/user_controller.dart';
import 'package:vokta_app/models/tank.dart';
import 'package:vokta_app/models/tank_event_response.dart';
import 'package:vokta_app/models/user.dart';
import 'package:vokta_app/screens/monitor_page.dart';
import 'package:vokta_app/widgets/animated_radial_gauge.dart';
import 'package:vokta_app/services/tank_service.dart';
import 'package:vokta_app/services/user_service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService _userService = UserService();
  final TankService _tankService = TankService();
  final _userStorage = GetStorage();
  bool _isLoading = false;
  bool _isClicked = false;
  List<Tank> _listTank = [];

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    _retrieveUser();
    _retrieveTankList();
    _retrieveTankEvent();
    super.initState();

    setState(() {
      _isLoading = false;
    });
  }

  void _retrieveUser() async {
    final userJson = _userStorage.read('user');

    if (userJson != null) {
      User user = User.fromJson(userJson);
      setState(() {
        userController.updateFullName('${user.firstname} ${user.lastname}');
        userController.updateEmail(user.email);
      });
    } else {
      User user = await _userService.retrieveUser(context);
      setState(() {
        userController.updateFullName('${user.firstname} ${user.lastname}');
        userController.updateEmail(user.email);
      });
    }
  }

  void _retrieveTankList() async {
    String? tankListJson = _userStorage.read('tankList');

    if (tankListJson != null) {
      List<dynamic> jsonList = jsonDecode(tankListJson);
      List<Tank> localTankList =
          jsonList.map((item) => Tank.fromJson(item)).toList();
      setState(() {
        tankListController.replaceTank(localTankList);
      });
    } else {
      _retriveTankListApi();
    }
  }

  void _retriveTankListApi() async {
    List<Tank> listApiResult = await _tankService.list(context);
    setState(() {
      tankListController.replaceTank(listApiResult);
    });
  }

  void _retrieveTankEvent() async {
    final selected = _userStorage.read('selectedTank');
    final tankEvent = _userStorage.read('tankEvent');

    if (selected != null) {
      Tank tank = Tank.fromJson(selected);
      setState(() {
        tankSelectedController.setTank(tank);
      });
    } else {
      setState(() {
        tankSelectedController.setTank(null);
      });
    }

    if (tankEvent != null) {
      TankEventResponse tankEventResponse =
          TankEventResponse.fromJson(tankEvent);
      setState(() {
        tankEventController.setSelectedTank(tankEventResponse);
      });
    } else {
      TankEventResponse tankResponse = TankEventResponse();
      setState(() {
        tankEventController.setSelectedTank(tankResponse);
      });
    }
  }

  void _changeDropdown(Tank tank) {
    if (tank.uid != null && tank.uid != '') {
      _userStorage.write('selectedTank', tank.toJson());
      _retrieveTankEventApi(tank.uid ?? '');
      setState(() {
        tankSelectedController.setTank(tank);
      });
    }
  }

  void _retrieveTankEventApi(String uid) async {
    TankEventResponse eventResponse = await _tankService.event(context, uid);
    setState(() {
      tankEventController.setSelectedTank(eventResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Stack(children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/svg/map.svg',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            child: ListView(
              children: [
                SizedBox(
                  height: 160.h,
                ),
                Obx(() {
                  double levelInPercents = 0.0;

                  if (tankEventController.tank.value!.events?.levelInPercents !=
                      null) {
                    try {
                      levelInPercents = double.parse(tankEventController
                          .tank.value!.events!.levelInPercents!);
                    } catch (e) {
                      print('Error parsing levelInPercents: $e');
                    }
                  }
                  return Center(
                    child: Container(
                        width: 250.w,
                        child: AnimatedRadialGauge(
                          levelInPercents: levelInPercents,
                        )),
                  );
                }),
                Obx(() {
                  String volume =
                      tankEventController.tank.value!.events?.levelInLiters ??
                          '0';
                  String capacity =
                      tankEventController.tank.value?.capacity ?? '0';

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 116.h,
                        height: 63.w,
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFE8ECF4)),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Volume',
                                style: TextStyle(
                                  color: Color(0xFF2C2C2C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text.rich(TextSpan(
                                  text: volume,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' liter',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ])),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 116.h,
                        height: 63.w,
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFE8ECF4)),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kapasitas',
                                style: TextStyle(
                                  color: Color(0xFF2C2C2C),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text.rich(TextSpan(
                                  text: capacity,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' liter',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ])),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 27.w,
                ),
                UnconstrainedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(MonitorPage());
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color.fromRGBO(93, 204, 252, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                      ),
                      child: Container(
                          width: 190.w,
                          height: 20.h,
                          child: Center(
                            child: Text(
                              'Cek Kualitas',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          Positioned(
            top: -30.h,
            child: Container(
                width: 360.w,
                height: 220.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(93, 204, 252, 1),
                      Color.fromRGBO(126, 208, 243, 1)
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Image.asset(
                          'assets/images/vokta_logo.png',
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(() {
                          return Text(
                            "Hallo, ${userController.fullName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                        Text(
                          "Bagaimana kabar air mu hari ini?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 19.h),
                        Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 244, 244, 1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Color.fromRGBO(232, 236, 244, 1))),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownSearch<Tank>(
                              onChanged: (Tank? value) {
                                if (value != null) {
                                  _changeDropdown(value);
                                }
                              },
                              items: tankListController.tanks,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: TextStyle(fontSize: 16.sp),
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "Pilih Tangki",
                                  border: InputBorder.none,
                                ),
                              ),
                              itemAsString: (Tank tank) =>
                                  tank.sensorName ?? '',
                              selectedItem: tankSelectedController.tank.value,
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
