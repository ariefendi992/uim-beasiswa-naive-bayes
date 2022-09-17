import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/ukt/hasil_ukt_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/loading_widget.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/utils/extensions.dart';

class HasilPage extends StatefulWidget {
  const HasilPage({Key? key}) : super(key: key);

  @override
  _HasilPageState createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  String? idUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getIdUser();

    Timer((Duration(seconds: 5)), () {
      setState(() {
        isLoading = false;
      });
    });
    // this.id = id;
    // context.read<HasilUktCubit>().fetchOneUkt(idUser: '$id');
  }

  void getIdUser() async {
    var id = await SecureStorages().readStorage('id_user');
    setState(() {
      idUser = id;
      print('id user == $idUser');
      context.read<HasilUktCubit>().fetchOneUkt(idUser: idUser!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          'HASIL KEPUTUSAN',
                          style: whiteTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<HasilUktCubit, HasilUktState>(
              builder: (context, state) {
                if (state is HasilUktLoading) {
                  return Container(
                    margin: EdgeInsets.only(top: 70),
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: LoadingWidget(),
                  );
                } else if (state is HasilUktSuccess) {
                  if (state.hasilUkt.length == 0) {
                    return Container(
                      margin: EdgeInsets.only(top: 70),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Anda belum melakukan\nRegistrasi lanjutan',
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(top: 70),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hasil Keputusan',
                            style: blueTextStyle.copyWith(
                              fontWeight: semiBold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.prodi != null
                                          ? kGreenClor
                                          : kTransparentColor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: kWhiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Program Studi',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text('${state.hasilUkt.single.prodi}',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.prodi != null
                                          ? kGreenClor
                                          : kTransparentColor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: kWhiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Semester',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text('${state.hasilUkt.single.semester}',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.prodi != null
                                          ? kGreenClor
                                          : kTransparentColor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: kWhiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Penerima KIP',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text(
                                    '${state.hasilUkt.single.kip}'
                                        .toTitleCase(),
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.prodi != null
                                          ? kGreenClor
                                          : kTransparentColor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: kWhiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Penghasilan Ortu',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text(
                                    '${state.hasilUkt.single.penghasilan}'
                                        .toTitleCase(),
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.prodi != null
                                          ? kGreenClor
                                          : kTransparentColor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: kWhiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Jumlah Tanggungan',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text(
                                    '${state.hasilUkt.single.tanggungan} Orang'
                                        .toTitleCase(),
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.prodi != null
                                          ? kGreenClor
                                          : kTransparentColor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: kWhiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Penerma PKH',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text(
                                    '${state.hasilUkt.single.pkh}'
                                        .toTitleCase(),
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium)),
                              ],
                            ),
                          ),
                          SizedBox(height: 18),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: state.hasilUkt.single.kelaykan !=
                                              'layak'
                                          ? kRedColor
                                          : kGreenClor,
                                      border: state.hasilUkt.single.prodi !=
                                              null
                                          ? Border.all(color: kTransparentColor)
                                          : Border.all(
                                              color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: state.hasilUkt.single.kelaykan !=
                                            'layak'
                                        ? Icon(
                                            CupertinoIcons.exclamationmark,
                                            color: kWhiteColor,
                                            size: 15,
                                          )
                                        : Icon(
                                            Icons.check,
                                            color: kWhiteColor,
                                            size: 15,
                                          ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'KEPUTUSAN',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                                Spacer(),
                                Text(
                                  '${state.hasilUkt.single.kelaykan}'
                                      .toUpperCase(),
                                  style:
                                      state.hasilUkt.single.kelaykan != 'layak'
                                          ? redTextStyle.copyWith(
                                              fontWeight: medium)
                                          : blueTextStyle.copyWith(
                                              fontWeight: medium),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Container(
                  margin: EdgeInsets.only(top: 70),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Bad request',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
