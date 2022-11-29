import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pahrma_gb/control_view.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/controller/user_home_controller.dart';
import 'package:pahrma_gb/view/widgets/custom_text_form_field.dart';
import 'dart:io';

class HomeController extends GetxController {
  TextEditingController searchBarController = TextEditingController();
  TextEditingController treatmentName = TextEditingController();
  TextEditingController treatmentDose = TextEditingController();
  TextEditingController treatmentDuration = TextEditingController();
  RxList allUsers = [].obs;
  RxList filterNewUsers = [].obs;
  RxList filterUsers = [].obs;
  RxList filterAdmins = [].obs;
  RxList treatmentHistory = [].obs;
  RxString check = 'users'.obs;
  RxBool isBanned = false.obs;
  RxString chosenImage = ''.obs;
  RxString addAdminImage = ''.obs;

  /// Method to stream on users

  Stream<List> streamUsers(String userName) {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((event) {
        filterUsers.value = event.docs
            .where((element) =>
                (element['name'] as String).toLowerCase().contains(userName) && element['role'] == 'user')
            .toList();
      });
      return filterUsers.stream;

  }

  /// Method to stream on admins

  Stream<List> streamAdmins(String userName) {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((event) {
        filterAdmins.value = event.docs
            .where((element) =>
                (element['name'] as String).toLowerCase().contains(userName) && element['role'] == 'admin')
            .toList();
      });
      return filterAdmins.stream;
  }

  /// get All Users to Count

  Stream<List> streamCountUsers() {
    /// get All Users

    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      allUsers.value = event.docs.toList();
    });
    return allUsers.stream;


  }

  /// check is user Banned

  Stream<bool> streamBanned() {

    FirebaseFirestore.instance.collection('users').doc(AuthController.instance.user.value?.uid).snapshots().listen((event) {
      isBanned.value = event['ban'];
    });
    return isBanned.stream;
  }

  /// stream on user history

  Stream<List> streamHistory(userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).snapshots().listen((event) {
      treatmentHistory.value = event['history'];
    });
    return treatmentHistory.stream;
  }

  /// Pick Image

  pickImage() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File('${result.files.single.path}');
      chosenImage.value = file.path;
    } else {
      // User canceled the picker
    }
  }

  /// Add Treatment to User
  
  addTreatment(userId){
    Get.defaultDialog(
      title: 'Adding new treatment',
      content: Column(
        children: [
          CustomTextFormField(
                labelText: 'Name',
                icon: Icon(Icons.edit),
                onChanged: (val) {
                  treatmentName.text = val!;
                },
                validator: (String? value) =>
                    value!.isEmpty ? 'Enter Treatment Name' : null),
          SizedBox(height: 20,),
          CustomTextFormField(
                labelText: 'Total Dose',
                textInputType: TextInputType.number,
                icon: Icon(Icons.edit),
                onChanged: (val) {
                  treatmentDose.text = val!;
                },
                validator: (String? value) =>
                    value!.isEmpty ? 'Enter Treatment Dose' : null),
          SizedBox(height: 20,),
          CustomTextFormField(
                labelText: 'Duration (In Hours)',
                textInputType: TextInputType.number,
                icon: Icon(Icons.edit),
                onChanged: (val) {
                  treatmentDuration.text = val!;
                },
                validator: (String? value) =>
                    value!.isEmpty ? 'Enter Treatment Duration' : null),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            pickImage();
          }, child: Text('Select Treatment Image'))
          ],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          FirebaseFirestore.instance.collection('users').doc(userId).set({
            'treatment': {
              treatmentName.text.trim(): {
                'name': treatmentName.text.trim(),
                'dose': int.parse(treatmentDose.text.trim()),
                'image': chosenImage.value,
                'duration': int.parse(treatmentDuration.text.trim()),
                'sound': '',
                'active': true,
                'lastDose': DateTime.now(),
                'nextDose': DateTime.now().add(Duration(
                    seconds: int.parse(treatmentDuration.text.trim()))),
              }
            }
          },SetOptions(merge: true));
          Get.back();
        }, child: Text('Add')),
        ElevatedButton(onPressed: (){
          Get.back();
        }, child: Text('Cancel')),
      ]
    );
  }

  /// Ban User

  banUser(){
    if(isBanned.value == false){
      Get.defaultDialog(
        title: 'Alert !',
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text('Are You Sure ?'),
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            FirebaseFirestore.instance.collection('users').doc(AuthController.instance.user.value?.uid).set({
              'ban':true,
              'approved':false
            },SetOptions(merge: true));
            Get.back();
            Get.offAll(()=> ControlView());
          }, child: Text('Sure')),
          ElevatedButton(onPressed: (){
            Get.back();
          }, child: Text('Cancel')),
        ],
      );
    }
    else{
      Get.defaultDialog(
        title: 'Alert !',
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text('Are You Sure ?'),
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            FirebaseFirestore.instance.collection('users').doc(AuthController.instance.user.value?.uid).set({
              'ban':false,
              'approved':true
            },SetOptions(merge: true));
            Get.back();
            Get.offAll(()=> ControlView());
          }, child: Text('Sure')),
          ElevatedButton(onPressed: (){
            Get.back();
          }, child: Text('Cancel')),
        ],
      );
    }
  }

  /// Approve User

  approve(id){
    Get.defaultDialog(
      title: 'Alert !',
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text('Are You Sure ?'),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          FirebaseFirestore.instance.collection('users').doc(id).set({
            'approved':true
          },SetOptions(merge: true));
          Get.back();
        }, child: Text('Sure')),
        ElevatedButton(onPressed: (){
          Get.back();
        }, child: Text('Cancel')),
      ],
    );
  }

  // streamNewUsers(){
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .snapshots()
  //       .listen((event) {
  //     filterNewUsers.value = event.docs.where((element) => element['approved'] == false).toList();
  //   });
  //   return filterNewUsers.stream;
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    filterUsers.bindStream(streamUsers(searchBarController.text));
    filterNewUsers.bindStream(streamUsers(searchBarController.text));
    filterAdmins.bindStream(streamAdmins(searchBarController.text));
    allUsers.bindStream(streamCountUsers());
    isBanned.bindStream(streamBanned());

  }
}
