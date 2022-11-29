import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xff01647f);
const secondColor = Color(0xff4caf50);
Color e = Colors.green;

String? userUid = FirebaseAuth.instance.currentUser?.uid;

const staticUserImage = 'https://firebasestorage.googleapis.com/v0/b/poultrybeef.appspot.com/o/staticUserPhoto.png?alt=media&token=f156e4ff-6a7f-4453-8142-58a06aa6cf72';
const maleImage = 'https://firebasestorage.googleapis.com/v0/b/pharma-a7659.appspot.com/o/profile%2Fmale.png?alt=media&token=69699138-968f-4d3c-86cb-0a677d71b0fb';
const femaleImage = 'https://firebasestorage.googleapis.com/v0/b/pharma-a7659.appspot.com/o/profile%2Ffemale.png?alt=media&token=f862a68c-78ba-4f1a-8c44-61b223537943';
const pillImage = 'assets/images/pillLogo.png';

