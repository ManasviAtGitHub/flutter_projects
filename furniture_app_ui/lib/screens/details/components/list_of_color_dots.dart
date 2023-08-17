import 'package:flutter/material.dart';

import 'color_dots.dart';

class ListOfColorDots extends StatelessWidget {
  const ListOfColorDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColorDot(fillColor: Colors.grey, isSelected: true),
        ColorDot(fillColor: Colors.blue, isSelected: false,),
        ColorDot(fillColor: Colors.red, isSelected: false,),
      ],
    );
  }
}
