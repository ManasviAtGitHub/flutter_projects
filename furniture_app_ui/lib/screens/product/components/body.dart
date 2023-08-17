import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app_ui/constants/palette.dart';
import 'package:furniture_app_ui/models/product.dart';
import 'package:furniture_app_ui/screens/details/details_screen.dart';
import 'package:furniture_app_ui/screens/product/components/product_card.dart';

import '../../../components/search_box.dart';
import 'category_list.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SearchBox(
            onChanged: (value) {},
          ),
          CategoryList(),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                ),

                ListView.builder(
                  itemCount: products.length,
                  itemBuilder:
                      (BuildContext context, int index) =>
                      ProductCard(
                        itemIndex: index,
                        product: products[index],
                        press: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DetailsScreen(product: products[index],),
                          ),
                          );
                        },
                      ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}


