import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app_ui/constants/palette.dart';
import 'package:furniture_app_ui/models/product.dart';
import 'package:furniture_app_ui/screens/details/components/list_of_color_dots.dart';
import 'package:furniture_app_ui/screens/details/components/product_poster.dart';
class Body extends StatelessWidget {
  const Body({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:
                  Hero(
                    tag: "${product.id}",
                    child: ProductPoster(
                      size: size,
                      image: product.image,
                    ),
                  ),
                ),

                ListOfColorDots(),
                SizedBox(height: 20,),

                Text(
                  product.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "\$ ${product.price}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: kTextColor,
                  ),
                ),


              ],
            ),
          ),
          
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius:BorderRadius.circular(30)
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/chat.svg",
                  height: 18,
                ),
                SizedBox(width: kDefaultPadding / 2,),

                Text(
                  "Chat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Spacer(),

                TextButton.icon(
                    onPressed: (){},
                    icon: SvgPicture.asset("assets/icons/shopping-bag.svg"),
                    label: Text("Add to Cart", style: TextStyle(color: Colors.white),),
                )


              ],
            ),
          )
          
        ],
      ),
    );
  }
}
