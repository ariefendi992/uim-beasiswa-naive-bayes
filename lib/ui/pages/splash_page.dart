import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      autoLogin();
    });
  }

  void autoLogin() async {
    // print(
    //     'read refresh tokken = ${await SecureStorages().readStorage('refresh')};');

    var token = await SecureStorages().readStorage('token');
    // var newToken = await SecureStorages().readStorage('newToken');

    // print('token === $token');
    // print('newToken === $newToken');

    if (token != null) {
      context.read<AuthCubit>().getProfil();
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      // Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Fakultas Teknik',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
            Text(
              'Universitas Islam Makassar',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
