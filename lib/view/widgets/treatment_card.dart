import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/controller/treatment_card_controller.dart';
import 'package:pahrma_gb/model/treatment_model.dart';


class TreatmentCard extends GetWidget<TreatmentCardController> {
  const TreatmentCard({Key? key, required this.treatment, required this.dosee}) : super(key: key);

  final treatment;
  final RxInt dosee;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: SizedBox(
        height: Get.height * 0.2,
        width: Get.width * 0.8,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Name : ${treatment.name}'),
                  ElevatedButton(onPressed: (){
                    TreatmentCardController().update();
                    FirebaseFirestore.instance.collection('users').doc(AuthController.instance.auth.currentUser?.uid).set({
                      'treatment':{treatment.name:{'dose': FieldValue.increment(1)}}
                    },SetOptions(merge: true));

                  }, child: Text('Take Dose'))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(child: treatment.image,backgroundColor: Colors.transparent,radius: 40,),
                  Obx(() => Text('${dosee.value}'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TreatmentCard2 extends GetWidget<TreatmentCardController> {
   TreatmentCard2({Key? key, required this.treatment, this.userId}) : super(key: key);

  final treatment;
  final userId;
  RxString text = 'Delete'.obs;

  @override
  Widget build(BuildContext context) {
    var date = TreatmentModel.fromJson(treatment).lastDose.value.toDate();
    return Visibility(
      child: SizedBox(
        height: Get.height * 0.2,
        width: Get.width * 0.8,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Name : ${TreatmentModel.fromJson(treatment).name}'),
                  Text('Total Dose : ${TreatmentModel.fromJson(treatment).dose.value}'),
                  Text('Last Dose : ${date.toString().substring(0, 16)}'),
                  ElevatedButton(onPressed: (){
                    FirebaseFirestore.instance.collection('users').doc(userId).set({
                      'treatment': {TreatmentModel.fromJson(treatment).name : FieldValue.delete()}
                        },SetOptions(merge: true));
                  }, child: Text(text.value))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(child: TreatmentModel.fromJson(treatment).image,backgroundColor: Colors.transparent,radius: 40,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}