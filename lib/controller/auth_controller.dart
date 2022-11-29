import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pahrma_gb/control_view.dart';

import '../constance.dart';
import '../model/user_model.dart';
import '../service/firestore_user.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;

  GlobalKey<FormState> logInForm = GlobalKey<FormState>();
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  GlobalKey<FormState> profileKey = GlobalKey<FormState>();
  RxBool enable = false.obs;
  RxBool obscureText = true.obs;
  RxString genderSelected = 'male'.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString image = ''.obs;
  RxString phone = ''.obs;
  RxString age = ''.obs;
  RxString role = ''.obs;
  RxBool isApproved = false.obs;
  RxString UserName = ''.obs;
  final box = GetStorage();

  emailPasswordSignInMethod() async {
    Get.defaultDialog(
        title: 'Wait a second',
        content: Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        )));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.value, password: password.value)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(value.user!.uid)
            .get()
            .then((value)
        {

        });
        print(UserName.value);
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar(e.code, e.code, snackPosition: SnackPosition.BOTTOM);
      Get.snackbar(e.code, e.code, snackPosition: SnackPosition.BOTTOM);
    }
    Get.back();
  }

  emailPasswordSignUPMethod() async {
    Get.defaultDialog(
        title: 'Wait a second',
        content: Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        )));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.value, password: password.value)
          .then((val) {
        val.user?.updateDisplayName(name.value);
        addUser();
        Get.offAll(() => ControlView());
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar(e.code, e.code, snackPosition: SnackPosition.BOTTOM);
    }
  }

  saveUser(UserCredential user) async {
    await FireStoreUser().addUser(UserModel(
      userId: user.user?.uid,
      name: user.user?.displayName,
      email: user.user?.email,
      image: user.user?.photoURL,
      phone: user.user?.phoneNumber,
    ));
  }

  addUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .set({
      'userId': auth.currentUser?.uid,
      'name': name.value,
      'email': email.value,
      'gender': genderSelected.value,
      'age': age.value,
      'image': image.value,
      'phone': phone.value,
      'role': 'user',
      'treatment': [],
      'history': [],
      'ban': false,
      'approved': false,
    }, SetOptions(merge: true));
  }

  streamRole() {
    if (user.value?.uid != null)
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.value?.uid)
          .get()
          .then((val) {
        role.value = val['role'];
      });
    return role.stream;
  }

  streamApproved() {
    if (user.value?.uid != null)
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.value?.uid)
          .snapshots()
          .listen((event) {
        isApproved.value = event['approved'];
      });
    return isApproved.stream;
  }

  initialScreen(User? user) {
    if (user != null) {
      streamRole();
      streamApproved();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    user.bindStream(auth.userChanges());
    ever(user, (callback) => initialScreen(user.value));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = Rx<User?>(auth.currentUser);
    isApproved.bindStream(streamApproved());
  }
}
