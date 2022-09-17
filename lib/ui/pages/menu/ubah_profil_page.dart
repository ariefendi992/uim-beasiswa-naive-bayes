import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/models/user_model.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/pages/auth/up_photo_profil_page.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_field_edit_profil.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';

class UbahProfilPage extends StatefulWidget {
  final UserModel users;
  const UbahProfilPage(this.users, {Key? key}) : super(key: key);

  @override
  _UbahProfilPageState createState() => _UbahProfilPageState(this.users);
}

class _UbahProfilPageState extends State<UbahProfilPage> {
  late bool readOnly, stambukReadOnly, prodiRO, genderRO, emailRO;
  late FocusNode myFocusNode;
  late FocusNode stambukFocusNode;
  late FocusNode prodiFocus, genderFocus, emailFocus;
  late TextEditingController namaController = TextEditingController();
  late TextEditingController stambukController = TextEditingController();
  late TextEditingController prodiController = TextEditingController();
  late TextEditingController genderController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  String? idUser;
  UserModel users;
  _UbahProfilPageState(this.users);

  @override
  void initState() {
    super.initState();
    getIdUser();

    readOnly = true;
    stambukReadOnly = true;
    prodiRO = true;
    emailRO = true;
    genderRO = true;
    myFocusNode = FocusNode();
    prodiFocus = FocusNode();
    genderFocus = FocusNode();
    emailFocus = FocusNode();
    stambukFocusNode = FocusNode();
    namaController.text = '${users.nama}';
    stambukController.text = '${users.stambuk}';
    prodiController.text = '${users.prodi}';
    genderController.text = '${users.gender}';
    emailController.text = '${users.email}';
    context.read<AuthCubit>().getProfil();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    stambukFocusNode.dispose();
    prodiFocus.dispose();
    genderFocus.dispose();
    emailFocus.dispose();
    namaController.dispose();
    stambukController.dispose();
    prodiController.dispose();
    genderController.dispose();
    emailController.dispose();
  }

  void getIdUser() async {
    var id = await SecureStorages().readStorage('id_user');
    print('id user = $id');
    setState(() {
      idUser = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            decoration: BoxDecoration(
              color: kBarColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: kWhiteColor,
                          radius: 55,
                          child: widget.users.picture != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage('$imageUrl'
                                      '${users.picture!}'),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor: kGreyColor,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: kGreyColor,
                                    child: Image.asset(
                                      'assets/images/user_default.png',
                                      color: kWhiteColor,
                                      // height: 100,
                                      // width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(height: 14),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return UploadPoho();
                            }));
                          },
                          child: Text(
                            'Ganti Photo',
                            style: whiteTextStyle.copyWith(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: <Widget>[
                  CustomFieldProfil(
                    controller: namaController,
                    label: 'Nama Lengkap',
                    readOnly: readOnly,
                    focusNode: myFocusNode,
                    onPressed: () {
                      setState(() {
                        myFocusNode.requestFocus();
                        readOnly = false;
                        stambukReadOnly = true;
                        prodiRO = true;
                        genderRO = true;
                        emailRO = true;
                      });
                    },
                  ),
                  CustomFieldProfil(
                    controller: stambukController,
                    label: 'Stambuk',
                    readOnly: stambukReadOnly,
                    focusNode: stambukFocusNode,
                    onPressed: () {
                      setState(() {
                        stambukFocusNode.requestFocus();
                        stambukReadOnly = false;
                        prodiRO = true;
                        readOnly = true;
                        genderRO = true;
                        emailRO = true;
                      });
                    },
                  ),
                  CustomFieldProfil(
                    controller: prodiController,
                    label: 'Prodi',
                    readOnly: prodiRO,
                    focusNode: prodiFocus,
                    onPressed: () {
                      setState(() {
                        prodiFocus.requestFocus();
                        prodiRO = false;
                        readOnly = true;
                        stambukReadOnly = true;
                        genderRO = true;
                        emailRO = true;
                      });
                    },
                  ),
                  CustomFieldProfil(
                    controller: genderController,
                    label: 'Jenis Kelamin',
                    readOnly: genderRO,
                    focusNode: genderFocus,
                    onPressed: () {
                      setState(() {
                        genderFocus.requestFocus();
                        genderRO = false;
                        readOnly = true;
                        stambukReadOnly = true;
                        prodiRO = true;
                        emailRO = true;
                      });
                    },
                  ),
                  CustomFieldProfil(
                    controller: emailController,
                    label: 'E-Mail',
                    readOnly: emailRO,
                    focusNode: emailFocus,
                    onPressed: () {
                      setState(() {
                        emailFocus.requestFocus();
                        readOnly = true;
                        stambukReadOnly = true;
                        prodiRO = true;
                        genderRO = true;
                        emailRO = false;
                      });
                    },
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: kBlueColor,
                          content: Text(
                            'Data telah di perbaharui.',
                            style: whiteTextStyle.copyWith(),
                          ),
                        ));
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: CustomButton(
                            color: kBlueColor,
                            margin: const EdgeInsets.only(top: 20),
                            height: 45,
                            hintText: 'Simpan',
                            onPressed: () {
                              context.read<AuthCubit>().editUser(
                                    idUser: idUser!,
                                    nama: namaController.text,
                                    stambuk: stambukController.text,
                                    prodi: prodiController.text,
                                    gender: genderController.text.toLowerCase(),
                                    email: emailController.text,
                                  );
                            }),
                      );
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}
