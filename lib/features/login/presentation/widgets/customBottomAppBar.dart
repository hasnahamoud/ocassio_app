import 'package:flutter/material.dart';
import 'package:ocassio_app/features/profile/presentation/views/profile_view.dart';

class Custombottomappbar extends StatelessWidget {
  const Custombottomappbar ({super.key});

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
    color:Color(0xfffeebd6) ,
height: 60,
child: Row(
children: [Expanded(child: GestureDetector(
    onTap: (){
      Navigator.pushNamed(context,'CategoriesView');
    },
    child: Image.asset('assets/images/img_4.png',))),
Expanded(child: GestureDetector(
    onTap: (){Navigator.pushNamed(context,'CartView');},
    child: Image.asset('assets/images/img_5.png'))),
Expanded(child: GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, 'CheckoutView');
    },
    child: Image.asset('assets/images/img_6.png'))),
  Expanded(child: GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,'ProfileView');

      },
      child: Icon(Icons.person,color: Colors.brown,)))
  
],
),
);
  }
}
