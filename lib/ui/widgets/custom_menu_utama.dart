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
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 10.3,
      // padding: EdgeInsets.only(bottom: 6),
      // margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        // color:,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Center(
            child: Icon(
              icons,
              size: 32,
              color: kBlueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            textAlign: TextAlign.center,
            maxLines: 2,
            // overflow: TextOverflow.,
          )
        ],
      ),
    );
  }
}
