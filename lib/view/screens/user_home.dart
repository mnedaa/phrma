import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/control_view.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/controller/user_home_controller.dart';
import 'package:pahrma_gb/model/treatment_model.dart';
import 'package:pahrma_gb/view/screens/admins_screen.dart';
import 'package:pahrma_gb/view/screens/auth/login.dart';
import 'package:pahrma_gb/view/screens/chat_screen.dart';
import 'package:pahrma_gb/view/screens/history.dart';
import 'package:pahrma_gb/view/screens/user_profile.dart';

class UserHome extends GetWidget<UserHomeController> {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment Reminder'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.treatment.length,
                      itemBuilder: (context, index) {
                        var i = controller.treatment.keys.toList()[index];
                        var nowDate = DateTime.now();
                        var treatmentName =
                            TreatmentModel.fromJson(controller.treatment[i])
                                .name;
                        enable() {
                          return
                          TreatmentModel.fromJson(controller.treatment[i])
                              .active = true;
                        }

                        return SizedBox(
                          height: Get.height * 0.2,
                          width: Get.width * 0.8,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        'Name : ${TreatmentModel.fromJson(controller.treatment[i]).name}'),
                                    // if(TreatmentModel.fromJson(controller.treatment[i]).active == true)
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.showNotification(
                                              10,
                                              'you should take your dose of treatment $treatmentName now',
                                              TreatmentModel.fromJson(
                                                      controller.treatment[i])
                                                  .sound,
                                              index);
                                          TreatmentModel.fromJson(
                                                  controller.treatment[i])
                                              .active = false;
                                          if (TreatmentModel.fromJson(
                                                      controller.treatment[i])
                                                  .dose !=
                                              1) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(AuthController.instance
                                                    .auth.currentUser?.uid)
                                                .set({
                                              'treatment': {
                                                TreatmentModel.fromJson(
                                                        controller.treatment[i])
                                                    .name: {'active': false}
                                              }
                                            }, SetOptions(merge: true));
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(AuthController.instance
                                                    .auth.currentUser?.uid)
                                                .set({
                                              'treatment': {
                                                TreatmentModel.fromJson(
                                                        controller.treatment[i])
                                                    .name: {
                                                  'dose':
                                                      FieldValue.increment(-1)
                                                }
                                              }
                                            }, SetOptions(merge: true));

                                            var next = nowDate.add(Duration(
                                                seconds:
                                                    TreatmentModel.fromJson(
                                                            controller
                                                                .treatment[i])
                                                        .duration
                                                        .value));
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(AuthController.instance
                                                    .auth.currentUser?.uid)
                                                .set({
                                              'treatment': {
                                                TreatmentModel.fromJson(
                                                        controller.treatment[i])
                                                    .name: {'nextDose': next}
                                              }
                                            }, SetOptions(merge: true));
                                          } else {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(AuthController.instance
                                                    .auth.currentUser?.uid)
                                                .set({
                                              'history': FieldValue.arrayUnion(
                                                  [controller.treatment[i]])
                                            }, SetOptions(merge: true));
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(AuthController.instance
                                                    .auth.currentUser?.uid)
                                                .set({
                                              'treatment': {
                                                TreatmentModel.fromJson(
                                                        controller.treatment[i])
                                                    .name: FieldValue.delete()
                                              }
                                            }, SetOptions(merge: true));
                                          }
                                        },
                                        child: Text('Take Dose'))
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      child: TreatmentModel.fromJson(
                                              controller.treatment[i])
                                          .image,
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                    ),
                                    Obx(() => Row(
                                      children: [
                                        Text(
                                            '${TreatmentModel.fromJson(controller.treatment[i]).dose}'),
                                        IconButton(onPressed: (){
                                          controller.addDose(TreatmentModel.fromJson(controller.treatment[i]).name);
                                        }, icon: Icon(Icons.edit,color: Colors.blue,)),
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )))
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('${AuthController.instance.user.value?.displayName}'),
              accountEmail:
                  Text('${AuthController.instance.user.value?.email}'),
              currentAccountPicture: Image.asset('assets/images/male.png'),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Get.to(() => UserProfile());
              },
            ),
            ListTile(
              title: Text('Admins'),
              onTap: () {
                Get.to(() => AdminsList());
              },
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                Get.to(() => UserHistory(list: [controller.history],));
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // Get.offAll(()=> LogIn());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.addTreatment();
          },
          label: Row(
            children: [
              Text('New Treatment'),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.add)
            ],
          )),
    );
  }
}
