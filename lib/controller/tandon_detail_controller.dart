import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vokta_app/model/tandon_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TandonDetailController extends GetxController {
  var tandonDetail = TandonDetail(
    id: 0,
    nama: "",
    idTandon: "",
    persentase: 0,
    latitude: 0,
    longitude: 0,
    ph: 0,
    tds: 0,
    ntu: 0,
  ).obs;
  var isLoading = false.obs;
  var idTandon = 0.obs;
  
  void changeIdTandon(int newId) {
    idTandon.value = newId;
  }

  @override
  void onInit() {
    fetchTandonDetail(idTandon);
    super.onInit();
  }

  Future<void> fetchTandonDetail(RxInt id) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('accessToken') ?? '';

    final url = Uri.parse('http://10.0.2.2:8000/api/tandon-detail/$id');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      tandonDetail.value = TandonDetail.fromJson(responseData);
    } else {
      // Handle error
      print('Failed to fetch data: ${response.statusCode}');
    }

    isLoading.value = false;
  }
}