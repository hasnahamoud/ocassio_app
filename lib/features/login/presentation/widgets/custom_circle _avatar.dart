import 'package:flutter/material.dart';

import '../../../../core/utils/constsnts.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundColor: kkkColor,
      backgroundImage: AssetImage(klogo),
      radius: 130,
    );
  }
}
