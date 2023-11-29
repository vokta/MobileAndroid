import 'package:get/get.dart';

class UserController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;

  void updateFullName(String newFullName) {
    fullName.value = newFullName;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }
}

final userController = UserController();
