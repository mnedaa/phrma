import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/controller/chat_controller.dart';
import 'package:pahrma_gb/controller/home_controller.dart';
import 'package:pahrma_gb/model/user_model.dart';
import 'package:pahrma_gb/view/screens/admin/show_user_treatment.dart';
import 'package:pahrma_gb/view/screens/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientDetails extends GetWidget<HomeController> {
  const PatientDetails({Key? key, required this.userData}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>>? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserModel.fromJson(userData!).name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: CircleAvatar(
                      child: UserModel.fromJson(userData!).image,
                      radius: 60,
                    ),
                  ),
                  Obx(() => controller.isBanned.value == true
                      ? Center(
                          child: Text(
                          'Banned User',
                          style: TextStyle(color: Colors.red),
                        ))
                      : Center(child: Text('UnBanned User'))),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      title:
                          Text('Name : ${UserModel.fromJson(userData!).name}'),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      title: Text('Age : ${UserModel.fromJson(userData!).age}'),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                          'Phone : +05 ${UserModel.fromJson(userData!).phone}'),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                          'Email : ${UserModel.fromJson(userData!).email}'),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 3,
                    child: ListTile(
                      title: UserModel.fromJson(userData!).approved
                          ? Text('Approved')
                          : Text('Not Approved'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            String sender =
                                '${AuthController.instance.user.value?.email}';
                            String receiver =
                                UserModel.fromJson(userData!).email;
                            print(sender);
                            print(receiver);
                            ChatController.instance.sender.value = sender;
                            ChatController.instance.receiver.value = receiver;
                            Get.to(() => Chat(sender, receiver));
                          },
                          child: Icon(Icons.message)),
                      ElevatedButton(
                          onPressed: () {
                            Future<void> _launchUrl() async {
                              if (!await launchUrl(Uri.parse(
                                  "whatsapp://send?phone=+05${UserModel.fromJson(userData!).phone}/?text=hi"))) {
                                throw 'Could not launch';
                              }
                            }

                            _launchUrl();
                          },
                          child: Icon(Icons.whatsapp)),
                      if (UserModel.fromJson(userData!).approved == false)
                        ElevatedButton(
                          onPressed: () {
                            controller.approve(
                                '${UserModel.fromJson(userData!).userId}');
                          },
                          child: Text('Approved'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => ShowTreatment(user: userData));
                          },
                          child: Text('Show Treatment')),
                      Obx(() => controller.isBanned.value == false
                          ? ElevatedButton(
                              onPressed: () {
                                controller.banUser();
                              },
                              child: Text('Ban User'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                controller.banUser();
                              },
                              child: Text('UnBan User'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                            )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
