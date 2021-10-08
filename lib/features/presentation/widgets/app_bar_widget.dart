import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({required String title}): super(
    title: Text(title),
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40),
      ),
    ),
  );
}
