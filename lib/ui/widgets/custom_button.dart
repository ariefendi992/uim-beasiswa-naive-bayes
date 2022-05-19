import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomButton extends StatelessWidget {
  final String hintText;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;

  const CustomButton({
    Key? key,
    required this.hintText,
    required this.onPressed,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: 55,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          hintText,
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        style: TextButton.styleFrom(
          backgroundColor: kBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
    );
  }
}
