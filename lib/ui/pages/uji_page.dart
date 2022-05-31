import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/page_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/ukt/ukt_cubit.dart';
import 'package:ft_uim_naive_bayes/models/penghasilan_ortu_model.dart';
import 'package:ft_uim_naive_bayes/models/prodi_model.dart';
import 'package:ft_uim_naive_bayes/models/semester_model.dart';
import 'package:ft_uim_naive_bayes/services/kategori_service.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_app_bar.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class UjiPage extends StatefulWidget {
  const UjiPage({Key? key}) : super(key: key);

  @override
  _UjiPageState createState() => _UjiPageState();
}

class _UjiPageState extends State<UjiPage> {
  ProdiModel? selectProdi;
  SemesterModel? selectSemester;
  PenghasilanOrtuModel? selectPenghasilan;
  Future<List<ProdiModel>>? prodi;
  Future<List<SemesterModel>>? semester;
  Future<List<PenghasilanOrtuModel>>? penghasilan;
  String? selectStatusMhs, selectKip, selectPkh;
  TextEditingController tanggunganController = TextEditingController();

  @override
  void initState() {
    super.initState();
    prodi = fetchProdi();
    semester = KategoriService().fetchSemester();
    penghasilan = KategoriService().fetchPenghasilanOrtu();
  }

  void setAtribut() async {
    await SecureStorages().setStorage('prodi', selectProdi!.jurusan);
    await SecureStorages().setStorage('semester', selectSemester!.semester);
    await SecureStorages().setStorage('statusMhs', selectStatusMhs);
    await SecureStorages().setStorage('kip', selectKip);
    await SecureStorages()
        .setStorage('penghasilan', selectPenghasilan!.keterangan);
    await SecureStorages().setStorage('pkh', selectPkh);
  }

  @override
  Widget build(BuildContext context) {
    // Widget title() {
    //   return Container(
    //     margin: const EdgeInsets.only(top: 10),
    //     child: Text(
    //       'Uji Kelayakan'.toUpperCase(),
    //       style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
    //     ),
    //   );
    // }

    Widget formInput() {
      Widget inputNama() {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: blackTextStyle.copyWith(),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      enabled: false,
                      initialValue: '${state.user.nama}',
                      cursorColor: kBlackColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusColor: kBlackColor,
                      ),
                    )
                  ],
                ),
              );
            }
            return SizedBox();
          },
        );
      }

      Widget inputProdi() {
        return FutureBuilder(
          future: prodi,
          builder:
              (BuildContext context, AsyncSnapshot<List<ProdiModel>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prodi',
                      style: blackTextStyle.copyWith(),
                    ),
                    SizedBox(height: 6),
                    DropdownButtonFormField(
                      hint: Text('.:: Pilih ::.'),
                      focusColor: kGreyColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusColor: kBlackColor,
                      ),
                      value: selectProdi,
                      items: snapshot.data!.map((ProdiModel item) {
                        return DropdownMenuItem(
                          child: Text(item.jurusan!),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (ProdiModel? value) {
                        setState(() {
                          selectProdi = value;
                          print('value == ${selectProdi!.id}');
                        });
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }

      Widget inputSemester() {
        return FutureBuilder(
          future: semester,
          builder: (BuildContext context,
              AsyncSnapshot<List<SemesterModel>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Semester',
                      style: blackTextStyle.copyWith(),
                    ),
                    SizedBox(height: 6),
                    DropdownButtonFormField(
                      hint: Text('.:: Pilih ::.'),
                      focusColor: kGreyColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusColor: kBlackColor,
                      ),
                      value: selectSemester,
                      items: snapshot.data!
                          .map<DropdownMenuItem<SemesterModel>>(
                              (SemesterModel item) {
                        return DropdownMenuItem(
                          child: Text(item.semester),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (SemesterModel? value) {
                        setState(() {
                          selectSemester = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }

      Widget inputStatusMhs() {
        Map<String, dynamic> statusMhs = {
          'aktif': 'Aktif',
          'cuti': 'Cuti',
        };

        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status Mahasiswa',
                style: blackTextStyle,
              ),
              SizedBox(height: 6),
              DropdownButtonFormField(
                hint: Text('.:: Pilih ::.'),
                value: selectStatusMhs,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusColor: kBlackColor,
                ),
                items: statusMhs.entries.map((value) {
                  return DropdownMenuItem(
                    child: Text(value.value),
                    value: value.key,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectStatusMhs = value.toString();

                    print(value);
                  });
                },
              ),
            ],
          ),
        );
      }

      Widget inputKip() {
        Map<String, dynamic> statusKip = {
          'terima': 'Terima',
          'tidak': 'Tidak',
        };

        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Penerima KiP/Bidik Misi',
                style: blackTextStyle,
              ),
              SizedBox(height: 6),
              DropdownButtonFormField(
                hint: Text('.:: Pilih ::.'),
                value: selectKip,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusColor: kBlackColor,
                ),
                items: statusKip.entries.map(
                  (value) {
                    return DropdownMenuItem(
                      child: Text(value.value),
                      value: value.key,
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectKip = value.toString();
                    print(value);
                  });
                },
              ),
            ],
          ),
        );
      }

      Widget inputPenghasilanOrtu() {
        return FutureBuilder(
          future: penghasilan,
          builder:
              (context, AsyncSnapshot<List<PenghasilanOrtuModel>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penghasilan Orang Tua',
                      style: blackTextStyle,
                    ),
                    SizedBox(height: 6),
                    DropdownButtonFormField(
                      hint: const Text('.:: Pilih ::.'),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        focusColor: kBlackColor,
                      ),
                      value: selectPenghasilan,
                      items: snapshot.data!.map((PenghasilanOrtuModel value) {
                        return DropdownMenuItem(
                          child: Text(value.keterangan),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (PenghasilanOrtuModel? value) {
                        setState(() {
                          selectPenghasilan = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }

      Widget inputTanggungan() {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jumlanh Tanggungan', style: blackTextStyle),
              const SizedBox(height: 6),
              TextFormField(
                controller: tanggunganController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  hintText: 'Jumlah Tanggungan',
                  focusColor: kBlackColor,
                ),
              ),
            ],
          ),
        );
      }

      Widget inputPkh() {
        Map<String, dynamic> listPkh = {
          'terima': 'Terima',
          'tidak': 'Tidak',
        };

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Penerima PKH', style: blackTextStyle),
              const SizedBox(height: 6),
              DropdownButtonFormField(
                focusColor: kBlackColor,
                hint: Text('.:: Pilih ::.'),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  focusColor: kBlackColor,
                ),
                value: selectPkh,
                items: listPkh.entries.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.value),
                    value: item.key,
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectPkh = value;
                    print('pkh === $value');
                  });
                },
              ),
            ],
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 30),
        // padding: const EdgeInsets.symmetric(
        //   vertical: 10,
        //   horizontal: 18,
        // ),
        width: double.infinity,
        decoration: BoxDecoration(
          // color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputNama(),
            inputProdi(),
            inputSemester(),
            inputStatusMhs(),
            inputKip(),
            inputPenghasilanOrtu(),
            inputTanggungan(),
            inputPkh(),
          ],
        ),
      );
    }

    Widget submitButton() {
      return BlocConsumer<UktCubit, UktState>(
        listener: (context, state) {
          if (state is UktSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kLightBlueColor,
                content: Text(
                  'Uji Data Sukses',
                  style: blackTextStyle,
                ),
              ),
            );
            context.read<PageCubit>().setPage(2);
            Navigator.pushNamed(context, '/main');
          } else if (state is UktFailed) {
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
          if (state is UktLaoding) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomButton(
            margin: const EdgeInsets.only(bottom: 40),
            hintText: 'Prediksi Data',
            onPressed: () {
              context.read<UktCubit>().ujiUkt(
                    idProdi: selectProdi!.id!,
                    idSemester: selectSemester!.id,
                    statusMhs: selectStatusMhs!,
                    kip: selectKip!,
                    idPenghasilan: selectPenghasilan!.id,
                    tanggungan: tanggunganController.text,
                    pkh: selectPkh!,
                  );
              setAtribut();
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 90),
                    // title(),
                    formInput(),
                    submitButton(),
                  ],
                ),
              ),
            ),
            CustomAppBar(
                title: 'UJI KELAYAKAN',
                onTap: () {
                  context.read<PageCubit>().setPage(1);
                  Navigator.pushNamed(context, '/main');
                }),
          ],
        ),
      ),
    );
  }
}
