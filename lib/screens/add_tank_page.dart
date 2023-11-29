import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vokta_app/controllers/tank_controller.dart';
import 'package:vokta_app/controllers/tank_list_controller.dart';
import 'package:vokta_app/models/tank.dart';
import 'package:vokta_app/models/tank_brand.dart';
import 'package:vokta_app/models/tank_type.dart';
import 'package:vokta_app/services/tank_service.dart';
import 'package:vokta_app/widgets/custom_loading.dart';
import 'package:vokta_app/widgets/custom_textfield_error.dart';

class AddTankPage extends StatefulWidget {
  final bool isEdit;

  AddTankPage({required this.isEdit});

  @override
  AddTankPageState createState() => AddTankPageState();
}

class AddTankPageState extends State<AddTankPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TankService _tankService = TankService();
  final TankController tankController = Get.put(TankController());
  TextEditingController _idSensorController = TextEditingController();
  TextEditingController _nameSensorController = TextEditingController();
  TextEditingController _diameterController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _capacityController = TextEditingController();
  List<TankBrand> _listTankBrand = [];
  List<TankType> _listTankType = [];
  List<String> _tankTypeDropDown = [];
  TankBrand? _selectedBrand = null;
  String? _selectedType = null;
  bool _isLoading = false;
  String _idSensorErrorMessage = "";
  String _nameSensorErrorMessage = "";
  String _tankTypeErrorMessage = "";
  String _tankBrandErrorMessage = "";
  String? _uidTank = '';

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    setState(() {
      _isLoading = true;
    });
    await _retrieveTankBrand();
    if (widget.isEdit) {
      _editDataPage();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _editDataPage() async {
    Tank? tank = tankController.tank.value;
    _uidTank = tank.uid;

    Tank tankDetail = await _tankService.detail(context, _uidTank ?? "");

    _idSensorController.text = tankDetail.sensorId ?? '';
    _nameSensorController.text = tankDetail.sensorName ?? '';

    TankBrand? brand =
        findBrandByName(_listTankBrand, tankDetail.tankBrand ?? '');

    if (brand != null) {
      _selectedBrand = brand;
      await _retrieveTankType(brand.uid);

      if (_listTankType.isNotEmpty) {
        TankType? tankType =
            findTypeByName(_listTankType, tankDetail.tankType ?? '');

        if (tankType != null) {
          _selectedType = tankType.name;
          _diameterController.text = tankDetail.diameter ?? '';
          _heightController.text = tankDetail.height ?? '';
          _capacityController.text = tankDetail.capacity ?? '';
        }
      }
    }
  }

  TankBrand? findBrandByName(List<TankBrand> tankBrandList, String name) {
    for (TankBrand tankBrand in tankBrandList) {
      if (tankBrand.name == name) {
        return tankBrand;
      }
    }
    return null;
  }

  TankType? findTypeByName(List<TankType> tankTypeList, String name) {
    for (TankType tankType in tankTypeList) {
      if (tankType.name == name) {
        return tankType;
      }
    }
    return null;
  }

  Future<void> _retrieveTankBrand() async {
    List<TankBrand> _resultTankBrand = await _tankService.tankBrandList();

    setState(() {
      _listTankBrand = _resultTankBrand;
    });
  }

  Future<void> _retrieveTankType(String brandUid) async {
    List<TankType> _resultTankType = await _tankService.tankTypeList(brandUid);

    setState(() {
      _tankTypeDropDown =
          _resultTankType.map((tankType) => tankType.name).toList();
      _listTankType = _resultTankType;
      _selectedType = null;
      _diameterController.text = '';
      _heightController.text = '';
      _capacityController.text = '';
      _isLoading = false;
    });
  }

  void _typeSelected(String type) async {
    TankType? tankType = findTypeByName(_listTankType, type);
    setState(() {
      _selectedType = tankType?.name;
      _diameterController.text = tankType?.diameter ?? '';
      _heightController.text = tankType?.height ?? '';
      _capacityController.text = tankType?.capacity ?? '';
    });
  }

  void _submitUpdateForm() async {
    setState(() {
      _isLoading = true;
      _tankBrandErrorMessage = '';
      _tankTypeErrorMessage = '';
    });

    _formKey.currentState!.validate();

    if (_selectedBrand == null || _selectedBrand?.name == '') {
      setState(() {
        _tankBrandErrorMessage = 'Merek tangki tidak boleh kosong';
      });
    }

    if (_selectedType == null || _selectedType == '') {
      setState(() {
        _tankTypeErrorMessage = 'Tipe tangki tidak boleh kosong';
      });
    }

    if (_idSensorErrorMessage == '' &&
        _nameSensorErrorMessage == '' &&
        _tankBrandErrorMessage == '' &&
        _tankTypeErrorMessage == '' &&
        _uidTank != '') {
      Tank tank = Tank(
          uid: _uidTank,
          sensorId: _idSensorController.text,
          sensorName: _nameSensorController.text,
          tankBrand: _selectedBrand?.name ?? '',
          tankType: _selectedType ?? '',
          capacity: _capacityController.text,
          diameter: _diameterController.text,
          height: _heightController.text);
      bool _updateTankStatus = await _tankService.updateTank(tank, context);
      if (_updateTankStatus) {
        setState(() {
          _retriveTankListApi();
          Get.back();

          Get.snackbar(
            'Update tangki',
            'Selamat update tangki berhasil',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        });
      } else {
        setState(() {
          Get.snackbar(
            'Update tangki',
            'Gagal menambahkan mengupdate tangki, coba lagi nanti',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
      _tankBrandErrorMessage = '';
      _tankTypeErrorMessage = '';
    });

    _formKey.currentState!.validate();

    if (_selectedBrand == null || _selectedBrand?.name == '') {
      setState(() {
        _tankBrandErrorMessage = 'Merek tangki tidak boleh kosong';
      });
    }

    if (_selectedType == null || _selectedType == '') {
      setState(() {
        _tankTypeErrorMessage = 'Tipe tangki tidak boleh kosong';
      });
    }

    if (_idSensorErrorMessage == '' &&
        _nameSensorErrorMessage == '' &&
        _tankBrandErrorMessage == '' &&
        _tankTypeErrorMessage == '') {
      Tank tank = Tank(
          sensorId: _idSensorController.text,
          sensorName: _nameSensorController.text,
          tankBrand: _selectedBrand?.name ?? '',
          tankType: _selectedType ?? '',
          capacity: _capacityController.text,
          diameter: _diameterController.text,
          height: _heightController.text);
      bool _addTankStatus = await _tankService.addTank(tank, context);
      if (_addTankStatus) {
        _retriveTankListApi();
        setState(() {
          _idSensorController.text = '';
          _nameSensorController.text = '';
          _selectedBrand = null;
          _selectedType = null;
          _diameterController.text = '';
          _heightController.text = '';
          _capacityController.text = '';

          Get.snackbar(
            'Tambah tangki',
            'Selamat tangki berhasil ditambahkan',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        });
      } else {
        setState(() {
          Get.snackbar(
            'Tambah tangki',
            'Gagal menambahkan tangki, coba lagi nanti',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _retriveTankListApi() async {
    List<Tank> listApiResult = await _tankService.list(context);
    setState(() {
      tankListController.replaceTank(listApiResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Image.asset(
                        'assets/images/vokta_logo_blue.png',
                        height: 40.h,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              width: 320.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 236, 244, 1))),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _idSensorController,
                                      style: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Masukan ID Sensor',
                                          hintStyle: TextStyle(
                                            color: Color(0xFFB0B0B0),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          _idSensorErrorMessage =
                                              'ID sensor tidak boleh kosong';
                                        } else {
                                          _idSensorErrorMessage = '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_idSensorErrorMessage != '')
                              CustomTextFieldError(
                                  message: _idSensorErrorMessage),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              width: 320.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 236, 244, 1))),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _nameSensorController,
                                      style: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Masukan Nama Sensor',
                                          hintStyle: TextStyle(
                                            color: const Color(0xFFB0B0B0),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          _nameSensorErrorMessage =
                                              'Name sensor tidak boleh kosong';
                                        } else {
                                          _nameSensorErrorMessage = '';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_nameSensorErrorMessage != '')
                              CustomTextFieldError(
                                  message: _nameSensorErrorMessage),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              width: 320.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 236, 244, 1))),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownSearch<TankBrand>(
                                items: _listTankBrand,
                                onChanged: (TankBrand? value) {
                                  if (value != null) {
                                    TankBrand tank = TankBrand(
                                        uid: value.uid, name: value.name);
                                    setState(() {
                                      _selectedBrand = tank;
                                    });
                                    _retrieveTankType(tank.uid);
                                  }
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  baseStyle: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 14.sp,
                                  ),
                                  dropdownSearchDecoration: InputDecoration(
                                      hintText: "Merek Tangki",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: const Color(0xFFB0B0B0),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                                itemAsString: (TankBrand tankBrand) =>
                                    tankBrand.name,
                                selectedItem: _selectedBrand,
                              ),
                            ),
                            if (_tankBrandErrorMessage != '')
                              CustomTextFieldError(
                                  message: _tankBrandErrorMessage),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              width: 320.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 236, 244, 1))),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownSearch<String>(
                                items: _tankTypeDropDown,
                                onChanged: (String? value) =>
                                    _typeSelected(value ?? ''),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  baseStyle: TextStyle(
                                    color: const Color(0xFF2C2C2C),
                                    fontSize: 14.sp,
                                  ),
                                  dropdownSearchDecoration: InputDecoration(
                                      hintText: "Tipe Tangki",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: const Color(0xFFB0B0B0),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                                selectedItem: _selectedType,
                                popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchDelay: Duration.zero,
                                    title: Text("Cari tipe tandon")),
                              ),
                            ),
                            if (_tankTypeErrorMessage != '')
                              CustomTextFieldError(
                                  message: _tankTypeErrorMessage),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150.w,
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
                                      Expanded(
                                        child: TextFormField(
                                          enabled: false,
                                          controller: _diameterController,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 140, 140, 140),
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Diameter',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFFB0B0B0),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "cm",
                                            style: TextStyle(
                                              color: Color(0xFF2C2C2C),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.w,
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
                                      Expanded(
                                        child: TextFormField(
                                          enabled: false,
                                          controller: _heightController,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 140, 140, 140),
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Tinggi',
                                              hintStyle: TextStyle(
                                                color: const Color(0xFFB0B0B0),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "cm",
                                            style: TextStyle(
                                              color: Color(0xFF2C2C2C),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              width: 320.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Color.fromRGBO(232, 236, 244, 1))),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      enabled: false,
                                      controller: _capacityController,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 140, 140, 140),
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Kapasitas',
                                          hintStyle: TextStyle(
                                            color: const Color(0xFFB0B0B0),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Liter",
                                        style: TextStyle(
                                          color: Color(0xFF2C2C2C),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            if (!widget.isEdit)
                              UnconstrainedBox(
                                child: ElevatedButton(
                                    onPressed: () {
                                      _submitForm();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor:
                                          Color.fromRGBO(93, 204, 252, 1),
                                    ).copyWith(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(200.w, 40.h)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Tambah Tangki',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            if (widget.isEdit)
                              UnconstrainedBox(
                                child: ElevatedButton(
                                    onPressed: () {
                                      _submitUpdateForm();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor:
                                          Color.fromRGBO(93, 204, 252, 1),
                                    ).copyWith(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(200.w, 40.h)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Update Tangki',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            SizedBox(
                              height: 50.h,
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
        if (_isLoading) CustomLoading()
      ],
    );
  }
}
