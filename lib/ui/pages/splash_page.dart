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
  DateTime? ex;
  Timer? timeDel;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfil();

    Timer(Duration(seconds: 5), () {
      autoLogin();
    });
  }

  void autoLogin() async {
    var readToken = await SecureStorages().readStorage('token');
    // var readNewToken = await SecureStorages().readStorage('newToken');

    // var token = readToken ?? readNewToken;
    var token = readToken;

    print('token == $token');
    if (token == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Center(
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
                SizedBox(height: 20),
                Text(
                  'Aplikasi Pendukung Keputusan\nPenerima Beasiswa',
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Fakultas Teknik',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      // fontWeight: no,
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
          ),
        ],
      ),
    );
  }
}
