import 'package:grad/app/controller/account/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}
