import 'package:flutter/material.dart';

class MenuButtonWidget extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  const MenuButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              icon,
              color: Theme.of(context).accentColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}