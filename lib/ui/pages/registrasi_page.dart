import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_text_form_field.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class RegistrasiPage extends StatefulWidget {
  RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController stambukController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          'Daftar akun anda untuk\nmendapatkan hak akses',
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
      );
    }

    Widget formInput() {
      Widget inputNim() {
        return CustomFormInput(
          title: 'Stambuk',
          controller: stambukController,
        );
      }

      Widget inputNama() {
        return CustomFormInput(
          title: 'Nama',
          controller: namaController,
        );
      }

      Widget inputGender() {
        final list = ['laki-laki', 'perempuan'];

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jenis Kelamin',
                style: blackTextStyle.copyWith(),
              ),
              SizedBox(
                height: 6,
              ),
              DropdownButtonFormField(
                focusColor: kGreyColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      borderSide: BorderSide(color: kBlackColor)),
                  focusColor: kBlackColor,
                ),
                hint: Text('.:: Pilih ::.'),
                value: selectedGender,
                items: list.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedGender = value;
                  print(value);
                },
              )
            ],
          ),
        );
      }

      // Widget inputGenders() {
      //   return CustomFormInput(
      //     title: 'Gender',
      //     controller: genderController,
      //   );
      // }

      Widget inputEmail() {
        return CustomFormInput(
          title: 'Email',
          controller: emailController,
        );
      }

      Widget inputPassword() {
        return CustomFormInput(
          title: 'Password',
          controller: passwordController,
          obSecureText: true,
        );
      }

      Widget buttonSubmit() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kLightBlueColor,
                  content: Text('Registrasi Sukses'),
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
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
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return CustomButton(
              margin: EdgeInsets.only(top: 10),
              hintText: 'Sign Up',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().register(
                        stambuk: stambukController.text,
                        nama: namaController.text,
                        // gender: genderController.text,
                        gender: selectedGender!,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                }
              },
            );
          },
        );
      }

      return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              inputNim(),
              inputNama(),
              inputGender(),
              inputEmail(),
              // inputGenders(),
              inputPassword(),
              buttonSubmit(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        children: [
          title(),
          formInput(),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Anda sudah punya akun? '),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Sign In',
                  style: blueTextStyle.copyWith(
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
