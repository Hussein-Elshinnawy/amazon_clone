import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'deal of the day',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Image.network(
          'https://static.vecteezy.com/system/resources/thumbnails/017/054/078/small/headphones-design-3d-rendering-for-product-mockup-free-png.png',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            '\$100',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 15, top: 5, right: 40),
          child: Text(
            'headphone',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://image.similarpng.com/very-thumbnail/2020/04/cosmetic-products-ad-3d-skin-care-brand-cream-lotion-png.png',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://image.similarpng.com/very-thumbnail/2020/04/cosmetic-products-ad-3d-skin-care-brand-cream-lotion-png.png',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://image.similarpng.com/very-thumbnail/2020/04/cosmetic-products-ad-3d-skin-care-brand-cream-lotion-png.png',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://image.similarpng.com/very-thumbnail/2020/04/cosmetic-products-ad-3d-skin-care-brand-cream-lotion-png.png',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            left: 15,
            top: 15,
            bottom: 15,
          ),
          child:  Text('see all deals', style: TextStyle(color: Colors.cyan.shade800),),
        ),
      ],
    );
  }
}
