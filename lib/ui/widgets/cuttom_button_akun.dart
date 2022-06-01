import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomButtonAkun extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const CustomButtonAkun({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: blackTextStyle.copyWith(),
      ),
    );
  }
}
