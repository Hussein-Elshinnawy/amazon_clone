import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/common/widget/bottom_bar.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/constants/variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
   
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(Uri.parse('$url/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type':
                'application/json; charset=UTF-8', // i don't know but its used when using express.json()
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, "Account created! login with same credentials ");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false)
              .setUser(res.body); // to save the data
          pref.setString('x-auth-token',
              jsonDecode(res.body)['token']); // x-auth-token = res.body's token
          Navigator.pushNamedAndRemoveUntil(
            //after naviagting it removes the previous route paths
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    BuildContext? context,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('x-auth-token');
      if (token == null) {
        sharedPreferences.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$url/tokenIsValid'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // i don't know but its used when using express.json()
          'x-auth-token': token! //we send the token in the headers
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userResponse = await http.get(
          Uri.parse('$url/'),
          headers: <String, String>{
            'Content-Type':
                'application/json; charset=UTF-8', // i don't know but its used when using express.json()
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context!, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context!, e.toString());
    }
  }
}
