import 'package:amazon_clone/common/widget/loader.dart';
import 'package:flutter/material.dart';

import '../../../constants/variables.dart';
import '../../../models/product.dart';
import '../services/home_services.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/category-deals';
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProducts();
  }

  Future<void> fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Variables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: TextStyle(color: Colors.black),
          ),
        ),
        preferredSize: const Size.fromHeight(50),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category} ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  // we user GridView Builder because we don't know the number of items and it will build on demand
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length ,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final product= productList![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(product.images[0]),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 0, top: 5, right: 15),
                            child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      );
                    },
                  ),
                ),

              ],
            ),
    );
  }
}
