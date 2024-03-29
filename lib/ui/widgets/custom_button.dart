import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomButton extends StatelessWidget {
  final String hintText;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final double height;
  final Color color;

  CustomButton({
    Key? key,
    required this.hintText,
    required this.onPressed,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.height = 55,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          hintText,
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
    );
  }
}
