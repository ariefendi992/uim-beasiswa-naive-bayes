import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController confirmasiPasswordController = TextEditingController();
  var focusNode = FocusNode();
  bool obscureText = true;
  bool isPasswordSixCharacters = false;
  String? idUser;

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
    getIdUser();
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
                // ---------------- Konfirmasi password baru
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.padlock,
                      size: 24,
                      color: kBlueColor,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: TextFormField(
                        focusNode: focusNode,
                        cursorColor: kGreyColor,
                        showCursor: true,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Password Baru',
                          labelStyle: TextStyle(color: kBlackColor),
                          focusColor: kBlackColor,
                          hoverColor: kGreyColor,
                          border: InputBorder.none,
                        ),
                        controller: confirmasiPasswordController,
                        onChanged: (password) => onPasswordChange(password),
                      ),
                    ),
                    IconButton(
                      onPressed: showHide,
                      icon: obscureText == false
                          ? Icon(
                              CupertinoIcons.eye,
                              color: kBlueColor,
                              size: 24,
                            )
                          : Icon(
                              CupertinoIcons.eye_slash,
                              size: 24,
                            ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade400,
                  height: 0,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 550),
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
                SizedBox(height: 80),
                Container(
                    height: 45,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => UpdatePasswordPage(),
                          //   ),
                          // );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: kGreenClor,
                              content: Text('Password telah diganti!.')));
                          setState(() {
                            context.read<AuthCubit>().getProfil();
                          });
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
                            width: double.infinity,
                            hintText: 'Update Password',
                            onPressed: () {
                              context.read<AuthCubit>().updatePassword(
                                  idUser: idUser!,
                                  password: confirmasiPasswordController.text);
                            });
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
