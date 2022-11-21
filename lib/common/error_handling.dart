import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foods_matters/common/utils/show_snackbar.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      ShowSnakBar(
          context: context, content: jsonDecode(response.body)['message']);
      onSuccess();
      break;
    case 401:
      ShowSnakBar(
          context: context, content: jsonDecode(response.body)['message']);
      break;
    case 500:
      ShowSnakBar(
          context: context, content: jsonDecode(response.body)['error']);
      break;
    default:
      ShowSnakBar(context: context, content: response.body);
  }
}
