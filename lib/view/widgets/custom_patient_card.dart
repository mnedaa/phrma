import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/model/user_model.dart';
import 'package:pahrma_gb/view/screens/patient-details.dart';

import '../../constance.dart';

class CustomPatientCard extends StatelessWidget {
  const CustomPatientCard({Key? key, required this.user}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>>? user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.15,
      child: InkWell(
        onTap: () {
          Get.to(() => PatientDetails(
                userData: user,
              ));
        },
        child: Card(
          color: Colors.blueAccent[800],
          shape: UserModel.fromJson(user!).ban == true
              ? RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(15))
              : UserModel.fromJson(user!).approved == false ? RoundedRectangleBorder(
                  side: BorderSide(color: Colors.amber),
                  borderRadius: BorderRadius.circular(15)) : RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(UserModel.fromJson(user!).name),
                      Text(UserModel.fromJson(user!).phone),
                      Text(UserModel.fromJson(user!).age),
                      if (UserModel.fromJson(user!).ban == true)
                        Icon(
                          Icons.block,
                          color: Colors.red,
                        )
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 40,
                  child: UserModel.fromJson(user!).image,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
