import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/syarat_ketentuan_page.dart';
// import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/cuttom_background_menu_akun.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/cuttom_button_akun.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

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
                  const SizedBox(height: 40),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'AKUN',
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
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
              margin: EdgeInsets.only(top: 100),
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
                      'Pengaturan',
                      style: blueTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                  ),
                  CustomBackgroundMenuAkun(
                    children: [
                      CustomButtonAkun(
                        text: 'Ubah Password',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, bottom: 10),
                    child: Text(
                      'Bantuan',
                      style: blueTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                  ),
                  // SYARAT KETENTUAN BUTTON
                  CustomBackgroundMenuAkun(
                    children: [
                      CustomButtonAkun(
                        text: 'Syarat dan Ketentuan',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SyaratPage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kRedColor,
                            content: Text(state.error),
                          ),
                        );
                      } else if (state is AuthInitial) {
                        context.read<PageCubit>().setPage(0);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: CustomButton(
                              width: double.infinity,
                              hintText: 'Keluar',
                              onPressed: () async {
                                context.read<AuthCubit>().signOut();
                                // await SecureStorages().deleteKey('timeExpire');
                              }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
