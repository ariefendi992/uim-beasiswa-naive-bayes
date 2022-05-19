import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:ft_uim_naive_bayes/utils/extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi...\n${state.user.nama!.toTitleCase()}',
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: medium),
                      ),
                      CircleAvatar(
                        maxRadius: 25,
                        child: Center(
                            child: Text(
                          '${state.user.nama!.characters.first.toUpperCase()}',
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: medium,
                          ),
                        )),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    Widget body() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
          top: 30,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Menu Utama',
            //   style:
            //       blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            // ),
            // const SizedBox(height: 12),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       CustomMenuUtama(
            //         title: 'Beasiswa UKT',
            //       ),
            //       // CustomMenuUtama(
            //       //   title: 'Beasiswa KIP',
            //       // ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 30),
            Text(
              'Persyaratan Penerima Beasiswa UKT :',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
            ),
            Text(
              '- Status mahasiswa sedang aktif kuliah\n'
              '- Minimal semester berjalan, 3 semester & Maksimal semester 9\n'
              '- Terdaftar sebagai penerima PKH/KKS\n'
              '- Tidak sedang menerima beasiswa KIP/Bidik Misi\n',
              style: blackTextStyle.copyWith(height: 2),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 30,
      strokeWidth: 2,
      child: ListView(
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
