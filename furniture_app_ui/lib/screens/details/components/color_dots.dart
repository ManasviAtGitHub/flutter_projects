import 'package:flutter/material.dart';

import '../../../constants/palette.dart';
class ColorDot extends StatelessWidget {
  const ColorDot({super.key, required this.fillColor, required this.isSelected});

  final Color fillColor;
  final bool isSelected;


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
        padding: EdgeInsets.all(3),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fillColor,
          ),
        )

    );
  }
}

