import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pahrma_gb/model/user_model.dart';
import 'package:pahrma_gb/view/widgets/treatment_card.dart';
import 'package:get/get.dart';

class ShowTreatment extends StatelessWidget {
  ShowTreatment({Key? key, this.user}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>>? user;
  RxString selected = 'current'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User History'),
        centerTitle: true,
      ),
      body: Obx(() => Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      selected.value = 'current';
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Current Treatment',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: selected.value == 'current'
                          ? Colors.blue
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15)),
                    )),
                InkWell(
                    onTap: () {
                      selected.value = 'finished';
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Finished Treatment',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: selected.value == 'finished'
                          ? Colors.blue
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15)),
                    )),
              ],
            ),
            selected.value == 'current' ?
            (UserModel.fromJson(user!).treatment as Map).keys.toList().isNotEmpty
                ? Expanded(
                child: ListView.separated(
                  itemCount: UserModel.fromJson(user!).treatment.length,
                  itemBuilder: (context, index) {
                    var i = (user!['treatment'] as Map).keys.toList()[index];
                    return TreatmentCard2(
                      treatment: user!['treatment'][i],
                      userId: UserModel.fromJson(user!).userId,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ))
                : Center(
              child: Text('There is No Data',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
            ) :
            (user!['history'] as List).isNotEmpty
                ? Expanded(
                child: ListView.builder(
                    itemCount: user!['history'].length,
                    itemBuilder: (context, index) {
                      return TreatmentCard2(
                        treatment: user!['history'][index],
                        userId: UserModel.fromJson(user!).userId,
                      );
                    }))
                : Text(
              'There is No Data',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
          ],
        ),
      )),
    );
  }
}
