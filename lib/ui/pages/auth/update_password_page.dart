import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  var focusNode = FocusNode();
  bool obscureText = true;
  bool isPasswordSixCharacters = false;

  onPasswordChange(String password) {
    // final numericRegex = RegExp(r'[0-9]');

    setState(() {
      isPasswordSixCharacters = false;
      if (password.length >= 6) {
        isPasswordSixCharacters = true;
      }
    });
  }

  void showHide() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBarColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<PageCubit>().setPage(3);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                  },
                  child: Icon(
                    CupertinoIcons.arrow_left,
                    color: kWhiteColor,
                  ),
                ),
                Text(
                  'Ubah Password',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
            decoration: BoxDecoration(color: kBackgroundColor),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.padlock,
                      size: 26,
                      color: kBlueColor,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: TextFormField(
                        focusNode: focusNode,
                        cursorColor: kBlackColor,
                        showCursor: false,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Password Baru',
                          labelStyle:
                              TextStyle(color: kBlackColor, fontSize: 18),
                          focusColor: kBlackColor,
                          hoverColor: kGreyColor,
                          border: InputBorder.none,
                        ),
                        controller: passwordController,
                        onChanged: (password) => onPasswordChange(password),
                      ),
                    ),
                    IconButton(
                      onPressed: showHide,
                      icon: obscureText == false
                          ? Icon(
                              CupertinoIcons.eye,
                              color: kBlueColor,
                              size: 26,
                            )
                          : Icon(
                              CupertinoIcons.eye_slash,
                              size: 28,
                            ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade400,
                  height: 0,
                ),

                // ---------------- Konfirmasi password baru
                const SizedBox(height: 18),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.padlock,
                      size: 26,
                      color: kBlueColor,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: TextFormField(
                        focusNode: focusNode,
                        cursorColor: kBlackColor,
                        showCursor: false,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Password Baru',
                          labelStyle:
                              TextStyle(color: kBlackColor, fontSize: 18),
                          focusColor: kBlackColor,
                          hoverColor: kGreyColor,
                          border: InputBorder.none,
                        ),
                        controller: passwordController,
                        onChanged: (password) => onPasswordChange(password),
                      ),
                    ),
                    IconButton(
                      onPressed: showHide,
                      icon: obscureText == false
                          ? Icon(
                              CupertinoIcons.eye,
                              color: kBlueColor,
                              size: 26,
                            )
                          : Icon(
                              CupertinoIcons.eye_slash,
                              size: 28,
                            ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade400,
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
