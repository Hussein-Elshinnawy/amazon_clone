import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart ' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../constants/variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class HomeServices{
  Future<List<Product>> fetchCategoryProducts({required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$url/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}