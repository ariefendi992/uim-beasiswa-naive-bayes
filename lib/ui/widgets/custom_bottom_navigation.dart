import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomBottomNavigation extends StatelessWidget {
  final IconData icons;
  final int index;
  final String titleMenu;
  const CustomBottomNavigation({
    Key? key,
    required this.icons,
    required this.index,
    required this.titleMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<PageCubit>().setPage(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(),
              Icon(
                icons,
                size: 26,
                color: context.read<PageCubit>().state == index
                    ? kBlueColor
                    : kGreyColor,
              ),
              Text(
                titleMenu,
                style: context.read<PageCubit>().state == index
                    ? blueTextStyle
                    : greyTextStyle,
              ),
              SizedBox(),
              // Container(
              //   width: 40,
              //   height: 2,
              //   decoration: BoxDecoration(
              //     color: context.read<PageCubit>().state == index
              //         ? kBlueColor
              //         : kTransparentColor,
              //     borderRadius: BorderRadius.circular(defaultRadius),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}
