import 'package:get/get.dart';
import 'package:vokta_app/models/tank_event_response.dart';

class TankEventController extends GetxController {
  Rx<TankEventResponse?> tank = TankEventResponse().obs;

  void setSelectedTank(TankEventResponse newTank) {
    tank.value = newTank;
  }
}

final tankEventController = TankEventController();
