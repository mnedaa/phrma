import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminsController extends GetxController{

  RxList admins = [].obs;

  streamAdmins(){
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((event) {
      admins.value = event.docs.where((element) => element['role'] == 'admin').toList();
    });
    return admins.stream;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    admins.bindStream(streamAdmins());
  }
}