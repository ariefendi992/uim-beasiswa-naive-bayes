import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/pages/auth/update_password_page.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckPasswordPage extends StatefulWidget {
  const CheckPasswordPage({Key? key}) : super(key: key);

  @override
  _CheckPasswordPageState createState() => _CheckPasswordPageState();
}

class _CheckPasswordPageState extends State<CheckPasswordPage> {
  bool obscureText = true;
  String? password;
  TextEditingController passwordController = TextEditingController();
  var focusNode = FocusNode();
  String? idUser;

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
    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
    getIdUser();
    super.initState();
  }

  void getIdUser() async {
    var id = await SecureStorages().readStorage('id_user');
    setState(() {
      idUser = id;
      print('id user == $idUser');
    });
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
                  'Keamanan',
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
            // padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding, top: ),
            padding: EdgeInsets.symmetric(horizontal: 38, vertical: 18),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: kBackgroundColor),
            child: Column(
              children: [
                Text(
                  'Silahkan masukkan password kamu saat ini untuk menjaga keamanan akun',
                  style: blackTextStyle,
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.lock_fill,
                      size: 26,
                      color: kBlueColor,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: TextFormField(
                        focusNode: focusNode,
                        cursorColor: kBlackColor,
                        showCursor: false,
                        // validator: (val) => val!.length < 6
                        //     ? 'Password minimal 6 karakter'
                        //     : '',
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Password Lama',
                          labelStyle:
                              TextStyle(color: kBlackColor, fontSize: 18),
                          focusColor: kBlackColor,
                          hoverColor: kGreyColor,
                          border: InputBorder.none,
                        ),
                        // onSaved: (val) => password = val,
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
                  color: kGreyColor,
                  height: 0,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isPasswordSixCharacters
                            ? kGreenClor
                            : kTransparentColor,
                        border: isPasswordSixCharacters
                            ? Border.all(color: kTransparentColor)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: kWhiteColor,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Panjang karakter minimsl 6")
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 120),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdatePasswordPage(),
                          ),
                        );
                        print('state === ${state.props}');
                      }

                      if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kRedColor,
                            content: Text('${state.error}'),
                          ),
                        );
                        print('${state.error}');
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        hintText: 'Lanjutkan',
                        onPressed: () {
                          context.read<AuthCubit>().checkPassword(
                                idUser: idUser!,
                                password: passwordController.text,
                              );
                          print('pass == ${passwordController.text}');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
