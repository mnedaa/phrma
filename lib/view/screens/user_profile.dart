import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/user_profile_controller.dart';
import 'package:pahrma_gb/model/user_model.dart';


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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: CircleAvatar(
                      child: UserModel.fromJson(controller.userData).image,
                      radius: 60,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      onTap: (){controller.edit('name');},
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
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}


class AdminProfile extends GetWidget<UserProfileController> {
  const AdminProfile({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserModel.fromJson(controller.userData).name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('ss'),
      ),
    );
  }
}
