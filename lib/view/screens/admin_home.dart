import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/model/user_model.dart';

import '../../constance.dart';
import '../../controller/admin_home_controller.dart';
import '../../controller/auth_controller.dart';
import '../widgets/custom_patient_card.dart';


class AdminHome extends GetWidget<AdminHomeController> {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height *0.09,
        actions: [

        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            children: [
              // CustomPatientCard(user: UserModel(name: 'Ahmed',age: '22',role: 'admin',userId: 22,email: 'asd',phone: '123'))
            ],
          ))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1,),
            Center(child: CircleAvatar(child: Image.asset('assets/images/pharmaLogo.png',fit: BoxFit.contain,),radius: 70,)),
            SizedBox(height: 20,),
            Divider(),
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('المستخدمين',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                trailing: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('الاعدادات',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: (){
                  Get.defaultDialog(
                      title: 'Wait a second',
                      content: const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )));
                  AuthController.instance.auth.signOut();
                  Get.back();
                },
                title: Text('تسجيل الخروج',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
