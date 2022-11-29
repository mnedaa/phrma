import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pahrma_gb/constance.dart';
import 'package:flutter/material.dart';


class UserModel {
  dynamic userId, name, email, age, gender, image, phone, role, history, treatment, ban, approved;

  UserModel({this.userId, this.name, this.email, this.image, this.phone, this.role, this.age, this.gender, this.history, this.treatment, this.ban, this.approved});

  UserModel.fromJson(map){
    userId = map['userId'];
    name = map['name'];
    email = map['email'];
    age = map['age'];
    gender = map['gender'];
    image = map['image'] == '' || map['image'] == null ? map['gender'] == 'male' ? Image.network(maleImage) : Image.network(femaleImage) : Image.file(File(map['image']));
    phone = map['phone'];
    role = map['role'];
    history = map['history'];
    treatment = map['treatment'];
    ban = map['ban'];
    approved = map['approved'];
  }

  toJson(){
    return{
      'userId': userId,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'image': image,
      'phone': phone,
      'role': role,
      'history': history,
      'treatment': treatment,
      'ban': ban,
      'approved': approved,
    };
  }
}