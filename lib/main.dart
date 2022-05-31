import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/kategori/prodi_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/ukt/training_ukt_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/ukt/ukt_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/pages/login_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/main_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/registrasi_page.dart';
import 'package:ft_uim_naive_bayes/ui/pages/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => UktCubit(),
        ),
        BlocProvider(
          create: (context) => TrainingUktCubit(),
        ),
        BlocProvider(
          create: (context) => ProdiCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistrasiPage(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
