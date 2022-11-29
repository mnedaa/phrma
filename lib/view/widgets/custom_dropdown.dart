import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({Key? key, required this.list, required this.drop, required this.outPut, required this.onChange}) : super(key: key);

  final RxString drop ;
  final RxString outPut ;
  final List<String> list;
  final Function(String?) onChange;


  @override
  Widget build(BuildContext context) {
    List<String> newList = list;
    return Obx(() => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: drop.value,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),
          onChanged: onChange,
          alignment: Alignment.center,
          items: newList.map<DropdownMenuItem<String>>(
                  (dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ) // your Dropdown Widget here
    ));
  }
}
