import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.13,
            height: MediaQuery.of(context).size.width * 0.13,
            child: ClipOval(
              child: Material(
                color: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                  color: Color.fromRGBO(93, 204, 252, 1),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70, top: 10),
                    child: Center(
                        child: Text('Monitor', style: TextStyle(fontSize: 20))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.33,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromRGBO(93, 204, 252, 1),
                                width: 1.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height:
                                      MediaQuery.of(context).size.width * 0.06,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.lightBlue[100]),
                                  child: Center(
                                      child: Text('pH',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  93, 204, 252, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8))),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Text('0.55',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32)),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.004,
                                ),
                                Text('Keasaman',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 12))
                              ]),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.33,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromRGBO(93, 204, 252, 1),
                                width: 1.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height:
                                      MediaQuery.of(context).size.width * 0.06,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.lightBlue[100]),
                                  child: Center(
                                      child: Text('TDS',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  93, 204, 252, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 8))),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Text('500',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32)),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.004,
                                ),
                                Text('Kepadatan',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 12))
                              ]),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.33,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(93, 204, 252, 1),
                                  width: 1.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                    height: MediaQuery.of(context).size.width *
                                        0.06,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.lightBlue[100]),
                                    child: Center(
                                        child: Text('pH',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    93, 204, 252, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8))),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Text('0.55',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.004,
                                  ),
                                  Text('Suhu',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12))
                                ]),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.33,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(93, 204, 252, 1),
                                  width: 1.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                    height: MediaQuery.of(context).size.width *
                                        0.06,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.lightBlue[100]),
                                    child: Center(
                                        child: Text('pH',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    93, 204, 252, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8))),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Text('0.55',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.004,
                                  ),
                                  Text('Kekeruhan',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12))
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.33,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromRGBO(93, 204, 252, 1),
                              width: 1.0)),
                      child: Row(
                        children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.06,
                                    height:
                                        MediaQuery.of(context).size.width * 0.06,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.lightBlue[100]),
                                    child: Center(
                                        child: Text('GPS',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    93, 204, 252, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8))),
                                  ),
                                  Text('Lokasi')
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  Text('500',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32)),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.004,
                                  ),
                                  Text('Kepadatan',
                                      style: TextStyle(
                                          color: Colors.grey[400], fontSize: 12))
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Text('500',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32)),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.004,
                                ),
                                Text('Kepadatan',
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 12))
                              ]),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
