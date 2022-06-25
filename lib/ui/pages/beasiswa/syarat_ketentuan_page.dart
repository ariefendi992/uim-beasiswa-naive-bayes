import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyaratPage extends StatelessWidget {
  const SyaratPage({Key? key}) : super(key: key);

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
                  const SizedBox(height: 35),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<PageCubit>().setPage(3);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/main', (route) => false);
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kTransparentColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/icons/arrow_left.png',
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                        Text(
                          'Syarat dan Ketentuan',
                          style: whiteTextStyle.copyWith(
                              fontSize: 20, fontWeight: medium),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 14, bottom: 10),
                    child: Text(
                      'Syarat Penerima Beasiswa',
                      style: blueTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 14, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('1.', style: greyTextStyle),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Status mahasiswa sedang aktif kuliah',
                                  style: greyTextStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2.', style: greyTextStyle),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Minimal semester berjalan, 3 semester & Maksimal semester 9',
                                  style: greyTextStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('3.', style: greyTextStyle),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Terdaftar sebagai penerima PKH/KKS',
                                  style: greyTextStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('4.', style: greyTextStyle),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Tidak sedang menerima beasiswa KIP/Bidik Misi',
                                  style: greyTextStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
