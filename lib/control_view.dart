import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pahrma_gb/view/screens/admin/home.dart';
import 'package:pahrma_gb/view/screens/auth/login.dart';
import 'package:pahrma_gb/view/screens/main_screen.dart';
import 'package:pahrma_gb/view/screens/user_home.dart';
import 'controller/auth_controller.dart';

class ControlView extends GetWidget<AuthController> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (controller.user.value?.uid == null)
          ? const LogIn()
          : controller.isApproved.value == false ? MainScreen(): controller.role.value == 'user'? UserHome() : Home();
    });
  }
}
