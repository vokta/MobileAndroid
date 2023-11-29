import 'package:get/get.dart';
import 'package:vokta_app/models/tank.dart';

class TankController extends GetxController {
  Rx<Tank> tank = Tank().obs;

  void setTank(Tank newTank) {
    tank.value = newTank;
  }
}
