import 'package:get/get.dart';
import 'package:vokta_app/models/tank.dart';

class TankSelectedController extends GetxController {
  Rx<Tank?> tank = Rx<Tank?>(null);

  void setTank(Tank? newTank) {
    tank.value = newTank;
  }
}

final tankSelectedController = TankSelectedController();
