import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {

  final String label;
  final IconData icon;
  final TextInputType inputType;
  final int minLines;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextCapitalization capitalization;
  final TextInputAction textInputAction;
  final String value;

  const TextFieldWidget({
    Key? key,
    this.label = "",
    required this.icon,
    this.inputType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputFormatters,
    required this.onSaved,
    this.validator,
    this.obscureText = false,
    this.capitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.value = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          border: const OutlineInputBorder(),
        ),
        textCapitalization: capitalization,
        onSaved: onSaved,
        validator: validator,
        maxLines: maxLines,
        minLines: minLines,
        textInputAction: textInputAction,
        initialValue: value,
      ),
    );
  }

}