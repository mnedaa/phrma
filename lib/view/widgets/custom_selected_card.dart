import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomSelectedCard extends StatelessWidget {
   CustomSelectedCard({Key? key, required this.gender,}) : super(key: key);

  final RxString gender;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          child: SizedBox(
            height: 80,
            width: 100,
            child: Card(
              elevation: 5,
              color: gender.value == 'male' ? Colors.blue : Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/male.png'),
              )),
            ),
          ),
          onTap: (){
            gender.value = 'male';
          },
        ),
        InkWell(
          child: SizedBox(
            height: 80,
            width: 100,
            child: Card(
              elevation: 5,
              color: gender.value == 'female' ? Colors.blue : Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/female.png'),
              )),
            ),
          ),
          onTap: (){
            gender.value = 'female';
          },
        )
      ],
    ));
  }
}
