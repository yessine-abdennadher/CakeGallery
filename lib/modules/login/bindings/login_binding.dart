
import 'package:get/get.dart';
import 'package:yessine/modules/login/controllers/login_contoller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
