import 'package:flutter/cupertino.dart';
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
    return
        // Container(
        //         margin: EdgeInsets.only(top: 40),
        //         padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             GestureDetector(
        //               onTap: () {
        //                 context.read<PageCubit>().setPage(3);
        //                 Navigator.pushNamedAndRemoveUntil(
        //                     context, '/main', (route) => false);
        //               },
        //               child: Icon(
        //                 CupertinoIcons.arrow_left,
        //                 color: kWhiteColor,
        //               ),
        //             ),
        //             Text(
        //               'Keamanan',
        //               style: whiteTextStyle.copyWith(
        //                 fontSize: 16,
        //                 fontWeight: medium,
        //               ),
        //             ),
        //             SizedBox()
        //           ],
        //         ),
        //       ),

        Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Icon(
              CupertinoIcons.arrow_left,
              color: kWhiteColor,
            ),
          ),
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }
}
