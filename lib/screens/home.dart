import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vokta_app/screens/add_tank_page.dart';
import 'package:vokta_app/screens/home_page.dart';
import 'package:vokta_app/screens/profile_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomePage(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Get.to(() => AddTankPage(
                    isEdit: false,
                  ));
            } else if (index == 2) {
              Get.to(() => ProfilePage());
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          selectedItemColor: Color.fromRGBO(93, 204, 252, 1),
          unselectedItemColor: Colors.grey,
        ));
  }
}
