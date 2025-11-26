import 'package:flutter/material.dart';
import 'package:ocassio_app/features/login/presentation/views/log_in_view.dart';
import 'package:ocassio_app/features/sign_up/presentation/views/sign_up_view.dart';

class splashViewBody extends StatefulWidget {
  const splashViewBody({super.key});

  @override
  State<splashViewBody> createState() => _splashViewBodyState();
}

class _splashViewBodyState extends State<splashViewBody> {
  void initState(){
    super.initState();
    goToNextView();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xffdeb3ad),
child: Column(
  children: [
    SizedBox(
      height: 200,
    ),
  Image.asset('assets/images/cake.png',),


  ],
),
    );
  }
  void goToNextView() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginView()),
      );
    });
  }
}
