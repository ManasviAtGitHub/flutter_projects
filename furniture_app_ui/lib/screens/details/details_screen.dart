import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app_ui/constants/palette.dart';
import 'package:furniture_app_ui/screens/details/components/body.dart';

import '../../models/product.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body : Body(product: product,),
    );

  }
  AppBar buildAppBar(BuildContext context){
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('Back',style: Theme.of(context).textTheme.bodyMedium,),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart_with_item.svg"),
          onPressed: () {},
        ),
      ],
    );
  }


}

