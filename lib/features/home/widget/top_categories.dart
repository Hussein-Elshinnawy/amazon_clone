import 'package:flutter/material.dart';

import '../../../constants/variables.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: Variables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75, // what is that
        itemBuilder: (context, index) {
          return Column(
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
          );
        },
      ),
    );
  }
}
