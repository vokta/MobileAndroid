import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final TandonDetailController _tandonDetailController = Get.put(TandonDetailController());
    // final idTandon = Get.arguments as int;
    // _tandonDetailController.changeIdTandon(idTandon);
    return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Dashboard Page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Kembali ke halaman sebelumnya ketika tombol kembali ditekan
              Get.back();
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TEST NAMA',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('ID Tandon: 2334234'),
                  SizedBox(height: 20),
                  Text('Volume: 34234'),
                  Text('Latitude: 34234'),
                  Text('Longitude: 2342344'),
                  Text('Keasaman: 123123'),
                  Text('Total Padatan Terlarut: 13123123'),
                  Text('Kekeruhan: 33434'),
                ],
              ),
            ),
          ),
        ));
  }
}
