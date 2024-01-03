import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context, // to display the snack bar??????
  required VoidCallback onSuccess, // function()? i think it's just define empty function
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      //we need to first decode the json to use
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
