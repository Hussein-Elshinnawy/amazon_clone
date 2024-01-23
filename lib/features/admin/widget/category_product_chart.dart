import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'as charts;
import '../models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final Map<Sales, String> seriesList;
  const CategoryProductsChart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}