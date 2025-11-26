import 'package:flutter/material.dart';

class customGeneralButton extends StatelessWidget {
  const customGeneralButton({super.key,this.text, this.onTap});
  final String? text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.brown, // لون البوردر
            width: 2, // سمك البوردر (اختياري)
          ),
          borderRadius: BorderRadius.circular(8),
          color: Color(0xfffeebd6),
        ),
        child:  Center(
          child: Text(
            text ?? '', // عرض نص فارغ إذا كانت القيمة null
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.brown
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }}