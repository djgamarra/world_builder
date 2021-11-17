import 'package:flutter/material.dart';
import 'package:world_builder/ui/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color, backgroundColor;
  final Function() onClick;
  final bool solid, fullWidth, disabled;
  final double fontSize, borderWidth;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.color = defaultBorderColor,
    this.backgroundColor = defaultBackgroundColor,
    this.solid = false,
    this.fullWidth = false,
    this.fontSize = 14,
    this.borderWidth = 1,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: solid ? backgroundColor : color,
        backgroundColor: solid ? color : backgroundColor,
        elevation: 0,
        minimumSize: Size(fullWidth ? double.infinity : 30, 30),
        side: BorderSide(
          color: color,
          width: borderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: disabled ? null : onClick,
      child: Text(
        "  $text  ",
        style: primaryFont.copyWith(
          color: solid ? backgroundColor : color,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
