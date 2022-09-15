import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        child: Text(
          'Loading...',
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(
            fontSize: 40,
            fontWeight: bold,
          ),
        ),
        baseColor: kBlackColor,
        highlightColor: Colors.yellow,
      ),
    );
  }
}
