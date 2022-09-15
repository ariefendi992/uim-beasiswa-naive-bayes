import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/upload/upload_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/widgets/custom_button.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

class UploadBerkasPage extends StatefulWidget {
  const UploadBerkasPage({Key? key}) : super(key: key);

  @override
  _UploadBerkasPageState createState() => _UploadBerkasPageState();
}

class _UploadBerkasPageState extends State<UploadBerkasPage> {
  String? idUser;
  FilePickerResult? result;
  File? files;
  PlatformFile? file;

  void getIdUser() async {
    var id = await SecureStorages().readStorage('id_user');
    setState(() {
      idUser = id;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfil();
    // this.result = result;
    this.files = files;
    this.file = file;
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBarColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/main', (route) => false);
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, '/main', (route) => false);
                        },
                        child: Icon(
                          CupertinoIcons.arrow_left,
                          color: kWhiteColor,
                        ),
                      ),
                      Text(
                        'Unggah Berkas',
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
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: 18),
                  decoration: BoxDecoration(color: kBackgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Silahkan unggah berkas anda...',
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      // selectFile(),
                      // onOpenedFile(file!)

                      file != null ? onOpenedFile(file!) : selectFile(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  pickFile() async {
    result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return;

    // file = File(result!.files.single.path!);
    files = File(result!.files.single.path!);
    file = result!.files.first;
    print('path file ${file!.path}');
    setState(() {});
  }

  selectFile() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 48),
        width: double.infinity,
        child: CustomButton(
          height: 40,
          hintText: 'Select File',
          onPressed: () {
            pickFile();
          },
        ),
      ),
    );
  }

  Widget onOpenedFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 2 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    var extension = file.extension;

    return extension.toString().toUpperCase() == 'PDF'
        ? Center(
            child: Container(
              margin: EdgeInsets.only(top: 18),
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      openFile(file);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      height: 100,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: extension == extension
                          ? Image.asset(
                              'assets/images/pdf.png',
                              color: kRedColor,
                            )
                          : Text(
                              'None',
                              style: blackTextStyle.copyWith(
                                fontSize: 28,
                                fontWeight: medium,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    file.name,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Size : $fileSize',
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  ),
                  SizedBox(height: 12),
                  CustomButton(
                    height: 40,
                    hintText: 'Unggah',
                    onPressed: () {
                      setState(() {
                        context.read<UploadCubit>().uploadPdf(
                            idUser: idUser,
                            fieldName: 'berkas',
                            pdfFile: files!);
                      });
                    },
                  ),
                  SizedBox(height: 4),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kRedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        this.file = null;
                      });
                    },
                    child: Center(
                        child: Text(
                      'Batal',
                      style: whiteTextStyle.copyWith(
                          fontWeight: medium, fontSize: 18),
                    )),
                  )
                  // CustomButton(
                  //   height: 40,
                  //   hintText: 'Batal',
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
          )
        : selectFile();
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
