import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar ({super.key});

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      color:Color(0xfffeebd6) ,
      height: 60,
      child: Row(
        children: [Expanded(child: Image.asset('assets/images/img_4.png',)),
          Expanded(child: Image.asset('assets/images/img_5.png')),
          Expanded(child: Image.asset('assets/images/img_6.png'))
        ],
      ),
    );
  }
}
