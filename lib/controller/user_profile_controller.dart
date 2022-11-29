import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';

class UserProfileController extends GetxController{

  RxMap userData = {}.obs ;

  streamUserData(){
    FirebaseFirestore.instance.collection('users').doc(AuthController.instance.user.value?.uid).snapshots().listen((event) {
      userData.value = event.data()!;
    });
    return userData.stream;
  }

  edit(String field){
    TextEditingController controller = TextEditingController();
    return
    Get.defaultDialog(
      title: 'Edit',
      content: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter New Data'
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          FirebaseFirestore.instance.collection('users').doc(AuthController.instance.auth.currentUser?.uid).set({
            field:controller.text.trim()
          },SetOptions(merge: true));
          controller.clear();
          Get.back();
        }, child: Text('Submit')),
        ElevatedButton(onPressed: (){
          controller.clear();
          Get.back();
        }, child: Text('Cancel')),
      ]
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userData.bindStream(streamUserData());
  }
}