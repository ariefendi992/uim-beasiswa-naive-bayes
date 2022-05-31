import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomMenuBeasiswa extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomMenuBeasiswa({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: kBlueColor,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: blackTextStyle.copyWith(
                fontSize: 16, fontWeight: medium, letterSpacing: 0.9),
          )
        ],
      ),
    );
  }
}
