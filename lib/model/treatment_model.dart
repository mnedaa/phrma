import 'package:cloud_firestore/cloud_firestore.dart';
import '../constance.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';

// class TreatmentModel {
//   dynamic id,name, sound, active, image;
//   RxInt dose = 0.obs;
//   RxInt duration = 0.obs;
//   Rx<Timestamp> lastDose = Rx<Timestamp>(Timestamp(0,0));
//   Rx<Timestamp> nextDose = Rx<Timestamp>(Timestamp(0,0));
//
//
//   TreatmentModel({
//     this.id,
//     this.name,
//     required this.dose,
//     required this.lastDose,
//     required this.nextDose,
//     required this.duration,
//     this.sound,
//     this.active,
//     this.image,
//   });
//
//   TreatmentModel.fromJson(map) {
//     id = map['id'];
//     name = map['name'];
//     dose = RxInt(map['dose']);
//     lastDose = Rx(map['lastDose']);
//     nextDose = Rx(map['nextDose']);
//     duration = RxInt(map['duration']);
//     sound = map['sound'];
//     active = map['active'];
//     image = map['image'] == '' || map['image'] == null
//         ? Image.asset(pillImage)
//         : Image.file(File(map['image']));
//   }
//
//   toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'dose': dose,
//       'lastDose': lastDose,
//       'duration': duration,
//       'sound': sound,
//       'active': active,
//       'image': image,
//     };
//   }
// }
class TreatmentModel {
  dynamic id,name, sound, active, image, dose, duration, lastDose, nextDose;


  TreatmentModel({
    this.id,
    this.name,
    this.dose,
    this.lastDose,
    this.nextDose,
    this.duration,
    this.sound,
    this.active,
    this.image,
  });

  TreatmentModel.fromJson(map) {
    id = map['id'];
    name = map['name'];
    dose = RxInt(map['dose']);
    lastDose = Rx(map['lastDose']);
    nextDose = Rx(map['nextDose']);
    duration = RxInt(map['duration']);
    sound = map['sound'];
    active = map['active'];
    image = map['image'] == '' || map['image'] == null
        ? Image.asset(pillImage)
        : Image.file(File(map['image']));
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'dose': dose,
      'lastDose': lastDose,
      'duration': duration,
      'sound': sound,
      'active': active,
      'image': image,
    };
  }
}
