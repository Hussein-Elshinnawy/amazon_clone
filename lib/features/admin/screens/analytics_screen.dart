import 'package:amazon_clone/common/widget/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../models/sales.dart';
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices= AdminServices();
  int? totalSales;
  List<Sales>? earings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }
  void getEarnings() async{
    var earningData= await adminServices.getEarnings(context);
    totalSales=earningData['totalEarnings'];
    earings= earningData['sales'];
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return earings==null|| totalSales==null? const Loader(): Column(
      children: [
        Text(
          '\$$totalSales',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(
        //   height: 250,
        //   child: CategoryProductsChart(seriesList: [
        //     charts.Series(
        //       id: 'Sales',
        //       data: earnings!,
        //       domainFn: (Sales sales, _) => sales.label,
        //       measureFn: (Sales sales, _) => sales.earning,
        //     ),
        //   ]),
        // )
      ],

    );
  }
}
