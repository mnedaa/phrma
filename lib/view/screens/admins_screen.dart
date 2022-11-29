import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/admins_controller.dart';
import 'package:pahrma_gb/controller/home_controller.dart';
import 'package:pahrma_gb/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';


class AdminsList extends GetWidget<AdminsController> {
  const AdminsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admins'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.admins.length,
                itemBuilder: (context, index){
                  var phoneNum = '+05${UserModel.fromJson(controller.admins[index]).phone}';
                  return SizedBox(
                    height: Get.height * 0.2,
                    width: Get.width,
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: (){}, child: Icon(Icons.message)),
                                ElevatedButton(onPressed: (){
                                  Future<void> _launchUrl() async {
                                    if (!await launchUrl(Uri.parse("whatsapp://send?phone=$phoneNum/?text=hi"))) {
                                      throw 'Could not launch';
                                    }
                                  }
                                  _launchUrl();
                                }, child: Icon(Icons.whatsapp)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 40,
                                  child: UserModel.fromJson(controller.admins[index]).image,
                                ),
                                SizedBox(height: 10,),
                                Text(UserModel.fromJson(controller.admins[index]).name),
                                SizedBox(height: 10,),
                                Text('+05${UserModel.fromJson(controller.admins[index]).phone}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
