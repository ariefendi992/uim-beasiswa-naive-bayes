import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomMenuUtama extends StatelessWidget {
  final String title;
  final IconData icons;
  const CustomMenuUtama({
    Key? key,
    required this.title,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        width: 97,
        height: 95,
        padding: EdgeInsets.symmetric(horizontal: 2),
        // margin: EdgeInsets.only(right: 12, left: 12),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icons,
                size: 48,
                color: kBlueColor,
              ),
              SizedBox(height: 6),
              Text(
                title.toUpperCase(),
                style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 12),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
