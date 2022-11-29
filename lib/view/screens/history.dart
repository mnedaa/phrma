import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/controller/history_controller.dart';
import 'package:pahrma_gb/controller/home_controller.dart';
import 'package:pahrma_gb/model/treatment_model.dart';
import 'package:pahrma_gb/view/widgets/treatment_card.dart';

class UserHistory extends GetWidget<HistoryController> {
  const UserHistory({Key? key, required this.list}) : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
      ),
      body: Obx(() => controller.historyList.isNotEmpty
          ? ListView.builder(
              itemCount: controller.historyList.length,
              itemBuilder: (context, index) {
                var i = TreatmentModel.fromJson(controller.historyList[index]);
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Name : ${i.name}'),
                            Text('Dose : ${i.dose}'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: i.image,
                              backgroundColor: Colors.transparent,
                              radius: 40,
                            ),
                            Text('${i.dose}')
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Text(
              'There is No Data !',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            )),
    );
  }
}

// reatmentCard(treatment: list[index], dosee: TreatmentModel.fromJson(list[index]).dose)
