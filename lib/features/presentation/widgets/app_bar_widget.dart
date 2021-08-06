import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({required String title}): super(
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      )
    ),
    elevation: 0,
    centerTitle: true,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40),
      ),
    ),
  );
}