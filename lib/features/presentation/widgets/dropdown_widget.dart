import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {

  final List<DropdownMenuItem<T>> items;
  final T initialValue;
  final ValueChanged<T?> onChanged;

  const DropdownWidget({
    Key? key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: DropdownButton<T>(
        underline: Container(),
        isExpanded: true,
        items: items,
        onChanged: onChanged,
        value: initialValue,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
