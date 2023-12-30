import 'package:amazon_clone/features/home/screens/catagory_deals_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/variables.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void navigateToCategoryPage(BuildContext context, String category){
    Navigator.pushNamed(context, CategoryDealsScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: Variables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75, // something like spacing between
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: ()=> navigateToCategoryPage(context, Variables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      Variables.categoryImages[index]['image']!,
                      fit: BoxFit.cover, //what is that
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  Variables.categoryImages[index]['title']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
