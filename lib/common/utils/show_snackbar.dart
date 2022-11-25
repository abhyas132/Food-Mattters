import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foods_matters/common/global_constant.dart';

void ShowSnakBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: GlobalVariables.selectedNavBarColor,
      behavior: SnackBarBehavior.floating,
      content: Text(content),
    ),
  );
}
