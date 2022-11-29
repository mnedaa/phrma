import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/controller/user_profile_controller.dart';
import 'package:pahrma_gb/model/user_model.dart';
import 'dart:io';


class UserProfile extends GetWidget<UserProfileController> {
  const UserProfile({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(UserModel.fromJson(controller.userData).name)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView(
                children: [
                  InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(type: FileType.image);
                      if (result != null) {
                        File file = File('${result.files.single.path}');
                        FirebaseFirestore.instance.collection('users').doc(AuthController.instance.auth.currentUser?.uid).set({
                          'image':file.path
                        },SetOptions(merge: true));
                      } else {
                        // User canceled the picker
                      }

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: CircleAvatar(
                        child: UserModel.fromJson(controller.userData).image,
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      onTap: (){controller.edit('name');AuthController.instance.user.value?.updateDisplayName('${UserModel.fromJson(controller.userData).name}');},
                      title: Text('Name : ${UserModel.fromJson(controller.userData).name}'),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      onTap: (){controller.edit('phone');},
                      title: Text('Phone : +05 ${UserModel.fromJson(controller.userData).phone}'),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      onTap: (){controller.edit('email');},
                      title: Text('Email : ${UserModel.fromJson(controller.userData).email}'),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      onTap: (){controller.edit('age');},
                      title: Text('Age : ${UserModel.fromJson(controller.userData).age}'),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
