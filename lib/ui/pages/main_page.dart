import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/hasil_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/home_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/profil_page.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_bottom_navigation.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return BeasiswaPage();
        case 2:
          return HasilPage();
        case 3:
          return ProfilPage();
        default:
          return HomePage();
      }
    }

    Widget bottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(left: 24, right: 24, bottom: 20),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigation(icons: Icons.home, index: 0),
              CustomBottomNavigation(icons: Icons.dashboard, index: 1),
              CustomBottomNavigation(icons: Icons.check_box, index: 2),
              CustomBottomNavigation(icons: Icons.manage_accounts, index: 3)
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              content(currentIndex),
              bottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}
