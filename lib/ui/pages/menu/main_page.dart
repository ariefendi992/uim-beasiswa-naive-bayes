import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/menu/beasiswa_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/menu/hasil_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/menu/home_page2.dart';
import 'package:ft_uim_naive_bayes/ui/pages/menu/profil_page.dart';
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
    context.read<AuthCubit>().getProfil();
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
          // margin: EdgeInsets.only(left: 6, right: 6, bottom: 8),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: kWhiteColor,
            // borderRadius: BorderRadius.circular(10),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigation(
                icons: Icons.home,
                index: 0,
                titleMenu: 'Beranda',
              ),
              CustomBottomNavigation(
                icons: CupertinoIcons.square_grid_2x2_fill,
                index: 1,
                titleMenu: 'Data',
              ),
              CustomBottomNavigation(
                icons: Icons.check_box,
                index: 2,
                titleMenu: 'Hasil',
              ),
              CustomBottomNavigation(
                icons: Icons.manage_accounts,
                index: 3,
                titleMenu: 'Akun',
              )
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
