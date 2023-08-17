import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app_ui/constants/palette.dart';
import 'package:furniture_app_ui/screens/product/components/body.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      backgroundColor: kPrimaryColor,

      title: Text('Dashboard',style: TextStyle(color: Colors.white),),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}


