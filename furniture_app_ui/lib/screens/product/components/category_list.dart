import 'package:flutter/material.dart';

import '../../../constants/palette.dart';
class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;
  List categories = ["All", "Sofa", "Park bench", "Armchair"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index)=>
            GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: index == categories.length - 1 ? kDefaultPadding : 0
                ),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color : index==selectedIndex? Colors.white.withOpacity(0.4) : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(categories[index], style: TextStyle(color: Colors.white),),
              ),
            ),
      ),
    );
  }
}

