import 'package:get/get.dart';
import 'package:vokta_app/models/tank.dart';

class TankListController extends GetxController {
  var tanks = <Tank>[].obs;
  var searchQuery = ''.obs;

  void replaceTank(List<Tank> tankList) {
    tanks.clear();
    tanks.addAll(tankList);
  }

  List<Tank> get filteredTanks {
    if (searchQuery.value.isEmpty) {
      return tanks;
    } else {
      return tanks
          .where((tank) =>
              tank.sensorName
                  ?.toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ??
              false)
          .toList();
    }
  }
}

final tankListController = TankListController();
