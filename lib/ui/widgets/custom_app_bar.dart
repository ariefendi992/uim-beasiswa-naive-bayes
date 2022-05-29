import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomAppBar extends StatelessWidget {
  final Function() onTap;
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: kBarColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40.0,
              height: 40.0,
              padding:
                  EdgeInsets.only(top: 13, bottom: 13, right: 17.5, left: 15),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/icons/arrow_left.png',
              ),
            ),
          ),
          Text(
            title,
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
