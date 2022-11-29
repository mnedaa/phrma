import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'dart:io';

import 'package:pahrma_gb/view/screens/auth/login.dart';

class UserHomeController extends GetxController {
  RxList history = [].obs;
  RxMap treatment = {}.obs;
  RxMap treatment2 = {}.obs;
  TextEditingController treatmentName = TextEditingController();
  TextEditingController treatmentDose = TextEditingController();
  TextEditingController editDose = TextEditingController();
  TextEditingController treatmentDuration = TextEditingController();

  RxInt d = 0.obs;
  RxString chosenSound = ''.obs;
  RxString chosenImage = ''.obs;
  DateTime now = DateTime.now();

  var player = AudioPlayer();

  pickSound() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      File file = File('${result.files.single.path}');
      chosenSound.value = file.path;
    } else {
      // User canceled the picker
    }
  }

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

  /// Set Notification in Minuets

  showNotification(d, String b, sound, var index) {
    var x = index;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: 'Treatment Reminder',
        body: b,
      ),
      schedule: NotificationInterval(
        interval: d,
        preciseAlarm: true,
      ),
      actionButtons: [
        NotificationActionButton(
            color: Colors.redAccent,
            key: 'cancel',
            label: 'Cancel',
            actionType: ActionType.DismissAction),
        NotificationActionButton(
            key: "snooze", label: "Snooze", color: Colors.red)
      ],
    );
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {
      player.stop();
    }, onNotificationDisplayedMethod:
            (ReceivedNotification receivedNotification) async {
      player.setFilePath(sound);
      player.play();
    }, onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
      player.stop();
      AwesomeNotifications().cancel(receivedAction.id!);
    });
  }

  /// Set Notification Hours

  // showNotification(d, String b, sound, var index) {
  //   var x = index;
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 1,
  //       channelKey: 'basic_channel',
  //       title: 'Treatment Reminder',
  //       body: b,
  //     ),
  //     schedule: NotificationInterval(
  //       interval: d * 60,
  //       preciseAlarm: true,
  //     ),
  //     actionButtons: [
  //       NotificationActionButton(
  //           color: Colors.redAccent,
  //           key: 'cancel',
  //           label: 'Cancel',
  //           actionType: ActionType.DismissAction),
  //       NotificationActionButton(
  //           key: "snooze", label: "Snooze", color: Colors.red)
  //     ],
  //   );
  //   AwesomeNotifications().setListeners(
  //       onActionReceivedMethod: (ReceivedAction receivedAction) async {
  //         player.stop();
  //       },
  //       onNotificationDisplayedMethod:
  //           (ReceivedNotification receivedNotification) async {
  //         player.setFilePath(sound);
  //         player.play();
  //       },
  //       onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
  //         player.stop();
  //         AwesomeNotifications().cancel(receivedAction.id!);
  //       });
  // }

  treatmentListStream() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(AuthController.instance.user.value?.uid)
        .snapshots()
        .listen((event) {
      treatment.value = event['treatment'];
    });
    return treatment.stream;
  }

  streamHistory() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(AuthController.instance.user.value?.uid)
        .snapshots()
        .listen((event) {
      history.value = event['history'];
    });
    return history.stream;
  }

  Rx<DateTime> streamNow = Rx<DateTime>(DateTime.now());
  Rx<DateTime> streamN = Rx<DateTime>(DateTime.now());

  streamDate() {
    streamNow.value = streamN.value;
    return streamNow.stream;
  }

  RxInt dif = 0.obs;

  Stream<int> startTimer(DateTime d1) {
    dif = d1.difference(DateTime.now()).inSeconds.obs;
    var oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (dif.value == 0) {
          timer.cancel();
        } else {
          dif.value--;
        }
      },
    );
    return dif.stream;
  }

  addTreatment() {
    Get.defaultDialog(
        title: 'Add',
        textConfirm: 'Add',
        textCancel: 'Cancel',
        onConfirm: () {
          FirebaseFirestore.instance
              .collection('users')
              .doc(AuthController.instance.user.value?.uid)
              .set({
            'treatment': {
              treatmentName.text.trim(): {
                'name': treatmentName.text.trim(),
                'dose': int.parse(treatmentDose.text.trim()),
                'totalDose': int.parse(treatmentDose.text.trim()),
                'ended': false,
                'image': chosenImage.value,
                'duration': int.parse(treatmentDuration.text.trim()),
                'sound': chosenSound.value,
                'active': true,
                'lastDose': DateTime.now(),
                'nextDose': DateTime.now().add(Duration(
                    seconds: int.parse(treatmentDuration.text.trim()))),
              }
            }
          }, SetOptions(merge: true));
          treatmentName.clear();
          treatmentDuration.clear();
          treatmentDose.clear();
          chosenImage.value = '';
          chosenSound.value = '';
          Get.back();
        },
        onCancel: () {
          treatmentName.clear();
          treatmentDuration.clear();
          treatmentDose.clear();
          chosenImage.value = '';
          chosenSound.value = '';
        },
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Obx(
                    () => chosenImage.value == ''
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/pill.jpeg'),
                          )
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(File(chosenImage.value)),
                          ),
                  )),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: treatmentName,
                decoration: InputDecoration(
                  hintText: 'Treatment Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: treatmentDose,
                decoration: InputDecoration(
                  hintText: 'Treatment dose',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: treatmentDuration,
                decoration: InputDecoration(
                  hintText: 'Time between every dose in (Minutes)',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => chosenSound.value == ''
                    ? TextButton(
                        onPressed: () {
                          pickSound();
                        },
                        child: Text('Select Sound'))
                    : TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            hintText: '${chosenSound.value}'.split('/').last,
                            hintStyle: TextStyle(color: Colors.black),
                            enabled: false),
                      ),
              )
            ],
          ),
        ));
  }

  addDose(String name) {
    Get.defaultDialog(
        title: 'Add',
        textConfirm: 'Add',
        textCancel: 'Cancel',
        onConfirm: () {
          FirebaseFirestore.instance
              .collection('users')
              .doc(AuthController.instance.user.value?.uid)
              .set({
            'treatment': {
              name: {
                'dose': FieldValue.increment(int.parse(editDose.text.trim())),
              }
            }
          }, SetOptions(merge: true));
          Get.back();
        },
        onCancel: () {
          editDose.clear();
        },
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: editDose,
                decoration: InputDecoration(
                  hintText: 'Treatment dose',
                ),
              ),
            ],
          ),
        ));
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    return LogIn();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    treatment.bindStream(treatmentListStream());
    streamNow.bindStream(streamDate());
    history.bindStream(streamHistory());
  }
}
