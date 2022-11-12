import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void ShowSnakBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
