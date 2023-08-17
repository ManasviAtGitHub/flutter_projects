import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/palette.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, this.onChanged});

  final ValueChanged? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin : EdgeInsets.all(kDefaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration:BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child : TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
            icon : SvgPicture.asset("assets/icons/search.svg"),
          ),
        )

    );
  }
}
