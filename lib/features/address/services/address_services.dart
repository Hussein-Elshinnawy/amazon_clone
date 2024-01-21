import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:http/http.dart ' as http;
import 'package:amazon_clone/constants/variables.dart';
import 'package:provider/provider.dart';
import 'package:amazon_clone/models/product.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$url/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user=userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({required BuildContext context, required String address, required double totalSum,}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
      await http.post(Uri.parse('$url/api/order'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },body: jsonEncode({'cart':userProvider.user.cart, 'address':address, 'totalPrice':totalSum}));
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'your order has been placed');
            User user= userProvider.user.copyWith(cart: [],);
            userProvider.setUserFromModel(user);
            },
          );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct(
      {required BuildContext context,
        required Product product,
        required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$url/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id':product.id}),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
//////////////////////////
