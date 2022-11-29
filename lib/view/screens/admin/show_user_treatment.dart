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
        title: Text('Current Treatment'),
        centerTitle: true,
        actions: [IconButton(onPressed: (){
          Get.to(()=> ShowTreatmentHistory(user: user,));
        }, icon: Icon(Icons.history))],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            (user!['treatment'] as Map).keys.toList().length > 0 ?
            Expanded(
                child: ListView.separated(
                  itemCount: (user!['treatment'] as Map).keys.toList().length,
                  itemBuilder: (context, ind) {
                    var i = (user!['treatment'] as Map).keys.toList()[ind];
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
                )) :
            Text(
              'There is no data',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.amber),
            )
          ],
        ),
      ),
    );
  }
}


class ShowTreatmentHistory extends StatelessWidget {
  ShowTreatmentHistory({Key? key, this.user}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>>? user;
  RxString selected = 'current'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment History'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            user!['history'].isNotEmpty ?
            Expanded(
                child: ListView.builder(
                    itemCount: user!['history'].length,
                    itemBuilder: (context, index) {
                      return TreatmentCard2(
                        treatment: user!['history'][index],
                        userId: UserModel.fromJson(user!).userId,
                      );
                    })) :
            Text(
                    'There is no data',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.amber),
                  )
          ],
        ),
      ),
    );
  }
}
