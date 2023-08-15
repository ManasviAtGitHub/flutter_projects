import 'package:flutter/material.dart';
import 'package:voice_assistant/constants/strings.dart';

import '../constants/pallete.dart';
class FeatureBox extends StatelessWidget {
  const FeatureBox({super.key, required this.color, required this.headerText, required this.descriptionText});

  final Color color;
  final String headerText;
  final String descriptionText;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin : const EdgeInsets.symmetric(
        horizontal : 35,
        vertical : 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding : const EdgeInsets.symmetric(vertical: 20).copyWith(
          left : 15,
        ),
        child: Column(
          children: [
            Align(
              alignment : Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  fontFamily: FONT_FAMILY,
                  color : Pallete.blackColor,
                  fontSize : 18,
                  fontWeight : FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height : 3),
            Padding(
              padding : const EdgeInsets.only(right : 15),
              child: Text(
                descriptionText,
                style: TextStyle(
                  fontFamily: FONT_FAMILY,
                  color : Pallete.blackColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
