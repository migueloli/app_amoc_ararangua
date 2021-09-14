import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  const RectangularButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).accentColor,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 16,),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}