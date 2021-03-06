import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  static const double focusedWidth = 2,
      unfocusedWidth = 1,
      defaultRadius = 10,
      defaultLabelGap = 4;
  final Color borderColor, borderErrorColor, backgroundColor;
  final String initialValue, field;
  final String? label;
  final TextInputType type;
  final Function(String field, String value) onChanged;
  final String? Function(String? value)? validator;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.onChanged,
    this.label,
    this.field = '',
    this.borderColor = defaultBorderColor,
    this.borderErrorColor = defaultBorderErrorColor,
    this.backgroundColor = defaultBackgroundColor,
    this.initialValue = '',
    this.type = TextInputType.name,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  void _onTextChanged(text) => onChanged(field, text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(
                  defaultLabelGap,
                  0,
                  defaultLabelGap,
                  defaultLabelGap,
                ),
                child: Text(
                  label!,
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    color: borderColor,
                  ),
                ),
              ),
        TextFormField(
          maxLines: type == TextInputType.multiline ? null : 1,
          initialValue: initialValue,
          validator: validator,
          keyboardType: type,
          onChanged: _onTextChanged,
          obscureText: obscureText,
          style: primaryFont.copyWith(
            color: borderColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            fillColor: backgroundColor,
            isDense: true,
            filled: true,
            errorStyle: primaryFont.copyWith(
              color: borderErrorColor,
              fontSize: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: borderColor,
                width: unfocusedWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: borderErrorColor,
                width: unfocusedWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: borderColor,
                width: focusedWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: borderErrorColor,
                width: focusedWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: borderColor,
                width: unfocusedWidth,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: unfocusedWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
