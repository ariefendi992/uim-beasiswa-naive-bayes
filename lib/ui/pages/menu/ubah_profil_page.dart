import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/models/user_model.dart';
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
  _UbahProfilPageState createState() => _UbahProfilPageState();
}

class _UbahProfilPageState extends State<UbahProfilPage> {
  late bool readOnly, stambukReadOnly, prodiRO;
  late FocusNode myFocusNode;
  late FocusNode stambukFocusNode;
  late FocusNode prodiFocus;
  late TextEditingController namaController = TextEditingController();
  late TextEditingController stambukController = TextEditingController();
  late TextEditingController prodiController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readOnly = true;
    stambukReadOnly = true;
    prodiRO = true;
    myFocusNode = FocusNode();
    prodiFocus = FocusNode();
    stambukFocusNode = FocusNode();
    namaController.text = '${widget.users.nama}';
    stambukController.text = '${widget.users.stambuk}';
    prodiController.text = '${widget.users.prodi}';
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    namaController.dispose();
    stambukController.dispose();
    stambukFocusNode.dispose();
    prodiController.dispose();
    prodiFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                margin: const EdgeInsets.only(top: 260),
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
                        });
                      },
                    ),
                    CustomButton(
                        margin: const EdgeInsets.only(top: 30),
                        hintText: 'Simpan',
                        onPressed: () {
                          print('nama = ${namaController.text}');
                        })
                  ],
                )),
          ),
          Container(
            height: 235,
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
                                  backgroundImage: NetworkImage(
                                      '$baseUrl ${widget.users.picture}'),
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
        ],
      ),
    );
  }
}
