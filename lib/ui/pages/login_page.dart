import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController stambukController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Fakultas Teknik',
                  style:
                      blackTextStyle.copyWith(fontSize: 24, fontWeight: medium),
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: kBlackColor,
                            controller: stambukController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: kBlackColor,
                              ),
                              hintText: 'Stambuk Mahasiswa',
                              focusColor: kBlackColor,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreyColor),
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Tidak Boleh Kosong';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            cursorColor: kBlackColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.vpn_key_sharp,
                                color: kBlackColor,
                              ),
                              hintText: 'Password',
                              focusColor: kBlackColor,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreyColor),
                              ),
                            ),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Tidak Boleh Kosong';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/main', (route) => false);
                      print('state = ${state.props}');
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kRedColor,
                          content: Text(
                            state.error,
                            style: whiteTextStyle,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      hintText: 'Sign In',
                      onPressed: () {
                        context.read<AuthCubit>().signIn(
                            stambuk: stambukController.text,
                            password: passwordController.text);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Sign Up',
                        style: blueTextStyle.copyWith(
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}