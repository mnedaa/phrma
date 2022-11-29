import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomMessage extends StatelessWidget {
  const CustomMessage({Key? key, required this.body, required this.sender, required this.receiver, required this.time}) : super(key: key);

  final String body, sender, receiver, time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sender,style: TextStyle(fontSize: 10),),
            ],
          ),
          SizedBox(
            width: Get.width,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 3,
              color: Colors.amber[200],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(body),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
