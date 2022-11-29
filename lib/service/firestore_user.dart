import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class FireStoreUser{
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel userModel) async{
    return await users.doc(userModel.userId).set(userModel.toJson(),SetOptions(merge: true));
  }
}