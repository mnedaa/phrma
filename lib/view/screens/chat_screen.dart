import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pahrma_gb/controller/auth_controller.dart';
import 'package:pahrma_gb/view/widgets/custom_text_form_field.dart';
import '../../controller/chat_controller.dart';
import '../../view/widgets/custom_message.dart';

// class Chat extends GetWidget<ChatController> {
//   const Chat(this.sender, this.receiver, {Key? key}) : super(key: key);
//
//   final String sender;
//   final String receiver;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 30,),
//           Expanded(
//               child: Obx(() => ListView.separated(
//                     itemCount: controller.chat.length,
//                     itemBuilder: (context, index) {
//                       return Text('${controller.chat}');
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return SizedBox(
//                         height: 20,
//                       );
//                     },
//                   ))),
//           SizedBox(
//             height: Get.height * 0.1,
//             child: Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//               elevation: 5,
//               child: Row(
//                 children: [
//                   SizedBox(width: 10,),
//                   Expanded(
//                     child: Obx(() => TextFormField(
//                       controller: controller.messageController.value,
//                       onFieldSubmitted: (val){
//                         controller.messageController.value.text = val;
//                         // controller.sentMessage(val);
//                         controller.messageController.value.clear();
//                       },
//                       validator: (String? val) => null,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.white),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           filled: true,
//                           suffixIcon: Icon(Icons.message,color: Colors.blue,),
//                           labelText: 'Your Message',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           fillColor: Colors.white
//                       ),
//                     )),),
//                   IconButton(onPressed: () {
//                     // controller.sentMessage(controller.messageController.value.text.trim());
//                     controller.messageController.value.clear();
//                   }, icon: Icon(Icons.arrow_forward,))
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
