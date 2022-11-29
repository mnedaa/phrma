import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pahrma_gb/model/user_model.dart';
import 'package:pahrma_gb/view/widgets/treatment_card.dart';


class ShowTreatment extends StatelessWidget {
  ShowTreatment({Key? key, this.user}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>>? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User History'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text('Current Treatment'),
          Expanded(child: ListView.separated(
            itemCount: UserModel.fromJson(user!).treatment.length,
            itemBuilder: (context, index){
              var i = (user!['treatment'] as Map).keys.toList()[index];
              return TreatmentCard2(treatment: user!['treatment'][i],userId:UserModel.fromJson(user!).userId,);
            }, separatorBuilder: (BuildContext context, int index) {
            return
              SizedBox(height: 10,);
          },
          )),
          Text('Finished Treatment'),
          Expanded(child: ListView.builder(
              itemCount: user!['history'].length,
              itemBuilder: (context, index){
                return TreatmentCard2(treatment: user!['history'][index],userId:UserModel.fromJson(user!).userId,);
              })),
        ],
      ),
    );
  }
}
