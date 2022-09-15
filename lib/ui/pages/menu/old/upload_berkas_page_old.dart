import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/ui/pages/others/list_file_page.dart';
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
  PlatformFile? file;
  List<PlatformFile>? files;

  void getIdUser() async {
    var id = await SecureStorages().readStorage('id_user');
    setState(() {
      idUser = id;
      print('id user == $idUser');
    });
  }

  @override
  void initState() {
    super.initState();
    getIdUser();
    this.file = file;
    context.read<AuthCubit>().getProfil();
  }

  void uploadFiles() async {
    // result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg']);
    // if (result == null) return;
    // file = result!.files.first;

    result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;
    openFiles(result!.files);
    // openFile(file!);
    // print('file name == ${file!.name}');
    // print('file bytes == ${file!.bytes}');
    // print('file size == ${file!.size}');
    // print('file extension == ${file!.extension}');
    // print('file path == ${file!.path}');

    // context.read<UploadCubit>().uploadPdf(idUser: idUser, fieldName: fieldName, pdfFile: pdfFile)
  }

  // void getFiles()

  @override
  Widget build(BuildContext context) {
    Widget buttonSelect() {
      return Center(
        child: Container(
          width: 200,
          height: 40,
          child: TextButton(
            onPressed: () {
              setState(() {
                uploadFiles();
              });
            },
            child: Center(
              child: Text(
                'Pilih File',
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: kBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      );
    }

    // ignore: unused_element
    Widget onGetFile() {
      Widget buildFile(PlatformFile file) {
        final kb = file.size / 1024;
        final mb = kb / 1024;
        final fileSize = mb >= 2
            ? '${mb.toStringAsFixed(2)} MB'
            : '${kb.toStringAsFixed(2)} KB';
        final extension = file.extension ?? 'none';
        // final color =;

        return InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kGreenClor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '.$extension',
                      style: whiteTextStyle.copyWith(
                        fontSize: 28,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  file.name,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  fileSize,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                )
              ],
            ),
          ),
        );
      }

      return Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: files!.length,
          itemBuilder: (context, index) {
            final file = files![index];
            return buildFile(file);
          },
        ),
      );
    }

    // Widget buttonUnggah() {
    //   return Container(
    //     padding: EdgeInsets.symmetric(horizontal: 90),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         TextButton(
    //           onPressed: () {
    //             setState(() {});
    //           },
    //           child: Text(
    //             'Batal',
    //             style: whiteTextStyle,
    //           ),
    //           style: TextButton.styleFrom(
    //             backgroundColor: kRedColor,
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             setState(() {
    //               // uploadImage();
    //               context.read<AuthCubit>().getProfil();

    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 SnackBar(
    //                   backgroundColor: kGreenClor,
    //                   content: Text(
    //                     'Ungah Berhasil...',
    //                     style: whiteTextStyle.copyWith(fontSize: 16),
    //                   ),
    //                 ),
    //               );
    //             });
    //           },
    //           child: Text(
    //             'Unggah',
    //             style: whiteTextStyle,
    //           ),
    //           style: TextButton.styleFrom(
    //             backgroundColor: kBlueColor,
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

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
                      SizedBox(height: 20),
                      buttonSelect(),
                      SizedBox(height: 8),
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

  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ListFilePage(
            files: files,
            onOpenedFile: openFile,
          ),
        ),
      );

  void openFile(PlatformFile pathFile) {
    OpenFile.open(pathFile.path);
  }
}
