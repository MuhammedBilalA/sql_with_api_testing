import 'package:get/get.dart';
import 'package:sql_with_api_testing/src/presentation/controller/home_screen_controller.dart';

class DependencyBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(HomeScreenController());
  }
}
