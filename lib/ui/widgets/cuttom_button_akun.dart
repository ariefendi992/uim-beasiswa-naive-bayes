import 'package:flutter/cupertino.dart';
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
    return Container(
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: blackTextStyle.copyWith(),
            ),
            Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              size: 20,
              color: kBlueColor,
            )
          ],
        ),
      ),
    );
  }
}
