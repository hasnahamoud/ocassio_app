import 'package:flutter/material.dart';
import 'package:ocassio_app/features/splash/presentation/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const String id = 'SplashView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splashViewBody(


      ),

    );
  }
}
