import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constance.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.textColor = Colors.black,
      this.btnColor = secondColor,
      this.fontSize = 16,
      this.btnWidth = 200})
      : super(key: key);

  final String text;
  final Color textColor;
  final Color btnColor ;
  final double fontSize;
  final double btnWidth;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: GoogleFonts.lateef(color: textColor, fontSize: fontSize),
          )),
    );
  }
}
