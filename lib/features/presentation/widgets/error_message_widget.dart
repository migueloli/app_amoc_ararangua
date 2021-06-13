import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {

  final String errorMessage;

  const ErrorMessageWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
      ),
    );
  }
}