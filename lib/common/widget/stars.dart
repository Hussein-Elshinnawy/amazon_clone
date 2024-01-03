import 'package:amazon_clone/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(itemBuilder:(context, _) => const Icon(Icons.star, color: Variables.secondaryColor,), direction: Axis.horizontal, itemCount: 5, rating: rating, itemSize: 15,);
  }
}
