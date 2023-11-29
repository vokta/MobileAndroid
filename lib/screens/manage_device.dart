import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/controllers/tank_controller.dart';
import 'package:vokta_app/controllers/tank_event_controller.dart';
import 'package:vokta_app/controllers/tank_list_controller.dart';
import 'package:vokta_app/controllers/tank_selected.dart';
import 'package:vokta_app/models/tank.dart';
import 'package:vokta_app/models/tank_event_response.dart';
import 'package:vokta_app/screens/add_tank_page.dart';
import 'package:vokta_app/services/tank_service.dart';
import 'package:vokta_app/widgets/custom_loading.dart';
import 'package:get/get.dart';

class ManageDevicePage extends StatefulWidget {
  @override
  _ManageDevicePageState createState() => _ManageDevicePageState();
}

class _ManageDevicePageState extends State<ManageDevicePage> {
  final TankService _tankService = TankService();
  final TankController _tankController = Get.put(TankController());
  final _userStorage = GetStorage();
  bool _isLoading = false;
  RxList<Tank> _filteredTankList = <Tank>[].obs;

  @override
  void initState() {
    _retrieveTankList();
    super.initState();
  }

  void _retrieveTankList() async {
    setState(() {
      _isLoading = true;
    });
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

    setState(() {
      filterTankList('');
      _isLoading = false;
    });
  }

  void _retriveTankListApi() async {
    List<Tank> listApiResult = await _tankService.list(context);
    setState(() {
      tankListController.replaceTank(listApiResult);
    });
  }

  void _deleteTank(String uid) async {
    setState(() {
      _isLoading = true;
    });

    String? selectedTank = _userStorage.read('selectedTank');
    if (selectedTank != null) {
      Tank selected = Tank.fromJson(selectedTank);
      if (selected.uid == uid) {
        setState(() {
          tankEventController.setSelectedTank(TankEventResponse());
          tankSelectedController.setTank(null);
        });
      }
    }

    if (uid != '') {
      bool _deleteTank = await _tankService.delete(context, uid);
      if (_deleteTank) {
        _retriveTankListApi();
        setState(() {
          Get.snackbar(
            'Hapus device',
            'Device berhasil di hapus',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          Navigator.pop(context);
        });
      } else {
        setState(() {
          Get.snackbar(
            'Hapus device',
            'Gagal menghapus tangki, coba lagi nanti',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          Navigator.pop(context);
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void filterTankList(String query) {
    _filteredTankList.clear();

    if (query.isEmpty) {
      _filteredTankList.addAll(tankListController.tanks);
    } else {
      _filteredTankList.addAll(tankListController.tanks.where((data) {
        final sensorName = data.sensorName;
        return sensorName != null &&
            sensorName.toLowerCase().contains(query.toLowerCase());
      }));
    }
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
                              "Kelola Device",
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
                          height: 53.h,
                        ),
                        Container(
                          width: 320.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                              color: Color(0xFFF7F8F9),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xFFE8ECF4))),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Icon(size: 20.sp, Icons.search_outlined),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      tankListController.searchQuery.value =
                                          value;
                                    });
                                  },
                                  style: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 16.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Cari sensor',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFF666666),
                                      fontSize: 16.sp,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Device",
                              style: TextStyle(
                                  color: Color(0xFF5DCCFC),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => AddTankPage(
                                      isEdit: false,
                                    ));
                              },
                              child: Icon(
                                Icons.add,
                                color: Color(0xFFB1B1B1),
                                size: 25.sp,
                              ),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Color(0xFFE8ECF4),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Obx(() {
                          return Expanded(
                            child: ListView.builder(
                              itemCount:
                                  tankListController.filteredTanks.length,
                              itemBuilder: (context, index) {
                                Tank data =
                                    tankListController.filteredTanks[index];
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Tank tankData = data;
                                            _tankController.setTank(tankData);
                                            Get.to(() =>
                                                AddTankPage(isEdit: true));
                                          },
                                          child: SizedBox(
                                            height: 40.h,
                                            width: 280.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    "${data.sensorName}",
                                                    style: TextStyle(
                                                      color: Color(0xFF3B3B3B),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDeleteDialog(
                                                    context, data.uid ?? '');
                                              },
                                              child: Center(
                                                  child: Icon(
                                                Icons.delete_forever,
                                                color: Color(0xFFB1B1B1),
                                                size: 25.w,
                                              )),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Color(0xFFE8ECF4),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }),
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

  void showDeleteDialog(BuildContext context, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus Device'),
          content: Text('Apakah Anda yakin akan menghapus device ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteTank(uid);
              },
              child: Text('Yakin'),
            ),
          ],
        );
      },
    );
  }
}
