import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/cubit/auth/auth_cubit.dart';
import 'package:ft_uim_naive_bayes/cubit/upload/upload_cubit.dart';
import 'package:ft_uim_naive_bayes/storage/storage.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_uim_naive_bayes/utils/url.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadPoho extends StatefulWidget {
  const UploadPoho({Key? key}) : super(key: key);

  @override
  _UploadPohoState createState() => _UploadPohoState();
}

class _UploadPohoState extends State<UploadPoho> {
  File? imageFile;
  String? idUser;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(imagePicked!.path);
    setState(() {});
  }

  void uploadImage() async {
    final url = '$baseUrl/auth/update-picture?id=$idUser';
    final request = http.MultipartRequest('PUT', Uri.parse(url));
    request.files.add(http.MultipartFile(
        'file', imageFile!.readAsBytes().asStream(), imageFile!.lengthSync(),
        filename: imageFile!.path.split('/').last));

    final response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    // setState(() {

    // });
  }

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
    this.imageFile = imageFile;
    getIdUser();
    
    context.read<AuthCubit>().getProfil();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageView() {
      return Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 200,
          width: double.infinity,
          child: Image.file(
            imageFile!,
          ),
        ),
      );
    }

    Widget buttonSelect() {
      return Center(
        child: Container(
          width: 200,
          height: 40,
          child: TextButton(
            onPressed: () async {
              await getImage();
            },
            child: Center(
              child: Text(
                'Pilih Foto',
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

    Widget buttonUnggah() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  imageFile = null;
                });
              },
              child: Text(
                'Batal',
                style: whiteTextStyle,
              ),
              style: TextButton.styleFrom(
                backgroundColor: kRedColor,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // uploadImage();
                  context.read<AuthCubit>().getProfil();
                  context.read<UploadCubit>().uploadImage(
                      idUser: idUser,
                      fieldName: 'image',
                      imageFile: imageFile!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kGreenClor,
                      content: Text(
                        'Ungah Berhasil...',
                        style: whiteTextStyle.copyWith(fontSize: 16),
                      ),
                    ),
                  );
                  imageFile = null;
                });
              },
              child: Text(
                'Unggah',
                style: whiteTextStyle,
              ),
              style: TextButton.styleFrom(
                backgroundColor: kBlueColor,
              ),
            ),
          ],
        ),
      );
    }

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
                          'Unggah Foto Profil',
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
                          'Silahkan unggah foto profil anda.',
                          style: blackTextStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        imageFile != null ? imageView() : SizedBox(),
                        imageFile != null ? buttonUnggah() : buttonSelect()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
