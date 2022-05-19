import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomMenuUtama extends StatelessWidget {
  final String title;
  const CustomMenuUtama({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: kLightBlueColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_copy,
              size: 48,
              color: kBlueColor,
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: blackTextStyle.copyWith(),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
