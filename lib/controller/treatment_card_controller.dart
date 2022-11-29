import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:async/async.dart';
import 'package:pahrma_gb/controller/user_home_controller.dart';
import 'package:pahrma_gb/model/treatment_model.dart';

class TreatmentCardController extends GetxController{

  static AuthController instance = Get.find();

  // final TreatmentModel treatment = TreatmentModel();
  late RxInt dose ;
  var item ;
  RxMap treatments = {}.obs;
  // Duration oneSec = const Duration(seconds: 1);
  // RxInt time = 0.obs;
  // DateTime now = DateTime.now();

  RxInt takenDose = 0.obs;
  RxInt duration = 0.obs;
  RxBool active = true.obs;
  Rx<DateTime> lastDose = DateTime.now().obs;

  // treatmentListStream(){
  //   FirebaseFirestore.instance.collection('users').
  //   doc(AuthController.instance.auth.currentUser?.uid).snapshots().listen((event) {
  //     treatment.value = event['treatment'];
  //   });
  //   return treatment.stream;
  // }

  // activeButton(RxInt time, taken, treatment, item, RxBool active){
  //   return active.value == true ? ElevatedButton(
  //     onPressed: () {
  //       active.value = false;
  //       var t = time.value;
  //       Timer.periodic(
  //         oneSec,
  //             (Timer timer) {
  //           if (time.value == 0) {
  //             timer.cancel();
  //             active.value = true;
  //             time.value = t;
  //             UserHomeController().showNotification();
  //           } else {
  //             time.value--;
  //           }
  //         },
  //       );
  //
  //       if (taken.value != int.parse(treatment.dosePerDay)) {
  //         taken.value++;
  //       } else {
  //         FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(AuthController.instance.currentUser?.uid)
  //             .set({
  //           'treatment': FieldValue.arrayRemove([item])
  //         }, SetOptions(merge: true));
  //       }
  //     },
  //     child: Text('Take Dose'),
  //   ):Obx(() => Text('Next Dose in : $time'));
  // }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // time.bindStream(isAllow());
  }
}