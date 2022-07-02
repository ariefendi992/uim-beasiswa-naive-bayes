import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/auth/check_password_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/auth/up_photo_profil_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa/penerima_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa/syarat_ketentuan_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa/uji_page.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_menu_utama.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 35),
              child: Center(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess) {
                      return Column(
                        children: [
                          Text(
                            'Selamat Datang',
                            style: whiteTextStyle.copyWith(
                                fontSize: 22, fontWeight: medium),
                          ),
                          SizedBox(height: 8),
                          state.user.picture == null
                              ? Icon(
                                  CupertinoIcons
                                      .person_crop_circle_badge_checkmark,
                                  size: 36,
                                  color: kWhiteColor,
                                )
                              : CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                      '$imageUrl' '${state.user.picture}'),
                                ),
                          SizedBox(height: 8),
                          Text(
                            '${state.user.nama!.toUpperCase()}',
                            style: whiteTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: medium,
                            ),
                          ),
                          Text(
                            '${state.user.prodi}',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                            ),
                          ),
                          SizedBox(),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 240),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 215),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => PenerimaPage());
                            Navigator.pushAndRemoveUntil(
                                context, route, (route) => false);
                          },
                          child: CustomMenuUtama(
                            title: 'Data Training',
                            icons: CupertinoIcons.square_list,
                          ),
                        ),
                        SizedBox(width: 18),
                        GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => UjiPage());
                            Navigator.pushAndRemoveUntil(
                                context, route, (route) => false);
                          },
                          child: CustomMenuUtama(
                            title: 'Form Registrasi',
                            icons: CupertinoIcons.question_square,
                          ),
                        ),
                        SizedBox(width: 18),
                        GestureDetector(
                          onTap: () {
                            context.read<PageCubit>().setPage(2);
                            Navigator.pushNamed(context, '/main');
                          },
                          child: CustomMenuUtama(
                            title: 'Hasil Keputusan',
                            icons: Icons.checklist_rounded,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UploadPoho(),
                                ),
                                (route) => false);
                          },
                          child: CustomMenuUtama(
                            title: 'Ubah Photo Profil',
                            icons: CupertinoIcons.profile_circled,
                          ),
                        ),
                        SizedBox(width: 18),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SyaratPage(),
                              ),
                            );
                          },
                          child: CustomMenuUtama(
                            title: 'Syarat & Ketentuan',
                            icons: Icons.not_listed_location_rounded,
                          ),
                        ),
                        SizedBox(width: 18),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckPasswordPage(),
                                ),
                                (route) => false);
                          },
                          child: CustomMenuUtama(
                            title: 'Ubah Password',
                            icons: CupertinoIcons.lock_rotation,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
