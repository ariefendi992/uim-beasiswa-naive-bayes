import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/auth/up_photo_profil_page.dart';
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
                          state.user.picture != null
                              ? CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                      '$imageUrl' '${state.user.picture}'),
                                )
                              : Icon(
                                  CupertinoIcons
                                      .person_crop_circle_badge_checkmark,
                                  size: 36,
                                  color: kWhiteColor,
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
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomMenuUtama(
                        title: 'Data Training',
                        icons: CupertinoIcons.square_list,
                      ),
                      SizedBox(width: 18),
                      CustomMenuUtama(
                        title: 'Data Testing',
                        icons: CupertinoIcons.question_square,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomMenuUtama(
                        title: 'Hasil Uji Data',
                        icons: Icons.checklist_rounded,
                      ),
                      SizedBox(width: 18),
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
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomMenuUtama(
                        title: 'Syarat & Ketentuan',
                        icons: Icons.not_listed_location_rounded,
                      ),
                      SizedBox(width: 18),
                      CustomMenuUtama(
                        title: 'Ubah Password',
                        icons: CupertinoIcons.lock_rotation,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
