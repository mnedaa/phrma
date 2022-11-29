import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/view/screens/user_profile.dart';
import 'package:pahrma_gb/view/widgets/custom_patient_card.dart';
import '../../../constance.dart';
import '../../../controller/home_controller.dart';
import 'dart:io';

class Home extends GetWidget<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * 0.09,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: Get.width * 0.8,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none)),
                  onChanged: (val) {
                    controller.check.value == 'users'
                        ? controller.streamUsers(val)
                        : controller.streamAdmins(val);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${controller.check.value}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (controller.check.value == 'admins')
                      TextButton(
                          onPressed: () {
                            TextEditingController _name =
                                TextEditingController();
                            TextEditingController _phone =
                                TextEditingController();
                            TextEditingController _email =
                                TextEditingController();
                            TextEditingController _password =
                                TextEditingController();
                            TextEditingController _age =
                                TextEditingController();
                            GlobalKey<FormState> _formKey =
                                GlobalKey<FormState>();
                            Get.defaultDialog(
                                title: 'Edit',
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      type: FileType.image);
                                          if (result != null) {
                                            controller.addAdminImage.value =
                                                '${result.files.single.path}';
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: Obx(() =>
                                            controller.addAdminImage.value == ''
                                                ? CircleAvatar(
                                                    child: Image.asset(
                                                        'assets/images/male.png'),
                                                    radius: 40,
                                                  )
                                                : CircleAvatar(
                                                    child: Image.file(
                                                        File(controller.addAdminImage
                                                            .value)),
                                                    radius: 40,
                                                  )),
                                      ),
                                      TextFormField(
                                        controller: _name,
                                        decoration:
                                            InputDecoration(hintText: 'Name'),
                                      ),
                                      TextFormField(
                                        controller: _phone,
                                        decoration:
                                            InputDecoration(hintText: 'Phone'),
                                      ),
                                      TextFormField(
                                        controller: _email,
                                        decoration:
                                            InputDecoration(hintText: 'Email'),
                                      ),
                                      TextFormField(
                                        controller: _password,
                                        decoration: InputDecoration(
                                            hintText: 'Password'),
                                      ),
                                      TextFormField(
                                        controller: _age,
                                        decoration:
                                            InputDecoration(hintText: 'Age'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ==
                                            true) {
                                          FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: _email.text.trim(),
                                                  password:
                                                      _password.text.trim())
                                              .then((value) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(value.user?.uid)
                                                .set({
                                              'userId': value.user?.uid,
                                              'name': _name.text.trim(),
                                              'email': value.user?.email,
                                              'gender': 'male',
                                              'age': _age.text.trim(),
                                              'image': controller.addAdminImage
                                                          .value ==
                                                      ''
                                                  ? 'assets/images/male.png'
                                                  : controller
                                                      .addAdminImage.value,
                                              'phone': _phone.text.trim(),
                                              'role': 'admin',
                                              'treatment': [],
                                              'history': [],
                                              'ban': false,
                                              'approved': true,
                                            }, SetOptions(merge: true));
                                          });
                                        }
                                        _email.clear();
                                        _password.clear();
                                        Get.back();
                                      },
                                      child: Text('Submit')),
                                  ElevatedButton(
                                      onPressed: () {
                                        _email.clear();
                                        _password.clear();
                                        Get.back();
                                      },
                                      child: Text('Cancel')),
                                ]);
                          },
                          child: Text('Add Admin +')),
                  ],
                ),
                controller.check.value == 'users'
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: controller.filterUsers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                child: CustomPatientCard(
                              user: controller.filterUsers[index],
                            ));
                          },
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.filterAdmins.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                child: CustomPatientCard(
                              user: controller.filterAdmins[index],
                            ));
                          },
                        ),
                      )
              ],
            )),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.1,
            ),
            Center(
                child: CircleAvatar(
              child: Image.asset(
                'assets/images/pharmaLogo.png',
                fit: BoxFit.contain,
              ),
              radius: 70,
            )),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Text('${AuthController.instance.user.value?.email}'),
            Obx(() => Card(
                  elevation: 5,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Users',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '${controller.allUsers.length}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.person),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Get.to(() => UserProfile());
                },
                title: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  controller.check.value = 'users';
                  Get.back();
                },
                title: Text(
                  'Users',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  controller.check.value = 'admins';
                  Get.back();
                },
                title: Text(
                  'Admins',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Get.defaultDialog(
                      title: 'Wait a second',
                      content: const Center(
                          child: CircularProgressIndicator(
                        color: primaryColor,
                      )));
                  AuthController.instance.auth.signOut();
                  Get.back();
                },
                title: Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
