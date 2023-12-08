
import 'package:amazon_clone/features/account/widgets/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/variables.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  List<String> list=[

      'https://strawberryplants.org/wp-content/uploads/site-icon-1.png',
      'https://strawberryplants.org/wp-content/uploads/site-icon-1.png',
      'https://strawberryplants.org/wp-content/uploads/site-icon-1.png',
      'https://strawberryplants.org/wp-content/uploads/site-icon-1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'your orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: const Text(
                'see all',
                style: TextStyle(
                  color: Variables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Product(image: list[index]);
            },
          ),
        ),
      ],
    );
  }
}
