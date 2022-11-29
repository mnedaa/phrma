import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';


class ChatController extends GetxController {

  static ChatController instance = Get.find();

  RxList chat = [].obs;
  RxString sender = ''.obs;
  RxString receiver = ''.obs;

  Rx<TextEditingController> messageController = Rx<TextEditingController>(TextEditingController());

  streamChats() {
    FirebaseFirestore.instance.collection('chats').snapshots().listen((event) {
      chat.value = event.docs.where((element) =>
      element['sender'] == 'admin1@gmail.com'
      ).toList();
    });
    return chat.stream;
  }
  // streamTest() {
  //   var l ;
  //   FirebaseFirestore.instance.collection('chats').snapshots().listen((event) {
  //     l = event.docs.where((element) =>
  //       element['sender'] == sender.value &&
  //               element['receiver'] == receiver.value
  //     );
  //     return
  //     chat.value = l['message'];
  //   });
  //   return chat.stream;
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chat.bindStream(streamChats());
    print('########### After');
    print('########### After');
    print(sender.value);
    print(receiver.value);
  }


}

// class ChatController extends GetxController {
//
//   static ChatController instance = Get.find();
//
//
//   String? sender = AuthController.instance.user.value?.email;
//
//   var res;
//
//   RxList chat = [].obs;
//   RxString receiver = ''.obs;
//
//   Rx<TextEditingController> messageController = Rx<TextEditingController>(TextEditingController());
//
//   streamChat(){
//     // FirebaseFirestore.instance.collection('chats').snapshots().listen((event) {
//     //  event.docs.where((element) {
//     //    if(element['sender'] == 'mnedaa15@gmail.com' && element['receiver'] == 'admin1@gmail.com') {
//     //      return
//     //      chat.value = element['message'];
//     //     }
//     //    return chat.value;
//     //   });
//     // });
//     FirebaseFirestore.instance.collection('chats').snapshots().listen((event) {
//       event.docs.where((element) => element['sender'] || element['receiver'] == 'mnedaa15@gmail.com' ? chat.value = element['message'] : null);
//     });
//     return chat.stream;
//   }
//
//   streamChat2(){
//     FirebaseFirestore.instance.collection('chats').doc('mnedaa15@gmail.com').snapshots().listen((event) {
//       chat.value = event['message'];
//     });
//     return chat.stream;
//   }
//
//   streamReceiver(){
//     FirebaseFirestore.instance.collection('users').doc(AuthController.instance.auth.currentUser?.uid).snapshots().listen((event) {
//       receiver.value = event['email'];
//     });
//     return receiver.stream;
//   }
//
//
//   sentMessage(String message){
//     var time = DateTime.now();
//     var x;
//     FirebaseFirestore.instance.collection('chats').get().then((value) {
//         x = value.docs.where((element) {
//         element['sender'] == '' && element['receiver'] == '';
//         return x;
//       });
//         FirebaseFirestore.instance.collection('chats').doc(x).  update({
//           'message': FieldValue.arrayUnion([{'body':message,'sender':sender,'receiver':receiver.value, 'time':'${time.hour} : ${time.minute}'}])
//         });
//     });
//   }
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     // data.bindStream(getData());
//     receiver.bindStream(streamReceiver());
//     chat.bindStream(streamChat2());
//   }
//
// }