import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';

class HistoryController extends GetxController{

  RxList historyList = [].obs;

  streamHistory(){
    FirebaseFirestore.instance.collection('users').doc(AuthController.instance.user.value?.uid).snapshots().listen((event) {
      historyList.value = event['history'];
    });
    return historyList.stream;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    historyList.bindStream(streamHistory());
  }
}