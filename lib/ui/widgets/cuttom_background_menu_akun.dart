import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomBackgroundMenuAkun extends StatelessWidget {
  final List<Widget> children;
  const CustomBackgroundMenuAkun({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
