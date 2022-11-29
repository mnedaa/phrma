import 'package:get/get.dart';
import 'package:pahrma_gb/controller/admins_controller.dart';
import 'package:pahrma_gb/controller/history_controller.dart';
import 'package:pahrma_gb/controller/treatment_card_controller.dart';
import 'package:pahrma_gb/controller/user_home_controller.dart';
import 'package:pahrma_gb/controller/user_profile_controller.dart';
import '../controller/admin_home_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/home_controller.dart';
import '../controller/chat_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AdminHomeController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => UserHomeController(), fenix: true);
    Get.lazyPut(() => TreatmentCardController(), fenix: true);
    Get.lazyPut(() => UserProfileController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => AdminsController(), fenix: true);
    Get.lazyPut(() => HistoryController(), fenix: true);
  }
}