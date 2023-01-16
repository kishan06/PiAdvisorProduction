import 'package:get/get.dart';
import 'package:piadvisory/getx/connection_manager.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}