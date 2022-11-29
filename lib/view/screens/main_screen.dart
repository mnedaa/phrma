import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/control_view.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';


class MainScreen extends GetWidget<AuthController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Admins Will Approve Your Request Soon',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ElevatedButton(onPressed: (){
              controller.auth.signOut();
            }, child: Text('Log Out'))
          ],
        ),
      ),
    );
  }
}



// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column,
//     );
//   }
// }
