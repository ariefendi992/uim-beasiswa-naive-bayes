import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa/penerima_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa/uji_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/beasiswa/upload_berkas_page.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/cuttom_background_menu_akun.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/cuttom_button_akun.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeasiswaPage extends StatefulWidget {
  const BeasiswaPage({Key? key}) : super(key: key);

  @override
  _BeasiswaPageState createState() => _BeasiswaPageState();
}

class _BeasiswaPageState extends State<BeasiswaPage> {
  bool isLoading = false;
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'BEASISWA',
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12, bottom: 10),
                    child: Text(
                      'Data Beasiswa',
                      style: blueTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                  ),
                  CustomBackgroundMenuAkun(
                    children: [
                      CustomButtonAkun(
                        text: 'Data Training Beasiswa',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PenerimaPage(),
                            ),
                          );
                        },
                      ),
                      CustomButtonAkun(
                        text: 'Form Registrasi Beasiswa',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UjiPage(),
                            ),
                          );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => UploadPoho(),
                          //   ),
                          // );
                        },
                      ),
                      CustomButtonAkun(
                        text: 'Upload Berkas',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadBerkasPage(),
                              ),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
